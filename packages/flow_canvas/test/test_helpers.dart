import 'package:flow_canvas/src/domain/flow_canvas_state.dart';
import 'package:flow_canvas/src/domain/indexes/edge_index.dart';
import 'package:flow_canvas/src/domain/indexes/node_index.dart';
import 'package:flow_canvas/src/domain/models/node.dart';
import 'package:flow_canvas/src/domain/state/node_state.dart';
import 'package:flutter/painting.dart';

/// Creates a test FlowCanvasState with optional initial nodes.
FlowCanvasState createTestState({
  Map<String, FlowNode>? nodes,
  Map<String, NodeRuntimeState>? nodeStates,
  Set<String>? selectedNodes,
  int maxZIndex = 0,
}) {
  final nodeMap = nodes ?? {};
  final nodeIndex = nodeMap.isEmpty
      ? NodeIndex.empty()
      : NodeIndex.fromNodes(nodeMap.values);

  return FlowCanvasState(
    nodes: nodeMap,
    nodeStates: nodeStates ?? {},
    selectedNodes: selectedNodes ?? {},
    maxZIndex: maxZIndex,
    nodeIndex: nodeIndex,
    edgeIndex: EdgeIndex.empty(),
  );
}

/// Creates a test FlowNode with sensible defaults.
FlowNode createTestNode({
  required String id,
  String type = 'test',
  Offset position = const Offset(100, 100),
  Size size = const Size(200, 100),
  int zIndex = 0,
  Map<String, dynamic>? data,
  bool? draggable,
  bool? selectable,
  bool expandParent = false,
}) {
  return FlowNode.create(
    id: id,
    type: type,
    position: position,
    size: size,
    zIndex: zIndex,
    data: data ?? {},
    draggable: draggable,
    selectable: selectable,
    expandParent: expandParent,
  );
}

/// Creates a test NodeRuntimeState with defaults.
NodeRuntimeState createTestNodeRuntimeState({
  bool selected = false,
  bool hovered = false,
  bool dragging = false,
  bool resizing = false,
}) {
  return NodeRuntimeState(
    selected: selected,
    hovered: hovered,
    dragging: dragging,
    resizing: resizing,
  );
}
