/// The main entry point for the Flutter Workflow library.
///
/// This file exports all the public-facing APIs, including the core canvas,
/// controllers, data models, theming, and options.
library;

// --- Core ---
export 'src/presentation/flow_canvas.dart';
export 'src/application/flow_canvas_controller.dart';

// --- Domain Models ---
export 'src/domain/models/node.dart';
export 'src/domain/models/edge.dart';
export 'src/domain/models/handle.dart';
export 'src/domain/models/connection.dart';
export 'src/domain/models/coordinate_extent.dart';

// --- Domain Registries ---
export 'src/domain/registries/node_registry.dart';
export 'src/domain/registries/edge_registry.dart';

// --- Theming ---
export 'src/presentation/theme/theme_export.dart';

// --- Options ---
export 'src/presentation/options/flow_options.dart';
export 'src/presentation/options/components/edge_options.dart';
export 'src/presentation/options/components/fitview_options.dart';
export 'src/presentation/options/components/keyboard_options.dart';
export 'src/presentation/options/components/node_options.dart';
export 'src/presentation/options/components/viewport_options.dart';

// --- Callbacks & Events ---
export 'src/application/events/connection_change_event.dart';
export 'src/application/events/edge_change_event.dart';
export 'src/application/events/node_change_event.dart';
export 'src/application/events/pane_change.dart';
export 'src/application/events/selection_change_event.dart';
export 'src/application/events/viewport_change_event.dart';

// --- Streams ---
export 'src/application/streams/connection_change_stream.dart';
export 'src/application/streams/edge_change_stream.dart';
export 'src/application/streams/node_change_stream.dart';
export 'src/application/streams/pane_change_stream.dart';
export 'src/application/streams/selection_change_stream.dart';
export 'src/application/streams/viewport_change_stream.dart';

// --- Shared ---
export 'src/shared/enums.dart';

// --- Widgets ---
export 'src/presentation/widgets/flow_canvas_controls.dart';
export 'src/presentation/widgets/control_button.dart';
export 'src/presentation/widgets/flow_minimap.dart';
export 'src/presentation/widgets/flow_handle.dart';
export 'src/presentation/widgets/layers/flow_background.dart';
export 'src/presentation/widgets/flow_node.dart';
export 'src/presentation/widgets/flow_edge_label.dart';

// --- Utility ---
export 'src/presentation/utility/flow_positioned.dart';
export 'src/presentation/utility/random_id_generator.dart';
