// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kanban_card.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_KanbanCard _$KanbanCardFromJson(Map<String, dynamic> json) => _KanbanCard(
  id: json['id'] as String,
  title: json['title'] as String,
  description: json['description'] as String? ?? '',
  imageBase64: json['image_base64'] as String?,
);

Map<String, dynamic> _$KanbanCardToJson(_KanbanCard instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'image_base64': instance.imageBase64,
    };
