// import 'package:flow_canvas/src/features/canvas/application/controllers/canvas_queries_controller.dart';
import 'package:flow_canvas/src/features/clipboard/application/clipboard_controller.dart';
import 'package:flow_canvas/src/features/connections/application/connection_controller.dart';
import 'package:flow_canvas/src/features/edges/application/edge_geometry_controller.dart';
import 'package:flow_canvas/src/features/edges/application/edges_controller.dart';
import 'package:flow_canvas/src/features/handles/application/handles_controller.dart';
import 'package:flow_canvas/src/features/history/application/history_controller.dart';
import 'package:flow_canvas/src/features/keyboard/application/keyboard_controller.dart';
import 'package:flow_canvas/src/features/nodes/application/nodes_controller.dart';
import 'package:flow_canvas/src/features/selection/application/selection_controller.dart';
import 'package:flow_canvas/src/features/viewport/application/viewport_controller.dart';
import 'package:flow_canvas/src/features/viewport/domain/viewport.dart';
import 'package:flow_canvas/src/features/z_index/application/z_index_controller.dart';
import 'package:flow_canvas/src/features/clipboard/application/clipboard_service.dart';
import 'package:flow_canvas/src/features/connections/application/connection_service.dart';
import 'package:flow_canvas/src/features/edges/application/edge_geometry_service.dart';
import 'package:flow_canvas/src/features/edges/application/edge_service.dart';
import 'package:flow_canvas/src/features/history/application/history_service.dart';
import 'package:flow_canvas/src/features/keyboard/application/keyboard_action_service.dart';
import 'package:flow_canvas/src/features/nodes/application/node_service.dart';
import 'package:flow_canvas/src/features/selection/application/selection_service.dart';
import 'package:flow_canvas/src/features/viewport/application/viewport_service.dart';
import 'package:flow_canvas/src/features/z_index/application/z_index_service.dart';
import 'package:flow_canvas/src/core/state/flow_canvas_state.dart';
// import 'package:flow_canvas/src/features/viewport/domain/viewport_state.dart';
import 'package:flow_canvas/src/core/utils/coordinates/canvas_coordinate_converter.dart';
import 'package:flow_canvas/src/core/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// The central state management hub for the Flow Canvas.
///
/// This controller acts as a facade, coordinating all the domain services and sub-controllers
/// to manipulate the immutable `FlowCanvasState`. It integrates a history service
/// for undo/redo capabilities and exposes a clean API for the UI layer.
class FlowCanvasInternalController extends Notifier<FlowCanvasState> {
  final FlowCanvasState? initialState;

  // UI controller for InteractiveViewer, synced with our state's viewport.
  final TransformationController transformationController =
      TransformationController();
  final GlobalKey canvasKey = GlobalKey();
  final GlobalKey viewportKey = GlobalKey();

  // --- Domain Services (read from providers) ---
  late final NodeService _nodeService;
  late final EdgeService _edgeService;
  late final SelectionService _selectionService;
  late final ViewportService _viewportService;
  late final ConnectionService _connectionService;
  late final ZIndexService _zIndexService;
  late final ClipboardService _clipboardService;
  late final HistoryService _history;
  // late final SerializationService _serializationService;
  late final KeyboardActionService _keyboardActionService;
  late final CanvasCoordinateConverter coordinateConverter;
  late final EdgeGeometryService edgeGeometryService;

  // --- Sub-Controllers ---
  late final NodesController nodes;
  late final EdgesController edges;
  late final SelectionController selection;
  late final ViewportController viewport;
  late final ConnectionController connection;
  late final ClipboardController clipboard;
  late final HistoryController history;
  late final HandleController handle;
  late final EdgeGeometryController edgeGeometry;
  late final ZIndexController zIndex;
  late final KeyboardController keyboard;
  // late final CanvasQuerier querier;
  // late final SerializationController serialization;

  FlowCanvasInternalController({
    this.initialState,
  });

  final List<void Function(FlowCanvasState)> _listeners = [];

  void addListener(void Function(FlowCanvasState) listener) {
    _listeners.add(listener);
  }

  void removeListener(void Function(FlowCanvasState) listener) {
    _listeners.remove(listener);
  }

  void _notifyListeners(FlowCanvasState newState) {
    for (final listener in _listeners) {
      listener(newState);
    }
  }

  @override
  FlowCanvasState build() {
    // Read registries and services from providers
    _nodeService = ref.read(nodeServiceProvider);
    _edgeService = ref.read(edgeServiceProvider);
    _selectionService = ref.read(selectionServiceProvider);
    _viewportService = ref.read(viewportServiceProvider);
    _connectionService = ref.read(connectionServiceProvider);
    _zIndexService = ref.read(zIndexServiceProvider);
    _clipboardService = ref.read(clipboardServiceProvider);
    _history = ref.read(historyServiceProvider);
    // _serializationService = ref.read(serializationServiceProvider);
    _keyboardActionService = ref.read(keyboardActionServiceProvider);
    edgeGeometryService = ref.read(edgeGeometryServiceProvider);
    coordinateConverter = ref.read(coordinateConverterProvider);

    // Initialize all sub-controllers, injecting dependencies
    // Note: passing `this` (the Notifier) instead of StateNotifier
    selection = SelectionController(
      controller: this,
      selectionService: _selectionService,
    );
    nodes = NodesController(
      controller: this,
      nodeService: _nodeService,
      edgeService: _edgeService,
      selectionController: selection,
      ref: ref,
    );
    edges = EdgesController(
        controller: this,
        edgeService: _edgeService,
        edgeGeometryService: edgeGeometryService,
        selectionController: selection);
    viewport = ViewportController(
      controller: this,
      viewportService: _viewportService,
      coordinateConverter: coordinateConverter,
    );
    connection = ConnectionController(
      controller: this,
      connectionService: _connectionService,
      coordinateConverter: coordinateConverter,
    );
    clipboard = ClipboardController(
      controller: this,
      clipboardService: _clipboardService,
      nodeService: _nodeService,
      edgeService: _edgeService,
    );
    history = HistoryController(controller: this, history: _history);
    handle = HandleController(controller: this);
    edgeGeometry = EdgeGeometryController(
        controller: this, edgeGeometryService: edgeGeometryService);
    zIndex = ZIndexController(controller: this, zIndexService: _zIndexService);
    // serialization = SerializationController(
    //     controller: this, serializationService: _serializationService);
    keyboard = KeyboardController(
        controller: this, keyboardActionService: _keyboardActionService);

    final initial = initialState ?? FlowCanvasState.initial();

    // Initialize services that depend on the initial state.
    _history.init(initial);
    _updateTransformationController(initial); // Pass initial state explicitly

    // Setup listener for transformation controller
    transformationController.addListener(_onTransformationChanged);

    // Dispose callback
    ref.onDispose(() {
      transformationController.removeListener(_onTransformationChanged);
      transformationController.dispose();
    });

    // Compute initial edge geometries so edges render on first frame
    edgeGeometry.updateGeometryIfNeeded(initial);

    return initial;
  }

  // =================================================================================
  // --- State Update & Private Helpers ---
  // =================================================================================

  /// Applies a mutation and updates the state, saving the change to history.
  void mutate(FlowCanvasState Function(FlowCanvasState) mutation) {
    final newState = mutation(state);
    if (!identical(newState, state)) {
      _history.record(newState);
      state = newState;
      _onStateChanged(newState);
    }
    debugPrint("state updated");
  }

  /// Updates state WITHOUT saving to history (for transient/intermediate states).
  void updateStateOnly(FlowCanvasState newState) {
    if (!identical(newState, state)) {
      state = newState;
      _onStateChanged(newState);
    }
    debugPrint("state updated");
  }

  void _onStateChanged(FlowCanvasState newState) {
    edgeGeometry.updateGeometryIfNeeded(newState);
    _updateTransformationController(newState);
    _notifyListeners(newState);
  }

  void _updateTransformationController([FlowCanvasState? s]) {
    final viewport = (s ?? state).viewport;
    final stateMatrix = Matrix4.identity()
      ..translate(viewport.offset.dx, viewport.offset.dy)
      ..scale(viewport.zoom);

    if (transformationController.value != stateMatrix) {
      transformationController.value = stateMatrix;
    }
  }

  void _onTransformationChanged() {
    final matrix = transformationController.value;
    final newOffset =
        Offset(matrix.getTranslation().x, matrix.getTranslation().y);
    final newZoom = matrix.getMaxScaleOnAxis();

    final newViewport = FlowViewport(offset: newOffset, zoom: newZoom);

    // Careful: accessing `state` inside `build` (via listener) is bad if called synchronously during build.
    // transformationController might notify listeners during layout?
    // But `state` is safe to read once `build` returns.
    // And _onTransformationChanged usually happens on user interaction.

    if (state.viewport != newViewport) {
      // Avoid infinite loop if update comes from state change
      updateStateOnly(state.copyWith(viewport: newViewport));
    }
  }

  // =================================================================================
  // --- Public Delegated API ---
  // =================================================================================

  FlowCanvasState get currentState => state;

  /// Replaces the current canvas state with a new one.
  /// Typically used for loading a saved graph.
  void load(FlowCanvasState newState) {
    state = newState;
    _onStateChanged(newState);
    _history.init(newState); // Re-initialize history with the loaded state
  }

  // Dispose is handled by ref.onDispose
}
