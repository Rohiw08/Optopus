import 'package:flow_canvas/src/features/selection/application/selection_controller.dart';
import 'package:flow_canvas/src/core/canvas/flow_canvas_internal_controller.dart';
import 'package:flow_canvas/src/features/edges/application/edge_geometry_service.dart';
import 'package:flow_canvas/src/features/edges/application/edge_service.dart';
import 'package:flow_canvas/src/features/edges/domain/model/edge.dart';
import 'package:flutter/gestures.dart';

// Assumes a SelectionController will be created and passed in.
// import 'selection_controller.dart';

class EdgesController {
  final FlowCanvasInternalController _controller;
  final EdgeService _edgeService;
  final EdgeGeometryService _edgeGeometryService;
  final SelectionController _selectionController;

  // This will be needed for deselectAll and selectEdge
  // final SelectionController _selectionController;

  EdgesController({
    required FlowCanvasInternalController controller,
    required EdgeService edgeService,
    required EdgeGeometryService edgeGeometryService,
    required SelectionController selectionController,
  })  : _controller = controller,
        _edgeService = edgeService,
        _edgeGeometryService = edgeGeometryService,
        _selectionController = selectionController;

  List<String> getEdgesFromNodes(Iterable<String> nodeIds) {
    return _edgeService.getEdgesFromNodes(_controller.currentState, nodeIds);
  }

  void addEdge(FlowEdge edge) {
    _controller.mutate((s) => _edgeService.addEdge(s, edge));
    _edgeGeometryService.updateEdge(_controller.currentState, edge.id);
  }

  void addEdges(List<FlowEdge> edges) {
    _controller.mutate((s) => _edgeService.addEdges(s, edges));
    for (final edge in edges) {
      _edgeGeometryService.updateEdge(_controller.currentState, edge.id);
    }
  }

  void removeSelectedEdges() {
    final edgesToRemove =
        Set<String>.from(_controller.currentState.selectedEdges);
    if (edgesToRemove.isEmpty) return;

    _controller
        .mutate((s) => _edgeService.removeEdges(s, edgesToRemove.toList()));
    _edgeGeometryService.removeEdges(edgesToRemove);
  }

  void updateEdge(String edgeId, EdgeDataUpdater updater) {
    final oldEdge = _controller.currentState.edges[edgeId];
    if (oldEdge == null) return;

    _controller.mutate((s) => _edgeService.updateEdgeData(s, edgeId, updater));
    _edgeGeometryService.updateEdge(_controller.currentState, edgeId);
  }

  void reconnectEdge({
    required String edgeId,
    String? newSourceNodeId,
    String? newSourceHandleId,
    String? newTargetNodeId,
    String? newTargetHandleId,
  }) {
    _controller.mutate((s) => _edgeService.reconnectEdge(s, edgeId,
        newSourceNodeId: newSourceNodeId,
        newSourceHandleId: newSourceHandleId,
        newTargetNodeId: newTargetNodeId,
        newTargetHandleId: newTargetHandleId));
  }

  void onEdgePointerHover(PointerEvent event, Offset localPosition) {
    final state = _controller.currentState;
    final hit = _edgeGeometryService.hitTestEdgeAt(
        localPosition, state, state.viewport.zoom);

    final currentHoveredId = state.hoveredEdgeId;
    final hitId = hit ?? "";

    if (hitId != currentHoveredId) {
      _controller.updateStateOnly(state.copyWith(hoveredEdgeId: hitId));
    }
  }

  void onEdgeTapDown(TapDownDetails details, Offset localPosition) {
    final state = _controller.currentState;
    final hit = _edgeGeometryService.hitTestEdgeAt(
        localPosition, state, state.viewport.zoom);

    _controller.updateStateOnly(state.copyWith(lastClickedEdgeId: hit ?? ""));

    if (hit != null) {
      if (state.edges[hit]?.selectable ?? true) {
        // Delegate to SelectionController
        _selectionController.selectEdge(hit, addToSelection: false);
      }
    } else {
      // If no edge was hit, treat it as a pane tap
      _selectionController.deselectAll();
    }
  }

  void onEdgeDoubleTap() {}

  void onEdgeLongPressStart(
      LongPressStartDetails details, Offset localPosition) {}
}
