// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flow_canvas_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FlowCanvasState _$FlowCanvasStateFromJson(Map<String, dynamic> json) =>
    _FlowCanvasState(
      nodes: json['nodes'] == null
          ? const {}
          : const NodeMapConverter()
              .fromJson(json['nodes'] as Map<String, dynamic>),
      edges: (json['edges'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, FlowEdge.fromJson(e as Map<String, dynamic>)),
          ) ??
          const {},
      selectedNodes: (json['selectedNodes'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toSet() ??
          const {},
      selectedEdges: (json['selectedEdges'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toSet() ??
          const {},
      minZIndex: (json['minZIndex'] as num?)?.toInt() ?? 0,
      maxZIndex: (json['maxZIndex'] as num?)?.toInt() ?? 0,
      viewport: json['viewport'] == null
          ? const FlowViewport()
          : FlowViewport.fromJson(json['viewport'] as Map<String, dynamic>),
      viewportSize: _$JsonConverterFromJson<Map<String, dynamic>, Size>(
          json['viewportSize'], const SizeConverter().fromJson),
      isPanZoomLocked: json['isPanZoomLocked'] as bool? ?? false,
    );

Map<String, dynamic> _$FlowCanvasStateToJson(_FlowCanvasState instance) =>
    <String, dynamic>{
      'nodes': const NodeMapConverter().toJson(instance.nodes),
      'edges': instance.edges,
      'selectedNodes': instance.selectedNodes.toList(),
      'selectedEdges': instance.selectedEdges.toList(),
      'minZIndex': instance.minZIndex,
      'maxZIndex': instance.maxZIndex,
      'viewport': instance.viewport,
      'viewportSize': _$JsonConverterToJson<Map<String, dynamic>, Size>(
          instance.viewportSize, const SizeConverter().toJson),
      'isPanZoomLocked': instance.isPanZoomLocked,
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
