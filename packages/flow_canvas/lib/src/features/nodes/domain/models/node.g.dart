// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'node.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FlowNode<T> _$FlowNodeFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    _FlowNode<T>(
      id: json['id'] as String,
      parentId: json['parentId'] as String?,
      type: json['type'] as String,
      position: const OffsetConverter()
          .fromJson(json['position'] as Map<String, dynamic>),
      data: fromJsonT(json['data']),
      size: json['size'] == null
          ? const Size(200, 100)
          : const SizeConverter()
              .fromJson(json['size'] as Map<String, dynamic>),
      zIndex: (json['zIndex'] as num?)?.toInt() ?? 0,
      handles: (json['handles'] as Map<String, dynamic>?)?.map(
            (k, e) =>
                MapEntry(k, FlowHandle.fromJson(e as Map<String, dynamic>)),
          ) ??
          const {},
      hidden: json['hidden'] as bool? ?? false,
      draggable: json['draggable'] as bool? ?? true,
      selectable: json['selectable'] as bool? ?? true,
      hoverable: json['hoverable'] as bool? ?? true,
      connectable: json['connectable'] as bool? ?? true,
      deletable: json['deletable'] as bool? ?? true,
      focusable: json['focusable'] as bool? ?? true,
      expandParent: json['expandParent'] as bool? ?? false,
    );

Map<String, dynamic> _$FlowNodeToJson<T>(
  _FlowNode<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'id': instance.id,
      'parentId': instance.parentId,
      'type': instance.type,
      'position': const OffsetConverter().toJson(instance.position),
      'data': toJsonT(instance.data),
      'size': const SizeConverter().toJson(instance.size),
      'zIndex': instance.zIndex,
      'handles': instance.handles,
      'hidden': instance.hidden,
      'draggable': instance.draggable,
      'selectable': instance.selectable,
      'hoverable': instance.hoverable,
      'connectable': instance.connectable,
      'deletable': instance.deletable,
      'focusable': instance.focusable,
      'expandParent': instance.expandParent,
    };
