import 'package:flow_canvas/src/core/canvas/flow_canvas_internal_controller.dart';
import 'package:flow_canvas/src/features/clipboard/application/clipboard_service.dart';
import 'package:flow_canvas/src/features/edges/application/edge_service.dart';
import 'package:flow_canvas/src/features/nodes/application/node_service.dart';
import 'package:flutter/widgets.dart';

class ClipboardController {
  final FlowCanvasInternalController _controller;
  final ClipboardService _clipboardService;
  final NodeService _nodeService;
  final EdgeService _edgeService;

  /// Internal storage for the copied payload.
  Map<String, dynamic>? _clipboardPayload;

  ClipboardController({
    required FlowCanvasInternalController controller,
    required ClipboardService clipboardService,
    required NodeService nodeService,
    required EdgeService edgeService,
  })  : _controller = controller,
        _clipboardService = clipboardService,
        _nodeService = nodeService,
        _edgeService = edgeService;

  /// Copies the currently selected nodes and edges to the internal clipboard.
  void copySelection() {
    // The copy service returns a payload that we store internally in this controller.
    _clipboardPayload = _clipboardService.copy(_controller.currentState);
  }

  /// Pastes the content from the internal clipboard onto the canvas.
  void paste({Offset? positionOffset}) {
    // Do nothing if the clipboard is empty.
    if (_clipboardPayload == null) return;

    // Delegate the state mutation to the main controller.
    _controller.mutate((s) {
      // Use the stored payload.
      return _clipboardService.paste(
        s,
        _clipboardPayload!,
        positionOffset: positionOffset ?? const Offset(20, 20),
        nodeService: _nodeService,
        edgeService: _edgeService,
      );
    });
  }
}
