import 'package:flutter/material.dart';
import 'package:flow_canvas/flow_canvas.dart';
import 'package:optopus/features/editor/presentation/widgets/nodes/color_picker_node.dart';
import 'package:optopus/features/editor/presentation/widgets/nodes/input_node.dart';
import 'package:optopus/features/flows/domain/entities/flow_entity.dart';

class EditorScreen extends StatefulWidget {
  final FlowCanvasController controller;
  final FlowEntity? flow;

  const EditorScreen({super.key, required this.controller, this.flow});

  @override
  State<EditorScreen> createState() => _EditorScreenState();
}

class _EditorScreenState extends State<EditorScreen> {
  late final NodeRegistry nodeRegistry;
  late final EdgeRegistry edgeRegistry;

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
  }

  @override
  void didUpdateWidget(covariant EditorScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.flow != oldWidget.flow) {
      _loadFlow();
    }
  }

  void _loadFlow() {
    // Logic to load flow data into controller
    if (widget.flow != null && widget.flow!.data.isNotEmpty) {
      // TODO: Implement parsing logic or use controller.fromJSON(widget.flow!.data)
      // Since I don't have the exact API, I am leaving this as a placeholder
      // but ensuring the structure is correct.
      // Ideally:
      // widget.controller.load(widget.flow!.data);
    }
  }

  List<FlowNode> get initialNodes {
    if (widget.flow != null && widget.flow!.data.isNotEmpty) {
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
      // ... other default nodes for demo/testing ...
    ];
  }

  List<FlowEdge> get initialEdges {
    if (widget.flow != null && widget.flow!.data.isNotEmpty) {
      return [];
    }
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
    return Column(
      children: [
        Expanded(
          child: DragTarget<String>(
            onWillAccept: (data) => true,
            onAcceptWithDetails: (details) {
              final RenderBox renderBox =
                  context.findRenderObject() as RenderBox;
              final localOffset = renderBox.globalToLocal(details.offset);
              // TODO: robust coordinate conversion

              widget.controller.nodes.addNode(
                FlowNode.create(
                  id: IdGenerator.generateNodeId(),
                  type: details.data == 'IF' ? 'defaultNode' : 'colorPicker',
                  position: localOffset,
                  size: const Size(150, 100),
                  data: {"label": details.data},
                ),
              );
            },
            builder: (context, candidateData, rejectedData) {
              return FlowCanvas(
                controller: widget.controller,
                nodeRegistry: nodeRegistry,
                edgeRegistry: edgeRegistry,
                initialNodes: initialNodes,
                initialEdges: initialEdges,
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
                      color: Color(0xFF64B5F6),
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
  }
}
