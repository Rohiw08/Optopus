// ignore_for_file: invalid_annotation_target

import 'package:flow_canvas/flow_canvas.dart';
import 'package:flow_canvas/src/features/viewport/domain/viewport.dart';
import 'package:flow_canvas/src/features/connections/domain/connection_state.dart';
import 'package:flow_canvas/src/features/edges/domain/edge_index.dart';
import 'package:flow_canvas/src/features/edges/domain/edge_state.dart';
import 'package:flow_canvas/src/features/handles/domain/handle_state.dart';
import 'package:flow_canvas/src/features/nodes/domain/node_state.dart';
import 'package:flutter/painting.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flow_canvas/src/features/nodes/domain/node_index.dart';
import 'package:flow_canvas/src/core/utils/json_converters.dart';
part 'flow_canvas_state.freezed.dart';
part 'flow_canvas_state.g.dart';

@freezed
abstract class FlowCanvasState with _$FlowCanvasState {
  const FlowCanvasState._();

  const factory FlowCanvasState({
    // Core graph data
    @Default({}) @NodeMapConverter() Map<String, FlowNode> nodes,
    @Default({}) Map<String, FlowEdge> edges,

    // Runtime node/edge/handle states
    @Default({})
    @JsonKey(ignore: true)
    Map<String, NodeRuntimeState> nodeStates,
    @Default({})
    @JsonKey(ignore: true)
    Map<String, EdgeRuntimeState> edgeStates,
    @Default({})
    @JsonKey(ignore: true)
    Map<String, HandleRuntimeState> handleStates,

    // Selection and z-ordering
    @Default({}) Set<String> selectedNodes,
    @Default({}) Set<String> selectedEdges,
    @Default(0) int minZIndex,
    @Default(0) int maxZIndex,

    // --- FIX START ---
    // Make these nullable so .fromJson can instantiate the class without them.
    // Since they are ignored in JSON, they will be null when loading from file.
    @JsonKey(includeFromJson: false, includeToJson: false) NodeIndex? nodeIndex,
    @JsonKey(includeFromJson: false, includeToJson: false) EdgeIndex? edgeIndex,
    // --- FIX END ---

    // Viewport
    @Default(FlowViewport()) FlowViewport viewport,
    @SizeConverter() Size? viewportSize,
    @Default(false) bool isPanZoomLocked,

    // Interaction state
    @Default(DragMode.none) @JsonKey(ignore: true) DragMode dragMode,
    @JsonKey(ignore: true) FlowConnection? activeConnection,
    @Default(FlowConnectionRuntimeState.idle())
    @JsonKey(ignore: true)
    FlowConnectionRuntimeState connectionState,
    @Default(Rect.zero)
    @RectConverter()
    @JsonKey(ignore: true)
    Rect selectionRect,
    @Default('') @JsonKey(ignore: true) String hoveredEdgeId,
    @Default('') @JsonKey(ignore: true) String lastClickedEdgeId,
  }) = _FlowCanvasState;

  // Ideally, add this explicitly so the analyzer knows the method exists on the mixin
  @override
  Map<String, dynamic> toJson() =>
      throw UnimplementedError('toJson should be generated');

  factory FlowCanvasState.fromJson(Map<String, dynamic> json) =>
      _$FlowCanvasStateFromJson(json);

  factory FlowCanvasState.initial() => FlowCanvasState(
        nodeIndex: NodeIndex.empty(),
        edgeIndex: EdgeIndex.empty(),
      );
}
