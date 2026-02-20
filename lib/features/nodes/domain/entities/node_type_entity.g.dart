// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'node_type_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_NodeTypeEntity _$NodeTypeEntityFromJson(Map<String, dynamic> json) =>
    _NodeTypeEntity(
      type: json['type'] as String,
      description: json['description'] as String,
      domain: json['domain'] as String,
      canConnect: json['can_connect'] as bool,
    );

Map<String, dynamic> _$NodeTypeEntityToJson(_NodeTypeEntity instance) =>
    <String, dynamic>{
      'type': instance.type,
      'description': instance.description,
      'domain': instance.domain,
      'can_connect': instance.canConnect,
    };
