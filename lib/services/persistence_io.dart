import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:file_selector/file_selector.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/app_data.dart';
import '../models/workspace.dart';
import '../models/kanban_board.dart';
import '../models/kanban_list.dart';
import '../models/kanban_card.dart';
import 'persistence_service.dart';

import 'package:path/path.dart' as p;

class FilePersistenceService implements PersistenceService {
  File? _dataFile;
  static const String _prefKeyDataPath = 'kanban_data_path';

  @override
  Future<void> init() async {
    // Auto-init on Mobile
    if (Platform.isAndroid || Platform.isIOS) {
       final dir = await getApplicationDocumentsDirectory();
       _dataFile = File('${dir.path}/kanban_data.json');
       return;
    }

    final prefs = await SharedPreferences.getInstance();
    final path = prefs.getString(_prefKeyDataPath);
    if (path != null) {
      final file = File(path);
      if (await file.exists()) {
        _dataFile = file;
      }
    }
  }

  @override
  Future<void> setPath(String path) async {
    final file = File(path);
    _dataFile = file;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_prefKeyDataPath, file.path);
  }

  @override
  Future<void> save(AppData data) async {
    if (_dataFile == null) return;
    try {
      // Prepare img directory
      final imgDir = Directory(p.join(_dataFile!.parent.path, 'img'));
      if (!await imgDir.exists()) {
        await imgDir.create(recursive: true);
      }

      // Deep copy and modify data to extract images
      final cleanWorkspaces = <Workspace>[];
      
      for (final ws in data.workspaces) {
        final cleanBoards = <KanbanBoard>[];
        for (final board in ws.boards) {
          final cleanLists = <KanbanList>[];
          for (final list in board.lists) {
             final cleanCards = <KanbanCard>[];
             for (final card in list.cards) {
                if (card.imageBase64 != null && card.imageBase64!.isNotEmpty) {
                    // Check if it is valid base64 (and not already a path)
                    // We assume it returns to base64 in memory, so if it doesn't start with img/ it's likely data
                    if (!card.imageBase64!.startsWith('img/')) {
                        try {
                            final bytes = base64Decode(card.imageBase64!);
                            final fileName = '${card.id}.png';
                            final filePath = p.join(imgDir.path, fileName);
                            final file = File(filePath);
                            await file.writeAsBytes(bytes);
                            
                            cleanCards.add(card.copyWith(imageBase64: 'img/$fileName'));
                            continue;
                        } catch (e) {
                            print("Error saving image for card ${card.id}: $e");
                        }
                    }
                }
                cleanCards.add(card);
             }
             cleanLists.add(list.copyWith(cards: cleanCards));
          }
           cleanBoards.add(board.copyWith(lists: cleanLists));
        }
        cleanWorkspaces.add(ws.copyWith(boards: cleanBoards));
      }

      final cleanData = data.copyWith(workspaces: cleanWorkspaces);
      final jsonString = jsonEncode(cleanData.toJson());
      await _dataFile!.writeAsString(jsonString);
    } catch (e) {
      print('Error saving data: $e');
    }
  }

  @override
  Future<AppData?> load() async {
    if (_dataFile == null) return null;
    try {
      final jsonString = await _dataFile!.readAsString();
      if (jsonString.isEmpty) return null;
      final jsonMap = jsonDecode(jsonString);
      final rawData = AppData.fromJson(jsonMap);

      // Reinject images from disk to memory
      final parentPath = _dataFile!.parent.path;
      final enrichedWorkspaces = <Workspace>[];

      for (final ws in rawData.workspaces) {
        final enrichedBoards = <KanbanBoard>[];
        for (final board in ws.boards) {
          final enrichedLists = <KanbanList>[];
          for (final list in board.lists) {
             final enrichedCards = <KanbanCard>[];
             for (final card in list.cards) {
                if (card.imageBase64 != null && card.imageBase64!.startsWith('img/')) {
                    try {
                       final fullPath = p.join(parentPath, card.imageBase64!);
                       final file = File(fullPath);
                       if (await file.exists()) {
                           final bytes = await file.readAsBytes();
                           final base64String = base64Encode(bytes);
                           enrichedCards.add(card.copyWith(imageBase64: base64String));
                           continue;
                       }
                    } catch (e) {
                        print("Error loading image for card ${card.id}: $e");
                    }
                }
                enrichedCards.add(card);
             }
             enrichedLists.add(list.copyWith(cards: enrichedCards));
          }
          enrichedBoards.add(board.copyWith(lists: enrichedLists));
        }
        enrichedWorkspaces.add(ws.copyWith(boards: enrichedBoards));
      }

      return rawData.copyWith(workspaces: enrichedWorkspaces);
    } catch (e) {
      print('Error loading data: $e');
      return null;
    }
  }

  @override
  Future<void> exportData(AppData data) async {
    final FileSaveLocation? result = await getSaveLocation(
      suggestedName: 'kanban_export_${DateTime.now().toIso8601String()}.json',
    );
    if (result == null) return;

    final String jsonString = jsonEncode(data.toJson());
    final Uint8List fileData = Uint8List.fromList(utf8.encode(jsonString));
    final XFile file = XFile.fromData(fileData, mimeType: 'application/json');
    await file.saveTo(result.path);
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
        throw Exception("Invalid JSON format or incompatible data: $e");
    }
  }

  @override
  Future<bool> isConfigured() async {
    return _dataFile != null;
  }
}

PersistenceService getPersistenceService() => FilePersistenceService();
