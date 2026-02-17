import 'package:flow_canvas/src/features/viewport/application/viewport_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flow_canvas/src/core/canvas/flow_canvas_internal_controller.dart';
import 'package:flow_canvas/src/core/state/flow_canvas_state.dart';
import 'package:flow_canvas/src/features/clipboard/application/clipboard_controller.dart';
import 'package:flow_canvas/src/features/connections/application/connection_controller.dart';
import 'package:flow_canvas/src/features/edges/application/edge_geometry_controller.dart';
import 'package:flow_canvas/src/features/edges/application/edges_controller.dart';
import 'package:flow_canvas/src/features/handles/application/handles_controller.dart';
import 'package:flow_canvas/src/features/history/application/history_controller.dart';
import 'package:flow_canvas/src/features/keyboard/application/keyboard_controller.dart';
import 'package:flow_canvas/src/features/nodes/application/nodes_controller.dart';
import 'package:flow_canvas/src/features/selection/application/selection_controller.dart';
import 'package:flow_canvas/src/features/z_index/application/z_index_controller.dart';

/// A public-facing controller (facade) for interacting with a FlowCanvas widget.
///
/// Create an instance of this controller and pass it to the [FlowCanvas]
/// widget's constructor to gain imperative control over the canvas.
///
/// This pattern hides the internal Riverpod state management from the widget's
/// user, providing a more traditional Flutter "controller-widget" API.
///
/// ### Example:
///
/// ```dart
/// class MyEditor extends StatefulWidget {
///   @override
///   _MyEditorState createState() => _MyEditorState();
/// }
///
/// class _MyEditorState extends State<MyEditor> {
///   // 1. Create the controller
///   late final FlowCanvasController _controller;
///
///   @override
///   void initState() {
///     super.initState();
///     _controller = FlowCanvasController();
///   }
///
///   void _addNode() {
///     // 3. Use the controller's API
///     _controller.nodes.addNode(
///       FlowNode.create(id: 'new-node', type: 'default', position: Offset.zero, data: {}),
///     );
///   }
///
///   @override
///   Widget build(BuildContext context) {
///     return Column(
///       children: [
///         ElevatedButton(onPressed: _addNode, child: Text('Add Node')),
///         Expanded(
///           child: FlowCanvas(
///             // 2. Pass the controller to the widget
///             controller: _controller,
///             nodeRegistry: myNodeRegistry,
///             edgeRegistry: myEdgeRegistry,
///           ),
///         ),
///       ],
///     );
///   }
/// }
/// ```
class FlowCanvasController {
  FlowCanvasInternalController? _internalController;

  /// A check to ensure the controller is attached to a canvas.
  void _assertAttached() {
    if (_internalController == null) {
      throw StateError(
          'FlowCanvasController is not attached to a FlowCanvas widget. '
          'Ensure you have passed this controller to the FlowCanvas widget '
          'and it has been initialized.');
    }
  }

  /// Internal method for the FlowCanvas widget to link the controllers.
  /// Not for public use.
  @internal
  void attach(FlowCanvasInternalController internalController) {
    if (_internalController != null) {
      debugPrint('FlowCanvasController is being re-attached. '
          'This is usually fine during hot reload.');
    }
    _internalController = internalController;
  }

  /// Internal method for the FlowCanvas widget to unlink the controllers.
  /// Not for public use.
  @internal
  void detach() {
    _internalController = null;
  }

  /// Access the current, immutable state of the canvas.
  FlowCanvasState get currentState {
    _assertAttached();
    return _internalController!.currentState;
  }

  // --- Delegated Sub-Controllers ---

  /// Controller for all node-related actions (add, remove, update, drag).
  NodesController get nodes {
    _assertAttached();
    return _internalController!.nodes;
  }

  /// Controller for all edge-related actions (add, remove, update, reconnect).
  EdgesController get edges {
    _assertAttached();
    return _internalController!.edges;
  }

  /// Controller for managing selection (nodes, edges, box selection).
  SelectionController get selection {
    _assertAttached();
    return _internalController!.selection;
  }

  /// Controller for managing the viewport (pan, zoom, fitView).
  ViewportController get viewport {
    _assertAttached();
    return _internalController!.viewport;
  }

  /// Controller for managing active connection-dragging state.
  ConnectionController get connection {
    _assertAttached();
    return _internalController!.connection;
  }

  /// Controller for clipboard actions (copy, paste).
  ClipboardController get clipboard {
    _assertAttached();
    return _internalController!.clipboard;
  }

  /// Controller for undo/redo history.
  HistoryController get history {
    _assertAttached();
    return _internalController!.history;
  }

  /// Controller for managing handle hover/active states.
  HandleController get handle {
    _assertAttached();
    return _internalController!.handle;
  }

  /// Controller for managing edge geometry and hit-testing.
  EdgeGeometryController get edgeGeometry {
    _assertAttached();
    return _internalController!.edgeGeometry;
  }

  /// Controller for managing node z-index (bring to front, send to back).
  ZIndexController get zIndex {
    _assertAttached();
    return _internalController!.zIndex;
  }

  /// Controller for handling keyboard actions.
  KeyboardController get keyboard {
    _assertAttached();
    return _internalController!.keyboard;
  }
}
