import 'package:freezed_annotation/freezed_annotation.dart';
import 'kanban_board.dart';

part 'workspace.freezed.dart';
part 'workspace.g.dart';

@freezed
abstract class Workspace with _$Workspace {
  const factory Workspace({
    required String id,
    required String title,
    @Default([]) List<KanbanBoard> boards,
  }) = _Workspace;

  factory Workspace.fromJson(Map<String, dynamic> json) => 
      _$WorkspaceFromJson(json);
}
