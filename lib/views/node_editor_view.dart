import 'package:flutter/material.dart';

import 'package:flow_canvas/flow_canvas.dart';

import 'package:optopus/widgets/nodes/color_picker_node.dart';
import 'package:optopus/widgets/nodes/input_node.dart';

class NodeEditorView extends StatefulWidget {
  const NodeEditorView({super.key});

  @override
  State<NodeEditorView> createState() => _NodeEditorViewState();
}

class _NodeEditorViewState extends State<NodeEditorView> {
  final controller = FlowCanvasController();

  @override
  void initState() {
    super.initState();
  }

  late final nodeRegistry = NodeRegistry()
    ..register('colorPicker', (node) {
      return ColorPickerCard(node: node, controller: controller);
    })
    ..register('InputNode', (node) {
      return InputNode(node: node, controller: controller);
    });

  final edgeRegistry = EdgeRegistry();

  final List<FlowNode> initialNodes = [
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
    FlowNode.create(
      id: '2',
      position: const Offset(50, 250),
      size: const Size(200, 110),
      type: 'colorPicker',
      handles: [
        const FlowHandle(
          id: '2-both-1',
          type: HandleType.both,
          position: Offset(100, 30),
        ),
      ],
      data: {'label': 'Color Node', 'color': const Color(0xFF443a49)},
    ),
    FlowNode.create(
      id: '3',
      position: const Offset(100, 100),
      size: const Size(150, 150),
      type: 'colorPicker',
      handles: [
        const FlowHandle(
          id: '3-both-1',
          type: HandleType.both,
          position: Offset(75, 40),
        ),
      ],
      data: {'label': 'Color Node', 'color': const Color(0xFF443a49)},
    ),
    FlowNode.create(
      id: '4',
      position: const Offset(100, 300),
      size: const Size(150, 150),
      type: 'InputNode',
      selectable: true,
      draggable: false,
      handles: [
        const FlowHandle(
          id: '4-both-1',
          type: HandleType.target,
          position: Offset(75, 40),
        ),
      ],
      data: {
        'label': 'Color Node',
        'color': const Color.fromARGB(255, 166, 87, 206),
      },
    ),
    FlowNode.create(
      id: '5',
      position: const Offset(100, 300),
      size: const Size(150, 150),
      type: DefaultNodeType.defaultNode.toString(),
      handles: [
        const FlowHandle(
          id: '5-both-1',
          type: HandleType.target,
          position: Offset(75, 40),
        ),
      ],
      data: {'label': 'default Node'},
    ),
    // Grouping Example
    FlowNode.create(
      id: 'group-parent',
      type: DefaultNodeType.defaultNode.toString(),
      position: const Offset(400, 400),
      size: const Size(300, 300),
      data: {'label': 'Parent Group'},
      zIndex: -1, // Render behind children
    ),
    FlowNode.create(
      id: 'group-child',
      type: 'colorPicker',
      parentId: 'group-parent',
      expandParent: true,
      position: const Offset(450, 450), // Relative to canvas, inside parent
      size: const Size(150, 100),
      data: {'label': 'Child Node', 'color': const Color(0xFF66BB6A)},
    ),
  ];

  final List<FlowEdge> initialEdges = [
    const FlowEdge(
      id: 'e1-2',
      type: EdgePathType.step,
      sourceNodeId: '1',
      sourceHandleId: '1-both-1',
      targetNodeId: '2',
      targetHandleId: '2-both-1',
      label: Text("Edge Label"),
      endMarkerStyle: FlowEdgeMarkerStyle(
        markerType: EdgeMarkerType.arrow,
        decoration: FlowMarkerDecoration(size: Size(8, 8), color: Colors.black),
      ),
      startMarkerStyle: FlowEdgeMarkerStyle(
        markerType: EdgeMarkerType.arrow,
        decoration: FlowMarkerDecoration(size: Size(8, 8), color: Colors.black),
      ),
    ),
    FlowEdge(
      id: 'e3-1',
      type: EdgePathType.straight,
      sourceNodeId: '3',
      sourceHandleId: '3-both-1',
      targetNodeId: '1',
      targetHandleId: '1-both-2',
      label: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(25),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: const Text(
          "Custom Label",
          style: TextStyle(fontSize: 12, color: Colors.black),
        ),
      ),
      labelDecoration: FlowEdgeLabelStyle.dark(),
    ),
  ];

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
        // Row(
        //   children: [
        //     IconButton(
        //       onPressed: () => addNode(_controller!),
        //       icon: const Icon(Icons.add),
        //     )
        //   ],
        // ),
        Expanded(
          child: FlowCanvas(
            controller: controller,
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
            theme: FlowCanvasTheme.system(
              context,
            ).copyWith(connection: FlowConnectionStyle.light().copyWith()),
            overlays: const [
              FlowBackground(),
              FlowMiniMap(),
              FlowCanvasControls(showLock: false),
            ],
          ),
        ),
      ],
    );
  }
}
