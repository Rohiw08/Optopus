import 'package:flutter_riverpod/flutter_riverpod.dart';

// Core
import '../canvas/flow_canvas_internal_controller.dart';
import '../state/flow_canvas_state.dart';
import '../options/flow_options.dart';
import '../utils/coordinates/canvas_coordinate_converter.dart';

// Features - Nodes
import '../../features/nodes/application/node_service.dart';
import '../../features/nodes/domain/node_registry.dart';

// Features - Edges
import '../../features/edges/application/edge_service.dart';
import '../../features/edges/application/edge_geometry_service.dart';
import '../../features/edges/domain/edge_registry.dart';

// Features - Selection
import '../../features/selection/application/selection_service.dart';

// Features - Viewport
import '../../features/viewport/application/viewport_service.dart';

// Features - Connections
import '../../features/connections/application/connection_service.dart';

// Features - Clipboard
import '../../features/clipboard/application/clipboard_service.dart';

// Features - History
import '../../features/history/application/history_service.dart';

// Features - Keyboard
import '../../features/keyboard/application/keyboard_action_service.dart';

// Features - Z-Index
import '../../features/z_index/application/z_index_service.dart';

/// The central provider for the FlowCanvas state and controller.
///
/// This provider must be overridden at the root of the FlowCanvas widget tree.
/// It is responsible for creating the main controller instance.
final flowControllerProvider =
    NotifierProvider<FlowCanvasInternalController, FlowCanvasState>(
  () {
    // This base implementation should never be called. The provider is
    // overridden in the `FlowCanvas` widget to properly initialize the
    // controller with an initial state and user-provided callbacks.
    throw UnimplementedError(
        'flowControllerProvider must be overridden at the FlowCanvas root.');
  },
);

/// This provider is the key to our internal state management.
///
/// It is not intended for public use by the library's users. It is
/// overridden within the FlowCanvas widget to provide the correct controller
/// instance to all descendant widgets.
final internalControllerProvider = flowControllerProvider;

/// Provider for the NodeRegistry.
/// This should be overridden in the FlowCanvas widget.
final nodeRegistryProvider = Provider<NodeRegistry>((ref) {
  throw UnimplementedError('NodeRegistryProvider must be overridden');
});

/// Provider for the EdgeRegistry.
/// This should be overridden in the FlowCanvas widget.
final edgeRegistryProvider = Provider<EdgeRegistry>((ref) {
  throw UnimplementedError('EdgeRegistryProvider must be overridden');
});

final flowOptionsProvider = Provider<FlowCanvasOptions>((ref) {
  throw UnimplementedError('FlowOptionsProvider must be overridden');
});

final coordinateConverterProvider = Provider<CanvasCoordinateConverter>((ref) {
  final options = ref.watch(flowOptionsProvider);
  return CanvasCoordinateConverter(
    canvasWidth: options.canvasSize.width,
    canvasHeight: options.canvasSize.height,
  );
});

// --- SERVICE PROVIDERS ---

final nodeServiceProvider = Provider<NodeService>((ref) => NodeService());
final edgeServiceProvider = Provider<EdgeService>((ref) => EdgeService());
final selectionServiceProvider =
    Provider<SelectionService>((ref) => SelectionService());
final viewportServiceProvider = Provider<ViewportService>((ref) =>
    ViewportService(
        coordinateConverter: ref.watch(coordinateConverterProvider)));
final connectionServiceProvider =
    Provider<ConnectionService>((ref) => ConnectionService());
final zIndexServiceProvider = Provider<ZIndexService>((ref) => ZIndexService());
final clipboardServiceProvider =
    Provider<ClipboardService>((ref) => ClipboardService());
final historyServiceProvider =
    Provider<HistoryService>((ref) => HistoryService());
// final serializationServiceProvider =
//     Provider<SerializationService>((ref) => SerializationService());
final edgeGeometryServiceProvider = Provider<EdgeGeometryService>((ref) {
  final coordinateConverter = ref.watch(coordinateConverterProvider);
  return EdgeGeometryService(coordinateConverter);
});

// This one is special as it depends on other services
final keyboardActionServiceProvider = Provider<KeyboardActionService>((ref) {
  return KeyboardActionService(
    nodeService: ref.watch(nodeServiceProvider),
    edgeService: ref.watch(edgeServiceProvider),
    selectionService: ref.watch(selectionServiceProvider),
    viewportService: ref.watch(viewportServiceProvider),
    clipboardService: ref.watch(clipboardServiceProvider),
  );
});
