// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workspace.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Workspace _$WorkspaceFromJson(Map<String, dynamic> json) => _Workspace(
  id: json['id'] as String,
  title: json['title'] as String,
  boards:
      (json['boards'] as List<dynamic>?)
          ?.map((e) => KanbanBoard.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$WorkspaceToJson(_Workspace instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'boards': instance.boards,
    };
