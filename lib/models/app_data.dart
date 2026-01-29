import 'package:freezed_annotation/freezed_annotation.dart';
import 'workspace.dart';

part 'app_data.freezed.dart';
part 'app_data.g.dart';

@freezed
abstract class AppData with _$AppData {
  const factory AppData({
    @Default([]) List<Workspace> workspaces,
    // Add other top-level app settings here if needed
  }) = _AppData;

  factory AppData.fromJson(Map<String, dynamic> json) => 
      _$AppDataFromJson(json);
}
