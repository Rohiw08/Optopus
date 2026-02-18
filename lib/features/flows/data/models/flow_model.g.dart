// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flow_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FlowModel _$FlowModelFromJson(Map<String, dynamic> json) => _FlowModel(
  id: json['id'] as String,
  collectionId: json['collection_id'] as String,
  name: json['name'] as String,
  data: json['data'] as Map<String, dynamic>? ?? const {},
  createdAt: DateTime.parse(json['created_at'] as String),
  updatedAt: DateTime.parse(json['updated_at'] as String),
);

Map<String, dynamic> _$FlowModelToJson(_FlowModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'collection_id': instance.collectionId,
      'name': instance.name,
      'data': instance.data,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
    };
