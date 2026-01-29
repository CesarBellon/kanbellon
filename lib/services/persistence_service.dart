import '../models/app_data.dart';

abstract class PersistenceService {
  Future<void> init();
  Future<void> save(AppData data);
  Future<AppData?> load();
  Future<void> exportData(AppData data);
  Future<AppData?> importData();
  Future<bool> isConfigured();
  Future<void> setPath(String path);
}
