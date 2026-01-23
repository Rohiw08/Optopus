import 'package:flow_canvas/src/application/flow_canvas_internal_controller.dart';
import 'package:flow_canvas/src/application/services/selection_service.dart';
import 'package:flow_canvas/src/shared/enums.dart';
import 'package:flutter/material.dart';

class SelectionController {
  final FlowCanvasInternalController _controller;
  final SelectionService _selectionService;

  // Assumes a SelectionController will be created and passed in

  SelectionController({
    required FlowCanvasInternalController controller,
    required SelectionService selectionService,
  })  : _controller = controller,
        _selectionService = selectionService;

  Set<String> _getNodesInSelectionRect() {
    final rect = _controller.currentState.selectionRect;
    if (rect == Rect.zero) return {};
    final cartesianRect =
        _controller.coordinateConverter.renderRectToCartesianRect(rect);
    final foundNodes =
        _controller.currentState.nodeIndex!.queryNodesInRect(cartesianRect);
    return foundNodes;
  }

  void selectNode(String nodeId, {bool addToSelection = false}) {
    _controller.updateStateOnly(
      _selectionService.toggleNodeSelection(_controller.currentState, nodeId,
          addToSelection: addToSelection),
    );
  }

  void selectEdge(String edgeId, {bool addToSelection = false}) {
    _controller.updateStateOnly(_selectionService.toggleEdgeSelection(
        _controller.currentState, edgeId,
        addToSelection: addToSelection));
  }

  void deselectAll() {
    _controller.updateStateOnly(
        _selectionService.deselectAll(_controller.currentState));
  }

  void selectAll() {
    _controller
        .updateStateOnly(_selectionService.selectAll(_controller.currentState));
  }

  Offset? _selectionDragOrigin;

  void startSelection(Offset position) {
    _selectionDragOrigin = position;
    final stateAfterStart =
        _selectionService.startBoxSelection(_controller.currentState, position);
    // Set the drag mode to notify other parts of the UI that a selection is in progress.
    // This is a transient state change, so we don't record it to history.
    _controller.updateStateOnly(
        stateAfterStart.copyWith(dragMode: DragMode.selection));
  }

  void updateSelection(Offset position, {SelectionMode? selectionMode}) {
    if (_controller.currentState.dragMode != DragMode.selection) return;

    // First, update the visual selection rectangle.
    final stateWithNewRect = _selectionService.updateBoxSelection(
      _controller.currentState,
      _selectionDragOrigin!,
      position,
      selectionMode: selectionMode ?? SelectionMode.partial,
    );

    // Now, find which nodes are inside this new rectangle.
    final selectedNodes = _getNodesInSelectionRect();

    // Update the state without saving to history, as this is an intermediate drag state.
    _controller.updateStateOnly(
      stateWithNewRect.copyWith(selectedNodes: selectedNodes),
    );
  }

  void endSelection() {
    _selectionDragOrigin = null;

    // Get the final set of selected nodes from the last known selection rectangle.
    final finalSelectedNodes = _getNodesInSelectionRect();

    // When selection ends, commit the final selected nodes to history.
    // This mutation also removes the selection rectangle and resets the drag mode.
    _controller.mutate((s) => s.copyWith(
          selectedNodes: finalSelectedNodes,
          selectionRect: Rect.zero,
        ));
  }
}
