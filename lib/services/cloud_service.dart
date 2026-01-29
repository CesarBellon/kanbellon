import 'dart:convert';
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:googleapis_auth/auth_io.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../models/app_data.dart';

class CloudService {
  drive.DriveApi? _driveApi;
  AuthClient? _client;
  
  bool get isSignedIn => _client != null;

  // The file ID of 'kanban_data.json' in Drive.
  String? _driveFileId;
  static const String _fileName = 'kanban_data.json';
  
  // SharedPreferences keys
  static const String _prefKeyClientId = 'drive_client_id';
  static const String _prefKeyClientSecret = 'drive_client_secret';
  static const String _prefKeyAccessToken = 'drive_access_token';
  static const String _prefKeyRefreshToken = 'drive_refresh_token';
  static const String _prefKeyTokenExpiry = 'drive_token_expiry';

  /// Initialize and attempt to restore previous session
  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    final clientId = prefs.getString(_prefKeyClientId);
    final clientSecret = prefs.getString(_prefKeyClientSecret);
    final accessToken = prefs.getString(_prefKeyAccessToken);
    final refreshToken = prefs.getString(_prefKeyRefreshToken);
    final expiryString = prefs.getString(_prefKeyTokenExpiry);
    
    if (clientId != null && clientSecret != null && accessToken != null && refreshToken != null && expiryString != null) {
      try {
        final expiry = DateTime.parse(expiryString);
        final credentials = AccessCredentials(
          AccessToken('Bearer', accessToken, expiry),
          refreshToken,
          [drive.DriveApi.driveFileScope, drive.DriveApi.driveAppdataScope],
        );
        
        final identifier = ClientId(clientId, clientSecret);
        _client = autoRefreshingClient(identifier, credentials, http.Client());
        _driveApi = drive.DriveApi(_client!);
        await _findDriveFile();
      } catch (e) {
        print("Failed to restore Drive session: $e");
        await _clearCredentials();
      }
    }
  }

  Future<void> signIn(String clientId, String clientSecret) async {
    final identifier = ClientId(clientId, clientSecret);
    final scopes = [drive.DriveApi.driveFileScope, drive.DriveApi.driveAppdataScope];

    try {
        _client = await clientViaUserConsent(identifier, scopes, (url) {
            launchUrl(Uri.parse(url));
        });
        
        if (_client != null) {
            _driveApi = drive.DriveApi(_client!);
            await _findDriveFile();
            
            // Save credentials
            await _saveCredentials(clientId, clientSecret, _client as AutoRefreshingAuthClient);
        }
    } catch (e) {
        throw Exception("Failed to sign in: $e");
    }
  }

  Future<void> _saveCredentials(String clientId, String clientSecret, AutoRefreshingAuthClient client) async {
    final prefs = await SharedPreferences.getInstance();
    final credentials = client.credentials;
    
    await prefs.setString(_prefKeyClientId, clientId);
    await prefs.setString(_prefKeyClientSecret, clientSecret);
    await prefs.setString(_prefKeyAccessToken, credentials.accessToken.data);
    await prefs.setString(_prefKeyRefreshToken, credentials.refreshToken ?? '');
    await prefs.setString(_prefKeyTokenExpiry, credentials.accessToken.expiry.toIso8601String());
  }

  Future<void> _clearCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_prefKeyClientId);
    await prefs.remove(_prefKeyClientSecret);
    await prefs.remove(_prefKeyAccessToken);
    await prefs.remove(_prefKeyRefreshToken);
    await prefs.remove(_prefKeyTokenExpiry);
  }

  Future<void> signOut() async {
    _client?.close();
    _client = null;
    _driveApi = null;
    _driveFileId = null;
    await _clearCredentials();
  }
  
  Future<void> _findDriveFile() async {
      if (_driveApi == null) return;
      
      // Search in Application Data folder or root? 
      // User asked for "Cloud Sync", App Data folder is cleaner but harder for user to see/manage manually.
      // Root folder is visible. Let's start with Root or specific folder.
      // For simplicity: Root, searching by name.
      
      final fileList = await _driveApi!.files.list(
          q: "name = '$_fileName' and trashed = false",
          spaces: 'drive',
          $fields: 'files(id, name)'
      );
      
      if (fileList.files != null && fileList.files!.isNotEmpty) {
          _driveFileId = fileList.files!.first.id;
      }
  }

  Future<AppData?> downloadData() async {
      if (_driveApi == null) return null;
      
      // Refresh finding ID in case it was created elsewhere
      if (_driveFileId == null) await _findDriveFile();
      if (_driveFileId == null) return null; // No file on drive

      try {
          final drive.Media media = await _driveApi!.files.get(_driveFileId!, downloadOptions: drive.DownloadOptions.fullMedia) as drive.Media;
          
          final List<int> dataStore = [];
          await media.stream.forEach((element) {
             dataStore.addAll(element);
          });
          
          final jsonString = utf8.decode(dataStore);
          final jsonMap = jsonDecode(jsonString);
          return AppData.fromJson(jsonMap);
          
      } catch (e) {
          print("Error downloading from Drive: $e");
          return null;
      }
  }

  Future<void> uploadData(AppData data) async {
      if (_driveApi == null) return;
      
      final jsonString = jsonEncode(data.toJson());
      final bytes = utf8.encode(jsonString);
      final media = drive.Media(Stream.value(bytes), bytes.length);
      
      if (_driveFileId != null) {
          // Update existing
          await _driveApi!.files.update(
              drive.File(), 
              _driveFileId!, 
              uploadMedia: media
          );
      } else {
          // Create new
          final fileMetadata = drive.File(name: _fileName);
          final file = await _driveApi!.files.create(
              fileMetadata, 
              uploadMedia: media
          );
          _driveFileId = file.id;
      }
  }
}
