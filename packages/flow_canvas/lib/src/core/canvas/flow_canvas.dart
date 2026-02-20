import 'package:flow_canvas/src/core/canvas/flow_canvas_controller.dart';
import 'package:flow_canvas/src/core/canvas/flow_canvas_internal_controller.dart';
import 'package:flow_canvas/src/core/enums/enums.dart';
import 'package:flow_canvas/src/core/options/flow_options.dart';
import 'package:flow_canvas/src/core/options/options_provider.dart';
import 'package:flow_canvas/src/core/providers/providers.dart';
import 'package:flow_canvas/src/core/state/flow_canvas_state.dart';
import 'package:flow_canvas/src/core/theme/theme_export.dart';
import 'package:flow_canvas/src/features/background/presentation/flow_background.dart';
import 'package:flow_canvas/src/features/edges/domain/edge_index.dart';
import 'package:flow_canvas/src/features/edges/domain/edge_registry.dart';
import 'package:flow_canvas/src/features/edges/domain/edge_state.dart';
import 'package:flow_canvas/src/features/edges/domain/model/edge.dart';
import 'package:flow_canvas/src/features/edges/presentation/layer/edges_layer.dart';
import 'package:flow_canvas/src/features/keyboard/presentation/controller_adapter.dart';
import 'package:flow_canvas/src/features/keyboard/presentation/inputs/keymap.dart';
import 'package:flow_canvas/src/features/nodes/domain/models/node.dart';
import 'package:flow_canvas/src/features/nodes/domain/node_index.dart';
import 'package:flow_canvas/src/features/nodes/domain/node_registry.dart';
import 'package:flow_canvas/src/features/nodes/domain/node_state.dart';
import 'package:flow_canvas/src/features/nodes/presentation/nodes_layer.dart';
import 'package:flow_canvas/src/features/selection/presentation/layers/selection_layer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Remove the old callback definition
// typedef FlowCanvasCreatedCallback = void Function(
//     FlowCanvasInternalController controller);

/// The main entry point widget for the Flow Canvas library.
class FlowCanvas extends StatefulWidget {
  // --- CORE MEMBERS ---
  /// An optional controller to imperatively manage the canvas.
  final FlowCanvasController? controller;
  final FlowCanvasState? initialState;
  final List<FlowNode>? initialNodes;
  final List<FlowEdge>? initialEdges;
  final NodeRegistry nodeRegistry;
  final EdgeRegistry edgeRegistry;
  final FlowCanvasOptions options;
  final FlowCanvasTheme? theme;

  // --- UI ---
  final List<Widget> overlays;

  /// Called when a draggable String item is dropped onto the canvas.
  /// Provides the node type and the canvas-space position of the drop.
  final void Function(String nodeType, Offset canvasOffset)? onDrop;

  const FlowCanvas({
    super.key,
    this.controller,
    this.initialState,
    required this.nodeRegistry,
    required this.edgeRegistry,
    this.initialNodes,
    this.initialEdges,
    this.theme,
    this.options = const FlowCanvasOptions(),
    this.overlays = const [],
    this.onDrop,
  });

  @override
  State<FlowCanvas> createState() => _FlowCanvasState();
}

class _FlowCanvasState extends State<FlowCanvas> {
  late final ProviderContainer _providerContainer;
  late final FlowCanvasInternalController _internalController;

  // The facade controller provided by the user (or a default one).
  late final FlowCanvasController _facade;

  @override
  void initState() {
    super.initState();

    // Use the user's controller or create a new one if not provided
    _facade = widget.controller ?? FlowCanvasController();

    FlowCanvasState initialState;

    if (widget.initialState != null) {
      initialState = widget.initialState!;
    } else {
      final initialNodesMap = {
        for (var n in widget.initialNodes ?? []) n.id as String: n as FlowNode
      };

      final initialNodeStatesMap = {
        for (var n in widget.initialNodes ?? [])
          n.id as String: const NodeRuntimeState(),
      };

      final initialEdgesMap = {
        for (var e in widget.initialEdges ?? []) e.id as String: e as FlowEdge
      };

      final initialEdgesStatesMap = {
        for (var e in widget.initialEdges ?? [])
          e.id as String: const EdgeRuntimeState(),
      };

      initialState = FlowCanvasState.initial().copyWith(
        nodes: initialNodesMap,
        edges: initialEdgesMap,
        nodeStates: initialNodeStatesMap,
        edgeStates: initialEdgesStatesMap,
        nodeIndex: NodeIndex.fromNodes(initialNodesMap.values),
        edgeIndex: EdgeIndex.fromEdges(initialEdgesMap),
      );
    }

    _providerContainer = ProviderContainer(
      overrides: [
        nodeRegistryProvider.overrideWithValue(widget.nodeRegistry),
        edgeRegistryProvider.overrideWithValue(widget.edgeRegistry),
        flowOptionsProvider.overrideWithValue(widget.options),
        flowControllerProvider.overrideWith(
          () => FlowCanvasInternalController(initialState: initialState),
        ),
      ],
    );

    // Get the internal controller instance from our new container
    _internalController =
        _providerContainer.read(flowControllerProvider.notifier);

    // **LINK THE FACADE**
    // Attach the internal controller to the public-facing facade.
    _facade.attach(_internalController);

    // Remove the old onCanvasCreated callback
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   if (mounted) widget.onCanvasCreated?.call(_controller);
    // });
  }

  @override
  void dispose() {
    // **UNLINK THE FACADE**
    _facade.detach();
    _providerContainer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return UncontrolledProviderScope(
      container: _providerContainer,
      child: FlowCanvasThemeProvider(
        theme: widget.theme,
        child: FlowCanvasOptionsProvider(
          options: widget.options,
          child: _FlowCanvasCore(
            overlays: widget.overlays,
            centerOnInitialLoad: widget.initialState == null,
            onDrop: widget.onDrop,
          ),
        ),
      ),
    );
  }
}

class _FlowCanvasCore extends ConsumerStatefulWidget {
  final List<Widget> overlays;
  final bool centerOnInitialLoad;
  final void Function(String nodeType, Offset canvasOffset)? onDrop;

  const _FlowCanvasCore({
    required this.overlays,
    this.centerOnInitialLoad = true,
    this.onDrop,
  });

  @override
  ConsumerState<_FlowCanvasCore> createState() => _FlowCanvasCoreState();
}

class _FlowCanvasCoreState extends ConsumerState<_FlowCanvasCore> {
  bool _hasInitialized = false;

  @override
  Widget build(BuildContext context) {
    final controller = ref.watch(internalControllerProvider.notifier);
    final options = ref.read(flowOptionsProvider);

    final backgroundOverlays =
        widget.overlays.whereType<FlowBackground>().toList();
    final foregroundOverlays =
        widget.overlays.where((w) => w is! FlowBackground).toList();

    return KeyboardAdapter(
      controller: controller,
      options: options,
      keymap: Keymap.standard(),
      child: LayoutBuilder(
        builder: (context, constraints) {
          WidgetsBinding.instance.addPostFrameCallback(
            (_) {
              if (context.mounted) {
                controller.viewport.setViewportSize(
                  Size(constraints.maxWidth, constraints.maxHeight),
                );
              }
              if (context.mounted && !_hasInitialized) {
                if (widget.centerOnInitialLoad) {
                  controller.viewport.centerOnPosition(Offset.zero);
                }
                _hasInitialized = true;
              }
            },
          );

          return DragTarget<String>(
            onWillAcceptWithDetails: (details) => true,
            onAcceptWithDetails: (details) {
              if (widget.onDrop == null) return;
              // Convert screen position to canvas-space coordinates
              final canvasOffset =
                  controller.viewport.screenToCanvasPosition(details.offset);
              widget.onDrop!(details.data, canvasOffset);
            },
            builder: (context, candidateData, rejectedData) {
              return Stack(
                alignment: Alignment.center,
                clipBehavior: Clip.none,
                children: [
                  _InteractiveViewerWrapper(
                    backgroundOverlays: backgroundOverlays,
                  ),
                  ...foregroundOverlays,
                ],
              );
            },
          );
        },
      ),
    );
  }
}

class _InteractiveViewerWrapper extends ConsumerWidget {
  final List<FlowBackground> backgroundOverlays;

  const _InteractiveViewerWrapper({
    required this.backgroundOverlays,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(internalControllerProvider.notifier);
    final options = ref.read(flowOptionsProvider);
    final isLocked = ref.watch(
      internalControllerProvider.select((state) => state.isPanZoomLocked),
    );
    final dragMode = ref.watch(
      internalControllerProvider.select((state) => state.dragMode),
    );

    return InteractiveViewer(
      transformationController: controller.transformationController,
      constrained: false,
      minScale: options.viewportOptions.minZoom,
      maxScale: options.viewportOptions.maxZoom,
      panEnabled: !isLocked && dragMode != DragMode.selection,
      scaleEnabled: !isLocked,
      child: SizedBox(
        key: controller.canvasKey,
        width: options.canvasSize.width,
        height: options.canvasSize.height,
        child: RepaintBoundary(
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              ...backgroundOverlays,
              const FlowEdgeLayer(),
              const FlowNodesLayer(),
              // const FlowNodesResizerLayer(),
              // const FlowNodesPanelsLayer(),
              const SelectionLayer(),
            ],
          ),
        ),
      ),
    );
  }
}
