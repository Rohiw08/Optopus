/// The main entry point for the Flutter Workflow library.
///
/// This file exports all the public-facing APIs, including the core canvas,
/// controllers, data models, theming, and options.
library;

// --- Core Canvas ---
export 'src/core/canvas/flow_canvas.dart';
export 'src/core/canvas/flow_canvas_controller.dart';

// --- Node Feature ---
export 'src/features/nodes/domain/models/node.dart';
export 'src/features/nodes/domain/node_registry.dart';
export 'src/features/nodes/presentation/flow_node.dart';

// --- Edge Feature ---
export 'src/features/edges/domain/model/edge.dart';
export 'src/features/edges/domain/edge_registry.dart';

// --- Handle Feature ---
export 'src/features/handles/domain/handle.dart';
export 'src/features/handles/presentation/flow_handle.dart';

// --- Connection Feature ---
export 'src/features/connections/domain/models/connection.dart';

// --- Viewport Feature ---
export 'src/features/viewport/domain/coordinate_extent.dart';

// --- Background Plugin ---
export 'src/features/background/presentation/flow_background.dart';

// --- Minimap Plugin ---
export 'src/features/minimap/presentation/flow_minimap.dart';

// --- Controls Plugin ---
export 'src/features/control_panel/presentation/flow_canvas_controls.dart';
export 'src/features/control_panel/presentation/control_button.dart';

// --- Edge Label Widget ---
export 'src/features/edge_labels/presentation/flow_edge_label.dart';

// --- Theming ---
export 'src/core/theme/theme_export.dart';

// --- Options ---
export 'src/core/options/flow_options.dart';
export 'src/core/options/components/edge_options.dart';
export 'src/core/options/components/fitview_options.dart';
export 'src/core/options/components/keyboard_options.dart';
export 'src/core/options/components/node_options.dart';
export 'src/core/options/components/viewport_options.dart';

// --- Shared ---
export 'src/core/enums/enums.dart';

// --- Utility ---
export 'src/core/utils/flow_positioned.dart';
export 'src/core/utils/random_id_generator.dart';

// --- Examples ---
export 'src/core/utils/coordinates/coordinates.dart';
