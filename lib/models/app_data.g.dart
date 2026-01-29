// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AppData _$AppDataFromJson(Map<String, dynamic> json) => _AppData(
  workspaces:
      (json['workspaces'] as List<dynamic>?)
          ?.map((e) => Workspace.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$AppDataToJson(_AppData instance) => <String, dynamic>{
  'workspaces': instance.workspaces,
};
