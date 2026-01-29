import 'package:freezed_annotation/freezed_annotation.dart';
import 'kanban_list.dart';

part 'kanban_board.freezed.dart';
part 'kanban_board.g.dart';

@freezed
abstract class KanbanBoard with _$KanbanBoard {
  const factory KanbanBoard({
    required String id,
    required String title,
    @Default([]) List<KanbanList> lists,
  }) = _KanbanBoard;

  factory KanbanBoard.fromJson(Map<String, dynamic> json) => 
      _$KanbanBoardFromJson(json);
}
