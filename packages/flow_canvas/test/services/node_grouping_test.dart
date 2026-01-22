import 'dart:ui';
import 'package:flow_canvas/src/application/services/node_service.dart';
import 'package:flow_canvas/src/domain/flow_canvas_state.dart';
import 'package:flow_canvas/src/domain/models/node.dart';
import 'package:flow_canvas/src/domain/state/node_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late NodeService nodeService;
  late FlowCanvasState initialState;

  setUp(() {
    nodeService = NodeService();
    initialState = FlowCanvasState.initial();
  });

  test('moveNodes should respect extent constraints', () {
    final node = FlowNode<Map<String, dynamic>>.create(
      id: 'node1',
      type: 'test',
      position: const Offset(100, 100),
      size: const Size(100, 100),
      data: <String, dynamic>{},
    );
    
    var state = nodeService.addNode(initialState, node);
    
    // Set extent to [0, 0, 200, 200]
    final extent = const Rect.fromLTWH(0, 0, 200, 200);
    state = nodeService.updateNodeRuntimeState(
      state, 
      'node1', 
      NodeRuntimeState(extent: extent),
    );

    // Try to move beyond extent (right)
    state = nodeService.moveNodes(state, ['node1'], const Offset(50, 0));
    expect(state.nodes['node1']!.position, const Offset(100, 100));
    
    // Try to move left within extent
    state = nodeService.moveNodes(state, ['node1'], const Offset(-50, 0));
    expect(state.nodes['node1']!.position, const Offset(50, 100));
    
    // Try to move left beyond extent
    state = nodeService.moveNodes(state, ['node1'], const Offset(-60, 0));
    expect(state.nodes['node1']!.position, const Offset(0, 100));
  });

  test('moveNodes should move children when parent is moved', () {
    final parent = FlowNode<Map<String, dynamic>>.create(
      id: 'parent',
      type: 'test',
      position: const Offset(0, 0),
      size: const Size(200, 200),
      data: <String, dynamic>{},
    );
    final child = FlowNode<Map<String, dynamic>>.create(
      id: 'child',
      type: 'test',
      parentId: 'parent',
      position: const Offset(50, 50),
      size: const Size(50, 50),
      data: <String, dynamic>{},
    );
    
    var state = nodeService.addNodes(initialState, [parent, child]);
    
    // Move parent by (100, 100)
    state = nodeService.moveNodes(state, ['parent'], const Offset(100, 100));
    
    expect(state.nodes['parent']!.position, const Offset(100, 100));
    expect(state.nodes['child']!.position, const Offset(150, 150));
  });

  test('moveNodes should expand parent if expandParent is true', () {
    final parent = FlowNode<Map<String, dynamic>>.create(
      id: 'parent',
      type: 'test',
      position: const Offset(0, 0),
      size: const Size(200, 200),
      data: <String, dynamic>{},
    );
    final child = FlowNode<Map<String, dynamic>>.create(
      id: 'child',
      type: 'test',
      parentId: 'parent',
      position: const Offset(150, 150), // Near bottom-right
      size: const Size(50, 50),
      data: <String, dynamic>{},
      expandParent: true,
    );
    
    var state = nodeService.addNodes(initialState, [parent, child]);
    
    // Move child by (50, 50) -> (200, 200). Size 50x50. Bottom-right at 250, 250.
    // Parent is 0,0 200x200. Bottom-right at 200, 200.
    // Child goes outside. Parent should expand.
    
    state = nodeService.moveNodes(state, ['child'], const Offset(50, 50));
    
    expect(state.nodes['child']!.position, const Offset(200, 200));
    
    final updatedParent = state.nodes['parent']!;
    expect(updatedParent.size.width, greaterThanOrEqualTo(250));
    expect(updatedParent.size.height, greaterThanOrEqualTo(250));
  });
}
