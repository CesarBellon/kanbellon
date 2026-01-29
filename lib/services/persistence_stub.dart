import '../models/app_data.dart';
import 'persistence_service.dart';

class PersistenceStub implements PersistenceService {
  @override
  Future<void> init() async => throw UnimplementedError();
  @override
  Future<void> save(AppData data) async => throw UnimplementedError();
  @override
  Future<AppData?> load() async => throw UnimplementedError();
  @override
  Future<void> exportData(AppData data) async => throw UnimplementedError();
  @override
  Future<AppData?> importData() async => throw UnimplementedError();
  @override
  Future<bool> isConfigured() async => throw UnimplementedError();
  @override
  Future<void> setPath(String path) async => throw UnimplementedError();
}

PersistenceService getPersistenceService() => PersistenceStub();
