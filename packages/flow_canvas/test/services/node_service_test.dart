import 'package:flow_canvas/src/application/services/node_service.dart';
import 'package:flow_canvas/src/shared/enums.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_test/flutter_test.dart';

import '../test_helpers.dart';

void main() {
  group('NodeService', () {
    late NodeService service;

    setUp(() {
      service = NodeService();
    });

    // =========================================================================
    // getNode & getNodeRuntimeState
    // =========================================================================

    group('getNode', () {
      test('should return node when it exists', () {
        // Arrange
        final node = createTestNode(id: 'node-1');
        final state = createTestState(nodes: {'node-1': node});

        // Act
        final result = service.getNode(state, 'node-1');

        // Assert
        expect(result, equals(node));
      });

      test('should return null when node does not exist', () {
        // Arrange
        final state = createTestState();

        // Act
        final result = service.getNode(state, 'non-existent');

        // Assert
        expect(result, isNull);
      });
    });

    group('getNodeRuntimeState', () {
      test('should return runtime state when it exists', () {
        // Arrange
        final runtimeState = createTestNodeRuntimeState(selected: true);
        final state = createTestState(
          nodeStates: {'node-1': runtimeState},
        );

        // Act
        final result = service.getNodeRuntimeState(state, 'node-1');

        // Assert
        expect(result, equals(runtimeState));
      });

      test('should return null when runtime state does not exist', () {
        // Arrange
        final state = createTestState();

        // Act
        final result = service.getNodeRuntimeState(state, 'non-existent');

        // Assert
        expect(result, isNull);
      });
    });

    // =========================================================================
    // addNode & addNodes
    // =========================================================================

    group('addNode', () {
      test('should add node to empty state', () {
        // Arrange
        final state = createTestState();
        final node = createTestNode(id: 'node-1');

        // Act
        final newState = service.addNode(state, node);

        // Assert
        expect(newState.nodes.containsKey('node-1'), isTrue);
        // zIndex gets incremented from maxZIndex (0) + 1 = 1
        expect(newState.nodes['node-1']!.zIndex, equals(1));
        expect(newState.maxZIndex, equals(1));
      });

      test('should add node to populated state', () {
        // Arrange
        final existingNode = createTestNode(id: 'node-1', zIndex: 5);
        final state = createTestState(
          nodes: {'node-1': existingNode},
          maxZIndex: 5,
        );
        final newNode = createTestNode(id: 'node-2', zIndex: 0);

        // Act
        final newState = service.addNode(state, newNode);

        // Assert
        expect(newState.nodes.containsKey('node-2'), isTrue);
        expect(newState.nodes.length, equals(2));
        // zIndex should be incremented to maxZIndex + 1
        expect(newState.nodes['node-2']!.zIndex, equals(6));
        expect(newState.maxZIndex, equals(6));
      });

      test('should increment zIndex correctly', () {
        // Arrange
        final state = createTestState(maxZIndex: 10);
        final node = createTestNode(id: 'node-1', zIndex: 3);

        // Act
        final newState = service.addNode(state, node);

        // Assert
        expect(newState.nodes['node-1']!.zIndex, equals(11));
        expect(newState.maxZIndex, equals(11));
      });

      test('should update node index', () {
        // Arrange
        final state = createTestState();
        final node = createTestNode(id: 'node-1');

        // Act
        final newState = service.addNode(state, node);

        // Assert
        expect(newState.nodeIndex.getNode('node-1'), isNotNull);
      });
    });

    group('addNodes', () {
      test('should add multiple nodes at once', () {
        // Arrange
        final state = createTestState();
        final nodes = [
          createTestNode(id: 'node-1'),
          createTestNode(id: 'node-2'),
          createTestNode(id: 'node-3'),
        ];

        // Act
        final newState = service.addNodes(state, nodes);

        // Assert
        expect(newState.nodes.length, equals(3));
        expect(newState.nodes.containsKey('node-1'), isTrue);
        expect(newState.nodes.containsKey('node-2'), isTrue);
        expect(newState.nodes.containsKey('node-3'), isTrue);
      });

      test('should skip duplicate node IDs', () {
        // Arrange
        final existingNode = createTestNode(id: 'node-1', zIndex: 5);
        final state = createTestState(
          nodes: {'node-1': existingNode},
          maxZIndex: 5,
        );
        final nodes = [
          createTestNode(id: 'node-1', zIndex: 10), // Duplicate
          createTestNode(id: 'node-2'),
        ];

        // Act
        final newState = service.addNodes(state, nodes);

        // Assert
        expect(newState.nodes.length, equals(2));
        // Original node should remain unchanged
        expect(newState.nodes['node-1']!.zIndex, equals(5));
        expect(newState.nodes.containsKey('node-2'), isTrue);
      });

      test('should return same state when adding empty list', () {
        // Arrange
        final state = createTestState();

        // Act
        final newState = service.addNodes(state, []);

        // Assert
        expect(newState, equals(state));
      });
    });

    // =========================================================================
    // removeNode & removeNodes
    // =========================================================================

    group('removeNode', () {
      test('should remove single node', () {
        // Arrange
        final node = createTestNode(id: 'node-1');
        final state = createTestState(nodes: {'node-1': node});

        // Act
        final newState = service.removeNode(state, 'node-1');

        // Assert
        expect(newState.nodes.containsKey('node-1'), isFalse);
        expect(newState.nodes.length, equals(0));
      });

      test('should handle removing non-existent node', () {
        // Arrange
        final state = createTestState();

        // Act
        final newState = service.removeNode(state, 'non-existent');

        // Assert
        expect(newState, equals(state));
      });
    });

    group('removeNodes', () {
      test('should remove multiple nodes', () {
        // Arrange
        final nodes = {
          'node-1': createTestNode(id: 'node-1'),
          'node-2': createTestNode(id: 'node-2'),
          'node-3': createTestNode(id: 'node-3'),
        };
        final state = createTestState(nodes: nodes);

        // Act
        final newState = service.removeNodes(state, ['node-1', 'node-3']);

        // Assert
        expect(newState.nodes.length, equals(1));
        expect(newState.nodes.containsKey('node-2'), isTrue);
        expect(newState.nodes.containsKey('node-1'), isFalse);
        expect(newState.nodes.containsKey('node-3'), isFalse);
      });

      test('should remove nodes from selection', () {
        // Arrange
        final nodes = {
          'node-1': createTestNode(id: 'node-1'),
          'node-2': createTestNode(id: 'node-2'),
        };
        final state = createTestState(
          nodes: nodes,
          selectedNodes: {'node-1', 'node-2'},
        );

        // Act
        final newState = service.removeNodes(state, ['node-1']);

        // Assert
        expect(newState.selectedNodes.contains('node-1'), isFalse);
        expect(newState.selectedNodes.contains('node-2'), isTrue);
      });

      test('should update node index', () {
        // Arrange
        final node = createTestNode(id: 'node-1');
        final state = createTestState(nodes: {'node-1': node});

        // Act
        final newState = service.removeNodes(state, ['node-1']);

        // Assert
        expect(newState.nodeIndex.getNode('node-1'), isNull);
      });

      test('should return same state when removing empty list', () {
        // Arrange
        final state = createTestState();

        // Act
        final newState = service.removeNodes(state, []);

        // Assert
        expect(newState, equals(state));
      });
    });

    // =========================================================================
    // moveNodes & moveSelectedNodes
    // =========================================================================

    group('moveNodes', () {
      test('should move single draggable node', () {
        // Arrange
        final node = createTestNode(
          id: 'node-1',
          position: const Offset(100, 100),
          draggable: true,
        );
        final state = createTestState(nodes: {'node-1': node});
        const delta = Offset(50, 30);

        // Act
        final newState = service.moveNodes(state, ['node-1'], delta);

        // Assert
        expect(newState.nodes['node-1']!.position, equals(const Offset(150, 130)));
      });

      test('should move multiple nodes', () {
        // Arrange
        final nodes = {
          'node-1': createTestNode(id: 'node-1', position: const Offset(100, 100)),
          'node-2': createTestNode(id: 'node-2', position: const Offset(200, 200)),
        };
        final state = createTestState(nodes: nodes);
        const delta = Offset(10, 20);

        // Act
        final newState = service.moveNodes(state, ['node-1', 'node-2'], delta);

        // Assert
        expect(newState.nodes['node-1']!.position, equals(const Offset(110, 120)));
        expect(newState.nodes['node-2']!.position, equals(const Offset(210, 220)));
      });

      test('should skip non-draggable nodes', () {
        // Arrange
        final nodes = {
          'node-1': createTestNode(
            id: 'node-1',
            position: const Offset(100, 100),
            draggable: false,
          ),
          'node-2': createTestNode(
            id: 'node-2',
            position: const Offset(200, 200),
            draggable: true,
          ),
        };
        final state = createTestState(nodes: nodes);
        const delta = Offset(10, 20);

        // Act
        final newState = service.moveNodes(state, ['node-1', 'node-2'], delta);

        // Assert
        expect(newState.nodes['node-1']!.position, equals(const Offset(100, 100))); // Unchanged
        expect(newState.nodes['node-2']!.position, equals(const Offset(210, 220))); // Moved
      });

      test('should return same state when delta is zero', () {
        // Arrange
        final node = createTestNode(id: 'node-1');
        final state = createTestState(nodes: {'node-1': node});

        // Act
        final newState = service.moveNodes(state, ['node-1'], Offset.zero);

        // Assert
        expect(newState, equals(state));
      });

      test('should return same state when node list is empty', () {
        // Arrange
        final state = createTestState();

        // Act
        final newState = service.moveNodes(state, [], const Offset(10, 10));

        // Assert
        expect(newState, equals(state));
      });
    });

    group('moveSelectedNodes', () {
      test('should move all selected nodes', () {
        // Arrange
        final nodes = {
          'node-1': createTestNode(id: 'node-1', position: const Offset(100, 100)),
          'node-2': createTestNode(id: 'node-2', position: const Offset(200, 200)),
          'node-3': createTestNode(id: 'node-3', position: const Offset(300, 300)),
        };
        final state = createTestState(
          nodes: nodes,
          selectedNodes: {'node-1', 'node-3'},
        );
        const delta = Offset(25, 25);

        // Act
        final newState = service.moveSelectedNodes(state, delta);

        // Assert
        expect(newState.nodes['node-1']!.position, equals(const Offset(125, 125)));
        expect(newState.nodes['node-2']!.position, equals(const Offset(200, 200))); // Unchanged
        expect(newState.nodes['node-3']!.position, equals(const Offset(325, 325)));
      });

      test('should return same state when no nodes are selected', () {
        // Arrange
        final node = createTestNode(id: 'node-1');
        final state = createTestState(nodes: {'node-1': node});

        // Act
        final newState = service.moveSelectedNodes(state, const Offset(10, 10));

        // Assert
        expect(newState, equals(state));
      });
    });

    // =========================================================================
    // updateNode & updateNodeRuntimeState
    // =========================================================================

    group('updateNode', () {
      test('should update existing node', () {
        // Arrange
        final node = createTestNode(id: 'node-1', position: const Offset(100, 100));
        final state = createTestState(nodes: {'node-1': node});
        final updatedNode = node.copyWith(position: const Offset(200, 200));

        // Act
        final newState = service.updateNode(state, updatedNode);

        // Assert
        expect(newState.nodes['node-1']!.position, equals(const Offset(200, 200)));
      });

      test('should return same state when node does not exist', () {
        // Arrange
        final state = createTestState();
        final node = createTestNode(id: 'non-existent');

        // Act
        final newState = service.updateNode(state, node);

        // Assert
        expect(newState, equals(state));
      });

      test('should update node index', () {
        // Arrange
        final node = createTestNode(
          id: 'node-1',
          position: const Offset(100, 100),
          size: const Size(200, 100),
        );
        final state = createTestState(nodes: {'node-1': node});
        final updatedNode = node.copyWith(
          position: const Offset(500, 500),
          size: const Size(300, 200),
        );

        // Act
        final newState = service.updateNode(state, updatedNode);

        // Assert
        final indexedNode = newState.nodeIndex.getNode('node-1');
        expect(indexedNode, isNotNull);
        expect(indexedNode!.position, equals(const Offset(500, 500)));
        expect(indexedNode.size, equals(const Size(300, 200)));
      });
    });

    group('updateNodeRuntimeState', () {
      test('should update runtime state', () {
        // Arrange
        final state = createTestState(
          nodeStates: {
            'node-1': createTestNodeRuntimeState(selected: false, hovered: false),
          },
        );
        final newRuntimeState = createTestNodeRuntimeState(selected: true, hovered: true);

        // Act
        final newState = service.updateNodeRuntimeState(state, 'node-1', newRuntimeState);

        // Assert
        expect(newState.nodeStates['node-1']!.selected, isTrue);
        expect(newState.nodeStates['node-1']!.hovered, isTrue);
      });

      test('should create runtime state if it does not exist', () {
        // Arrange
        final state = createTestState();
        final runtimeState = createTestNodeRuntimeState(dragging: true);

        // Act
        final newState = service.updateNodeRuntimeState(state, 'node-1', runtimeState);

        // Assert
        expect(newState.nodeStates.containsKey('node-1'), isTrue);
        expect(newState.nodeStates['node-1']!.dragging, isTrue);
      });

      test('should return same state when nodeId is empty', () {
        // Arrange
        final state = createTestState();
        final runtimeState = createTestNodeRuntimeState();

        // Act
        final newState = service.updateNodeRuntimeState(state, '', runtimeState);

        // Assert
        expect(newState, equals(state));
      });
    });

    // =========================================================================
    // resizeNode - CRITICAL (has TODO comment in source)
    // =========================================================================

    group('resizeNode', () {
      test('should resize from bottomRight direction', () {
        // Arrange
        final node = createTestNode(
          id: 'node-1',
          position: const Offset(200, 200), // Center
          size: const Size(200, 100),
        );
        final state = createTestState(nodes: {'node-1': node});
        const delta = Offset(50, 30);

        // Act
        final newState = service.resizeNode(
          state,
          'node-1',
          ResizeDirection.bottomRight,
          delta,
        );

        // Assert
        final resizedNode = newState.nodes['node-1']!;
        // Bottom-right resize: expands width and height, keeps top-left fixed
        expect(resizedNode.size.width, equals(250));
        expect(resizedNode.size.height, equals(130));
        // Position (center) should shift to accommodate new size
        expect(resizedNode.position.dx, equals(225)); // 100 + 250/2
        expect(resizedNode.position.dy, equals(215)); // 150 + 130/2
      });

      test('should resize from topLeft direction', () {
        // Arrange
        final node = createTestNode(
          id: 'node-1',
          position: const Offset(200, 200),
          size: const Size(200, 100),
        );
        final state = createTestState(nodes: {'node-1': node});
        const delta = Offset(-50, -30); // Moving top-left inward (shrinking)

        // Act
        final newState = service.resizeNode(
          state,
          'node-1',
          ResizeDirection.topLeft,
          delta,
        );

        // Assert
        final resizedNode = newState.nodes['node-1']!;
        expect(resizedNode.size.width, equals(250));
        expect(resizedNode.size.height, equals(130));
      });

      test('should resize from topRight direction', () {
        // Arrange
        final node = createTestNode(
          id: 'node-1',
          position: const Offset(200, 200),
          size: const Size(200, 100),
        );
        final state = createTestState(nodes: {'node-1': node});
        const delta = Offset(40, -20);

        // Act
        final newState = service.resizeNode(
          state,
          'node-1',
          ResizeDirection.topRight,
          delta,
        );

        // Assert
        final resizedNode = newState.nodes['node-1']!;
        expect(resizedNode.size.width, equals(240));
        expect(resizedNode.size.height, equals(120));
      });

      test('should resize from bottomLeft direction', () {
        // Arrange
        final node = createTestNode(
          id: 'node-1',
          position: const Offset(200, 200),
          size: const Size(200, 100),
        );
        final state = createTestState(nodes: {'node-1': node});
        const delta = Offset(-30, 40);

        // Act
        final newState = service.resizeNode(
          state,
          'node-1',
          ResizeDirection.bottomLeft,
          delta,
        );

        // Assert
        final resizedNode = newState.nodes['node-1']!;
        expect(resizedNode.size.width, equals(230));
        expect(resizedNode.size.height, equals(140));
      });

      test('should resize from top direction', () {
        // Arrange
        final node = createTestNode(
          id: 'node-1',
          position: const Offset(200, 200),
          size: const Size(200, 100),
        );
        final state = createTestState(nodes: {'node-1': node});
        const delta = Offset(0, -25);

        // Act
        final newState = service.resizeNode(
          state,
          'node-1',
          ResizeDirection.top,
          delta,
        );

        // Assert
        final resizedNode = newState.nodes['node-1']!;
        expect(resizedNode.size.width, equals(200)); // Width unchanged
        expect(resizedNode.size.height, equals(125));
      });

      test('should resize from bottom direction', () {
        // Arrange
        final node = createTestNode(
          id: 'node-1',
          position: const Offset(200, 200),
          size: const Size(200, 100),
        );
        final state = createTestState(nodes: {'node-1': node});
        const delta = Offset(0, 35);

        // Act
        final newState = service.resizeNode(
          state,
          'node-1',
          ResizeDirection.bottom,
          delta,
        );

        // Assert
        final resizedNode = newState.nodes['node-1']!;
        expect(resizedNode.size.width, equals(200)); // Width unchanged
        expect(resizedNode.size.height, equals(135));
      });

      test('should resize from left direction', () {
        // Arrange
        final node = createTestNode(
          id: 'node-1',
          position: const Offset(200, 200),
          size: const Size(200, 100),
        );
        final state = createTestState(nodes: {'node-1': node});
        const delta = Offset(-40, 0);

        // Act
        final newState = service.resizeNode(
          state,
          'node-1',
          ResizeDirection.left,
          delta,
        );

        // Assert
        final resizedNode = newState.nodes['node-1']!;
        expect(resizedNode.size.width, equals(240));
        expect(resizedNode.size.height, equals(100)); // Height unchanged
      });

      test('should resize from right direction', () {
        // Arrange
        final node = createTestNode(
          id: 'node-1',
          position: const Offset(200, 200),
          size: const Size(200, 100),
        );
        final state = createTestState(nodes: {'node-1': node});
        const delta = Offset(45, 0);

        // Act
        final newState = service.resizeNode(
          state,
          'node-1',
          ResizeDirection.right,
          delta,
        );

        // Assert
        final resizedNode = newState.nodes['node-1']!;
        expect(resizedNode.size.width, equals(245));
        expect(resizedNode.size.height, equals(100)); // Height unchanged
      });

      test('should respect minimum size constraints', () {
        // Arrange
        final node = createTestNode(
          id: 'node-1',
          position: const Offset(200, 200),
          size: const Size(100, 80),
        );
        final state = createTestState(nodes: {'node-1': node});
        // Try to shrink beyond minimum
        const delta = Offset(-200, -200);

        // Act
        final newState = service.resizeNode(
          state,
          'node-1',
          ResizeDirection.topLeft,
          delta,
          minSize: const Size(50, 50),
        );

        // Assert
        final resizedNode = newState.nodes['node-1']!;
        expect(resizedNode.size.width, greaterThanOrEqualTo(50));
        expect(resizedNode.size.height, greaterThanOrEqualTo(50));
      });

      test('should return same state when delta is zero', () {
        // Arrange
        final node = createTestNode(id: 'node-1');
        final state = createTestState(nodes: {'node-1': node});

        // Act
        final newState = service.resizeNode(
          state,
          'node-1',
          ResizeDirection.bottomRight,
          Offset.zero,
        );

        // Assert
        expect(newState, equals(state));
      });

      test('should return same state when node does not exist', () {
        // Arrange
        final state = createTestState();

        // Act
        final newState = service.resizeNode(
          state,
          'non-existent',
          ResizeDirection.bottomRight,
          const Offset(10, 10),
        );

        // Assert
        expect(newState, equals(state));
      });
    });
  });
}
