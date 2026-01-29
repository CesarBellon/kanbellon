import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:file_selector/file_selector.dart';
import 'dart:typed_data';

import '../models/app_data.dart';
import 'persistence_service.dart';

class WebPersistenceService implements PersistenceService {
  static const String _dataKey = 'kanban_web_data';

  @override
  Future<void> init() async {
    // No specific initialization needed for SharedPreferences
  }

  @override
  Future<void> save(AppData data) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(data.toJson());
    await prefs.setString(_dataKey, jsonString);
  }

  @override
  Future<AppData?> load() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_dataKey);
    if (jsonString == null || jsonString.isEmpty) return null;
    
    try {
      final jsonMap = jsonDecode(jsonString);
      return AppData.fromJson(jsonMap);
    } catch (e) {
      print('Error loading web data: $e');
      return null;
    }
  }

  @override
  Future<void> exportData(AppData data) async {
    final String jsonString = jsonEncode(data.toJson());
    final Uint8List fileData = Uint8List.fromList(utf8.encode(jsonString));
    
    final String fileName = 'kanban_export_${DateTime.now().millisecondsSinceEpoch}.json';
    
    final XFile file = XFile.fromData(
        fileData,
        mimeType: 'application/json',
        name: fileName
    );
    
    // FileSelector on web triggers download
    await file.saveTo(fileName); 
  }

  @override
  Future<AppData?> importData() async {
     const XTypeGroup typeGroup = XTypeGroup(
      label: 'json',
      extensions: <String>['json'],
    );
    final XFile? file = await openFile(acceptedTypeGroups: <XTypeGroup>[typeGroup]);
    if (file == null) return null;

    final String content = await file.readAsString();
    try {
        final jsonMap = jsonDecode(content);
        return AppData.fromJson(jsonMap);
    } catch (e) {
        print("Error importing data: $e");
        return null;
    }
  }

  @override
  Future<bool> isConfigured() async => true; // Web always has localStorage

  @override
  Future<void> setPath(String path) async {
    // No-op for web
  }
}

PersistenceService getPersistenceService() => WebPersistenceService();
