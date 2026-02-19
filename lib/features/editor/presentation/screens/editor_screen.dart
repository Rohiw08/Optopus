import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flow_canvas/flow_canvas.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:optopus/core/widgets/error_screen.dart';
import 'package:optopus/core/widgets/loading_screen.dart';
import 'package:optopus/features/editor/presentation/widgets/nodes/color_picker_node.dart';
import 'package:optopus/features/editor/presentation/widgets/nodes/input_node.dart';
import 'package:optopus/features/flows/domain/entities/flow_entity.dart';
import 'package:optopus/features/flows/presentation/controllers/flow_providers.dart';
import 'package:optopus/features/editor/presentation/controllers/editor_controller.dart';

class EditorScreen extends ConsumerStatefulWidget {
  final FlowCanvasController controller;
  final String flowId;

  const EditorScreen({
    super.key,
    required this.controller,
    required this.flowId,
  });

  @override
  ConsumerState<EditorScreen> createState() => _EditorScreenState();
}

class _EditorScreenState extends ConsumerState<EditorScreen> {
  late final NodeRegistry nodeRegistry;
  late final EdgeRegistry edgeRegistry;

  Timer? _autoSaveTimer;
  Map<String, dynamic>? _lastSavedJson;

  @override
  void initState() {
    super.initState();
    nodeRegistry = NodeRegistry()
      ..register('colorPicker', (node) {
        return ColorPickerCard(node: node, controller: widget.controller);
      })
      ..register('InputNode', (node) {
        return InputNode(node: node, controller: widget.controller);
      });
    edgeRegistry = EdgeRegistry();

    // Setup auto-save listener
    widget.controller.addListener(_onCanvasStateChanged);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onCanvasStateChanged);
    _autoSaveTimer?.cancel();
    super.dispose();
  }

  void _onCanvasStateChanged(FlowCanvasState state) {
    if (_autoSaveTimer?.isActive ?? false) _autoSaveTimer!.cancel();

    _autoSaveTimer = Timer(const Duration(milliseconds: 1500), () {
      _performAutoSave(state);
    });
  }

  Future<void> _performAutoSave(FlowCanvasState state) async {
    final currentJson = state.toJson();

    // Simple deep equality check using json encoding to avoid saving unmodified state
    // (A more performant approach would use Equatable on FlowCanvasState, but since
    // it's a deeply nested freezed class, this is straightforward for now)
    final currentJsonStr = jsonEncode(currentJson);
    final lastJsonStr = _lastSavedJson != null
        ? jsonEncode(_lastSavedJson)
        : null;

    if (currentJsonStr == lastJsonStr) return; // No changes

    _lastSavedJson = currentJson;

    try {
      await ref
          .read(editorControllerProvider.notifier)
          .saveFlow(flowId: widget.flowId, data: currentJson);
      debugPrint('Auto-saved flow successfully');
    } catch (e) {
      debugPrint('Auto-save failed: $e');
    }
  }

  List<FlowNode> _getInitialNodes(FlowEntity? flow) {
    if (flow != null && flow.data.isNotEmpty) {
      return []; // Should return parsed nodes if possible here
    }
    return [
      FlowNode.create(
        id: '1',
        position: const Offset(400, 200),
        size: const Size(150, 100),
        type: 'colorPicker',
        handles: [
          const FlowHandle(
            id: '1-both-1',
            type: HandleType.source,
            position: Offset(-75, -25),
          ),
          const FlowHandle(
            id: '1-both-2',
            type: HandleType.both,
            position: Offset(75, -25),
          ),
        ],
        data: {'label': 'My Custom Node'},
      ),
    ];
  }

  List<FlowEdge> _getInitialEdges(FlowEntity? flow) {
    return [];
  }

  void addNode(FlowCanvasController controller) {
    controller.nodes.addNode(
      FlowNode.create(
        id: IdGenerator.generateNodeId(),
        type: "ColorPicker",
        position: Offset.zero,
        size: const Size(200, 200),
        data: {"label": "node"},
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final flowAsync = ref.watch(flowProvider(widget.flowId));

    return flowAsync.when(
      data: (flow) {
        // Parse initial state if available
        FlowCanvasState? initialState;
        if (flow.data.isNotEmpty) {
          try {
            initialState = FlowCanvasState.fromJson(flow.data);
          } catch (e) {
            debugPrint('Error parsing flow data: $e');
          }
        }

        return Column(
          children: [
            Expanded(
              child: DragTarget<String>(
                onWillAcceptWithDetails: (data) => true,
                onAcceptWithDetails: (details) {
                  final RenderBox renderBox =
                      context.findRenderObject() as RenderBox;
                  final localOffset = renderBox.globalToLocal(details.offset);

                  widget.controller.nodes.addNode(
                    FlowNode.create(
                      id: IdGenerator.generateNodeId(),
                      type: details.data == 'IF'
                          ? 'defaultNode'
                          : 'colorPicker',
                      position: localOffset,
                      size: const Size(150, 100),
                      data: {"label": details.data},
                    ),
                  );
                },
                builder: (context, candidateData, rejectedData) {
                  return FlowCanvas(
                    controller: widget.controller,
                    initialState: initialState,
                    nodeRegistry: nodeRegistry,
                    edgeRegistry: edgeRegistry,
                    initialNodes: initialState == null
                        ? _getInitialNodes(flow)
                        : null,
                    initialEdges: initialState == null
                        ? _getInitialEdges(flow)
                        : null,
                    options: const FlowCanvasOptions(
                      viewportOptions: ViewportOptions(
                        maxZoom: 3.0,
                        minZoom: 0.3,
                        fitViewOptions: FitViewOptions(
                          maxZoom: 3.0,
                          minZoom: 0.3,
                          padding: EdgeInsets.all(1000),
                        ),
                      ),
                      nodeOptions: NodeOptions(
                        selectable: true,
                        elevateNodesOnSelected: true,
                      ),
                    ),
                    theme: FlowCanvasTheme.system(context).copyWith(
                      connection: FlowConnectionStyle.light().copyWith(
                        endMarkerStyle: FlowEdgeMarkerStyle.colored(
                          markerType: EdgeMarkerType.circle,
                          size: const Size(20, 20),
                          color: const Color(0xFF64B5F6),
                        ),
                      ),
                    ),
                    overlays: const [
                      FlowBackground(),
                      FlowMiniMap(),
                      FlowCanvasControls(showLock: false),
                    ],
                  );
                },
              ),
            ),
          ],
        );
      },
      loading: () => const Center(child: LoadingScreen()),
      error: (err, _) => ErrorScreen(message: '$err'),
    );
  }
}
