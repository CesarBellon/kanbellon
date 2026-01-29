import 'package:freezed_annotation/freezed_annotation.dart';
import 'kanban_card.dart';

part 'kanban_list.freezed.dart';
part 'kanban_list.g.dart';

@freezed
abstract class KanbanList with _$KanbanList {
  const factory KanbanList({
    required String id,
    required String title,
    @Default([]) List<KanbanCard> cards,
  }) = _KanbanList;

  factory KanbanList.fromJson(Map<String, dynamic> json) => 
      _$KanbanListFromJson(json);
}
