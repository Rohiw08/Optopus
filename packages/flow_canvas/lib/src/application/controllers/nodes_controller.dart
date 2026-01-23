import 'dart:async';
import 'package:flow_canvas/src/application/controllers/selection_controller.dart';
import 'package:flow_canvas/src/application/flow_canvas_internal_controller.dart';
import 'package:flow_canvas/src/application/services/edge_service.dart';
import 'package:flow_canvas/src/application/services/node_service.dart';
import 'package:flow_canvas/src/domain/flow_canvas_state.dart';
import 'package:flow_canvas/src/domain/models/node.dart';
import 'package:flow_canvas/src/domain/state/node_state.dart';
import 'package:flow_canvas/src/shared/enums.dart';
import 'package:flow_canvas/src/shared/providers.dart';
import 'package:flutter/material.dart';

class NodesController {
  NodesController({
    required FlowCanvasInternalController controller,
    required NodeService nodeService,
    required EdgeService edgeService,
    required SelectionController selectionController,
  })  : _controller = controller,
        _nodeService = nodeService,
        _edgeService = edgeService,
        _selectionController = selectionController;

  final FlowCanvasInternalController _controller;
  final NodeService _nodeService;
  final EdgeService _edgeService;
  final SelectionController _selectionController;

  Map<String, Offset>? _dragStartPositions;
  Set<String> _nodesBeingDragged = {};

  FlowNode? getNode(String nodeId) {
    return _nodeService.getNode(
      _controller.currentState,
      nodeId,
    );
  }

  NodeRuntimeState? getNodeRuntimeState(String nodeId) {
    return _nodeService.getNodeRuntimeState(
      _controller.currentState,
      nodeId,
    );
  }

  void addNode(FlowNode node) {
    if (_controller.currentState.nodes.containsKey(node.id)) {
      throw ArgumentError('Node with id ${node.id} already exists');
    }
    _controller.mutate((s) => _nodeService.addNode(s, node));
  }

  void addNodes(List<FlowNode> nodes) {
    for (var node in nodes) {
      if (_controller.currentState.nodes.containsKey(node.id)) {
        throw ArgumentError('Node with id ${node.id} already exists');
      }
    }
    _controller.mutate((s) => _nodeService.addNodes(s, nodes));
  }

  void removeNode(String nodeId) {
    removeNodes({nodeId});
  }

  void removeSelectedNodes() {
    final state = _controller.currentState;
    if (state.selectedNodes.isEmpty) return;

    final removedNodeIds = Set<String>.from(state.selectedNodes);
    removeNodes(removedNodeIds);
  }

  void removeNodes(Iterable<String> nodeIds) {
    final oldState = _controller.currentState;
    if (nodeIds.isEmpty) return;
    final removedNodeIds = nodeIds.toSet();

    final edgeIds = _edgeService.getEdgesFromNodes(oldState, nodeIds);
    final stateAfterEdges = _edgeService.removeEdges(oldState, edgeIds);
    _controller.updateStateOnly(stateAfterEdges);

    final newState =
        _nodeService.removeNodes(stateAfterEdges, removedNodeIds.toList());
    _controller.mutate((_) => newState);
  }

  void updateNode(FlowNode node) {
    final oldNode = _nodeService.getNode(_controller.currentState, node.id);
    if (oldNode == null || oldNode == node) return;

    _controller.mutate((s) => _nodeService.updateNode(s, node));
  }

  void updateNodeRuntimeState(String nodeId, NodeRuntimeState node) {
    final oldState = _controller.currentState;
    final oldNodeState = _nodeService.getNodeRuntimeState(oldState, nodeId);
    if (oldNodeState == null || oldNodeState == node) return;
    _controller.updateStateOnly(
        _nodeService.updateNodeRuntimeState(oldState, nodeId, node));
  }

  void onNodeTap(String nodeId, TapDownDetails details, bool isSelectable) {
    final state = _controller.currentState;
    if (isSelectable && !state.selectedNodes.contains(nodeId)) {
      _selectionController.selectNode(nodeId, addToSelection: false);
    }
  }

  void onNodeDragStart(
      String nodeId, DragStartDetails details, bool isSelectable) {
    final node = getNode(nodeId);
    if (node == null) return;

    final bool isDraggable = node.draggable ?? true;
    if (!isDraggable) return;

    final initialState = _controller.currentState;
    final isAlreadySelected = initialState.selectedNodes.contains(nodeId);

    FlowCanvasState stateAfterSelection = initialState;

    if (isSelectable && !isAlreadySelected) {
      _selectionController.selectNode(nodeId, addToSelection: false);
      stateAfterSelection = _controller.currentState;
    }

    if (isAlreadySelected) {
      _nodesBeingDragged = Set.from(stateAfterSelection.selectedNodes);
    } else {
      _nodesBeingDragged = {nodeId};
    }

    // Pre-calculate including descendants for performance
    _nodesBeingDragged =
        _nodeService.getDescendants(stateAfterSelection, _nodesBeingDragged);

    _dragStartPositions = {};
    for (final id in _nodesBeingDragged) {
      final n = stateAfterSelection.nodes[id];
      if (n != null && (n.draggable ?? true)) {
        _dragStartPositions![id] = n.position;
      }
    }

    _nodesBeingDragged
        .retainWhere((id) => _dragStartPositions!.containsKey(id));
    _controller
        .updateStateOnly(stateAfterSelection.copyWith(dragMode: DragMode.node));
  }

  void onNodeDragUpdate(DragUpdateDetails details) {
    if (_controller.currentState.dragMode != DragMode.node) return;

    _moveNodesBy(details.delta, details, _nodesBeingDragged);
    _handleAutoPan(details.globalPosition);
  }

  void onNodeDragEnd(DragEndDetails details) {
    _stopAutoPan();
    if (_dragStartPositions == null) return;
    final currentState = _controller.currentState;
    for (final id in _nodesBeingDragged) {
      final startPos = _dragStartPositions![id];
      if (startPos != null && currentState.nodes[id]?.position != startPos) {
        break;
      }
    }

    _controller.mutate((s) {
      return s.copyWith(dragMode: DragMode.none);
    });

    _dragStartPositions = null;
    _nodesBeingDragged.clear();
  }

  // --- Auto Pan Logic ---
  Timer? _autoPanTimer;
  Offset _autoPanVelocity = Offset.zero;

  void _handleAutoPan(Offset globalPosition) {
    final options = _controller.ref.read(flowOptionsProvider);
    final viewportSize = _controller.currentState.viewportSize;
    if (viewportSize == null) return;

    // Convert global position to local canvas position
    final renderBox = _controller.viewportKey.currentContext?.findRenderObject()
        as RenderBox?;
    if (renderBox == null) return;

    final localPos = renderBox.globalToLocal(globalPosition);
    final margin = options.viewportOptions.autoPanMargin;
    final speed = options.viewportOptions.autoPanSpeed;

    double dx = 0;
    double dy = 0;

    // Check edges
    if (localPos.dx < margin) {
      dx = speed;
    } else if (localPos.dx > viewportSize.width - margin) {
      dx = -speed;
    }

    if (localPos.dy < margin) {
      dy = speed;
    } else if (localPos.dy > viewportSize.height - margin) {
      dy = -speed;
    }

    if (dx == 0 && dy == 0) {
      _stopAutoPan();
      return;
    }

    _autoPanVelocity = Offset(dx, dy);

    if (_autoPanTimer == null || !_autoPanTimer!.isActive) {
      _autoPanTimer = Timer.periodic(const Duration(milliseconds: 16), (_) {
        _performAutoPan();
      });
    }
  }

  void _performAutoPan() {
    if (_autoPanVelocity == Offset.zero) return;

    // 1. Pan the viewport
    _controller.viewport.panBy(_autoPanVelocity);

    // 2. Move the nodes in the opposite direction to keep them under the cursor
    // We need to convert screen velocity to canvas delta
    final zoom = _controller.currentState.viewport.zoom;
    final canvasDelta = -_autoPanVelocity / zoom;

    _controller.updateStateOnly(_nodeService.moveNodes(
        _controller.currentState, _nodesBeingDragged, canvasDelta,
        includeDescendants: false));

    // Also update edge geometry
    _controller.edgeGeometryService
        .updateEdgesForNodes(_controller.currentState, _nodesBeingDragged);
  }

  void _stopAutoPan() {
    _autoPanTimer?.cancel();
    _autoPanTimer = null;
    _autoPanVelocity = Offset.zero;
  }

  void _moveNodesBy(
    Offset screenDelta,
    DragUpdateDetails details,
    Set<String> nodesToMove,
  ) {
    if (_controller.currentState.dragMode != DragMode.node) return;
    if (nodesToMove.isEmpty) return; // Nothing to move

    final cartesianDelta =
        _controller.coordinateConverter.toCartesianDelta(screenDelta);

    if (cartesianDelta == Offset.zero) return;

    // Use the generic `moveNodes` service, not `moveSelectedNodes`
    // We already have the full set of nodes (including descendants), so skip traversal
    _controller.updateStateOnly(_nodeService.moveNodes(
        _controller.currentState, nodesToMove, cartesianDelta,
        includeDescendants: false));

    _controller.edgeGeometryService
        .updateEdgesForNodes(_controller.currentState, nodesToMove);

    final movedNodePositions = <String, Offset>{};
    for (final nodeId in nodesToMove) {
      final node = _controller.currentState.nodes[nodeId];
      if (node != null) {
        movedNodePositions[nodeId] = node.position;
      }
    }
  }

  void onNodeMouseEnter(String nodeId, PointerEvent details) {
    final nodeState =
        _nodeService.getNodeRuntimeState(_controller.currentState, nodeId);
    if (nodeState == null) return;
    _controller.updateStateOnly(_nodeService.updateNodeRuntimeState(
        _controller.currentState, nodeId, nodeState.copyWith(hovered: true)));
  }

  void onNodeMouseMove(String nodeId, PointerEvent details) {}

  void onNodeMouseLeave(String nodeId, PointerEvent details) {
    final nodeState =
        _nodeService.getNodeRuntimeState(_controller.currentState, nodeId);
    if (nodeState == null) return;
    _controller.updateStateOnly(_nodeService.updateNodeRuntimeState(
        _controller.currentState, nodeId, nodeState.copyWith(hovered: false)));
  }
}
