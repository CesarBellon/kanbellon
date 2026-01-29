// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kanban_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_KanbanList _$KanbanListFromJson(Map<String, dynamic> json) => _KanbanList(
  id: json['id'] as String,
  title: json['title'] as String,
  cards:
      (json['cards'] as List<dynamic>?)
          ?.map((e) => KanbanCard.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$KanbanListToJson(_KanbanList instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'cards': instance.cards,
    };
