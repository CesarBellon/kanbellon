import 'package:freezed_annotation/freezed_annotation.dart';
import '../models/app_data.dart';

part 'kanban_state.freezed.dart';

@freezed
abstract class KanbanState with _$KanbanState {
  const factory KanbanState({
    @Default(AppData()) AppData data,
    String? selectedWorkspaceId,
    String? selectedBoardId,
    @Default(false) bool isLoading,
    @Default(true) bool isConfigured, // Assume configured until checked
    String? error,
  }) = _KanbanState;
}
