// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kanban_board.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_KanbanBoard _$KanbanBoardFromJson(Map<String, dynamic> json) => _KanbanBoard(
  id: json['id'] as String,
  title: json['title'] as String,
  lists:
      (json['lists'] as List<dynamic>?)
          ?.map((e) => KanbanList.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$KanbanBoardToJson(_KanbanBoard instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'lists': instance.lists,
    };
