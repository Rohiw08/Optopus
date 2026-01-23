import 'package:flow_canvas/flow_canvas.dart';
import 'package:flow_canvas/src/application/flow_canvas_internal_controller.dart';
import 'package:flow_canvas/src/application/services/connection_service.dart';
import 'package:flow_canvas/src/presentation/utility/canvas_coordinate_converter.dart';
import 'package:flutter/widgets.dart';

class ConnectionController {
  final FlowCanvasInternalController _controller;
  final ConnectionService _connectionService;
  final CanvasCoordinateConverter _coordinateConverter;

  ConnectionController({
    required FlowCanvasInternalController controller,
    required ConnectionService connectionService,
    required CanvasCoordinateConverter coordinateConverter,
  })  : _controller = controller,
        _connectionService = connectionService,
        _coordinateConverter = coordinateConverter;

  /// Initiates a connection drag from a node's handle.
  void startConnection(String nodeId, String handleId) {
    final state = _controller.currentState;
    final sourceNode = state.nodes[nodeId];
    final sourceHandle = sourceNode?.handles[handleId];
    if (sourceNode == null || sourceHandle == null) return;

    final handleCenter = sourceNode.position + sourceHandle.position;

    // Start connection and update drag mode.
    final nextState = _connectionService.startConnection(
      state.copyWith(dragMode: DragMode.connection),
      fromNodeId: nodeId,
      fromHandleId: handleId,
      startPosition: handleCenter,
    );
    _controller.updateStateOnly(nextState);
  }

  /// Updates the connection drag (real-time pointer movement).
  void updateConnection(Offset cursorScreenPosition) {
    final state = _controller.currentState;
    final activeConnection = state.activeConnection;

    if (state.dragMode != DragMode.connection || activeConnection == null) {
      return;
    }
    final cartesianPosition =
        _coordinateConverter.toCartesianPosition(cursorScreenPosition);

    // Only update if pointer actually moved.
    if (activeConnection.endPoint != cartesianPosition) {
      final nextState =
          _connectionService.updateConnection(state, cartesianPosition);
      _controller.updateStateOnly(nextState);
    }
  }

  /// Finalizes the edge if possible; propagates connect/end events.
  void endConnection() {
    final oldState = _controller.currentState;
    final pendingConnection = oldState.activeConnection;
    if (pendingConnection == null) return;

    _controller.mutate((s) => _connectionService.endConnection(s));
  }

  /// Cancels the current connection drag operation.
  void cancelConnection() {
    final state = _controller.currentState;
    if (state.activeConnection == null) return;
    final nextState = _connectionService.cancelConnection(state);
    _controller.updateStateOnly(nextState);

    // Optionally, you can emit a cancel-specific event if needed.
    // This is up to your app-level logic.
  }
}
