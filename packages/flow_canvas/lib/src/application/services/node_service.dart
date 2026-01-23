import 'dart:math' as math;
import 'dart:ui';
import 'package:flow_canvas/src/domain/flow_canvas_state.dart';
import 'package:flow_canvas/src/domain/models/node.dart';
import 'package:flow_canvas/src/domain/state/node_state.dart';
import 'package:flow_canvas/src/shared/enums.dart';

class NodeService {
  FlowNode? getNode(FlowCanvasState state, String nodeId) {
    if (!state.nodes.containsKey(nodeId)) return null;
    return state.nodes[nodeId]!;
  }

  NodeRuntimeState? getNodeRuntimeState(FlowCanvasState state, String nodeId) {
    if (!state.nodeStates.containsKey(nodeId)) return null;
    return state.nodeStates[nodeId]!;
  }

  FlowCanvasState addNode(FlowCanvasState state, FlowNode node) {
    return addNodes(state, [node]);
  }

  FlowCanvasState addNodes(FlowCanvasState state, Iterable<FlowNode> nodes) {
    if (nodes.isEmpty) return state;

    final newNodes = Map<String, FlowNode>.from(state.nodes);
    var newNodeIndex = state.nodeIndex;
    var nextZ = state.maxZIndex;

    for (final node in nodes) {
      if (newNodes.containsKey(node.id)) continue;
      nextZ = math.max(nextZ + 1, node.zIndex);
      final newNode = node.copyWith(zIndex: nextZ);
      newNodes[newNode.id] = newNode;
      newNodeIndex = newNodeIndex!.addNode(newNode);
    }

    return state.copyWith(
      nodes: newNodes,
      nodeIndex: newNodeIndex,
      maxZIndex: nextZ,
    );
  }

  FlowCanvasState removeNode(FlowCanvasState state, String nodeId) {
    return removeNodes(state, [nodeId]);
  }

  FlowCanvasState removeNodes(
    FlowCanvasState state,
    Iterable<String> nodeIds,
  ) {
    if (nodeIds.isEmpty) return state;

    final newNodes = Map<String, FlowNode>.from(state.nodes);
    final newSelectedNodes = Set<String>.from(state.selectedNodes);
    var newNodeIndex = state.nodeIndex;

    final nodeIdSet = nodeIds.toSet();
    for (final nodeId in nodeIdSet) {
      if (!newNodes.containsKey(nodeId)) continue;
      final removedNode = newNodes.remove(nodeId)!;
      newNodeIndex = newNodeIndex!.removeNode(removedNode);
      newSelectedNodes.remove(nodeId);
    }

    return state.copyWith(
      nodes: newNodes,
      selectedNodes: newSelectedNodes,
      nodeIndex: newNodeIndex,
    );
  }

  FlowCanvasState moveSelectedNodes(FlowCanvasState state, Offset delta) {
    return moveNodes(state, state.selectedNodes, delta);
  }

  FlowCanvasState moveNodes(
      FlowCanvasState state, Iterable<String> nodeIds, Offset delta,
      {bool includeDescendants = true}) {
    if (delta == Offset.zero || nodeIds.isEmpty) return state;

    final newNodes = Map<String, FlowNode>.from(state.nodes);
    var newNodeIndex = state.nodeIndex!;

    // Use provided nodes directly if traversal is skipped, otherwise calculate descendants
    final Set<String> allNodesToMove =
        includeDescendants ? getDescendants(state, nodeIds) : nodeIds.toSet();

    final nodeUpdates = <FlowNode, FlowNode>{};

    for (final id in allNodesToMove) {
      final node = newNodes[id];
      if (node == null) continue;
      final draggable = node.draggable ?? true;
      if (draggable) {
        var newPosition = node.position + delta;

        // 1. Check Runtime Extent
        final runtimeState = state.nodeStates[id];
        if (runtimeState?.extent != null) {
          final extent = runtimeState!.extent!;
          newPosition = _clampPositionToRect(newPosition, node.size, extent);
        }

        // 2. Check Parent Constraints & Expansion
        if (node.parentId != null) {
          final parent = newNodes[node.parentId];
          if (parent != null) {
            // Only expand parent if the parent itself is NOT being moved
            // This prevents feedback loop when moving parent nodes
            if (node.expandParent && !allNodesToMove.contains(node.parentId)) {
              final parentRect = parent.rect;
              final childRect = Rect.fromCenter(
                center: newPosition,
                width: node.size.width,
                height: node.size.height,
              );

              // Check if child is going outside parent bounds
              if (!parentRect.contains(childRect.topLeft) ||
                  !parentRect.contains(childRect.bottomRight)) {
                // Calculate new parent bounds to include the child
                final newRight = childRect.right > parentRect.right
                    ? childRect.right
                    : parentRect.right;
                final newBottom = childRect.bottom > parentRect.bottom
                    ? childRect.bottom
                    : parentRect.bottom;
                final newLeft = childRect.left < parentRect.left
                    ? childRect.left
                    : parentRect.left;
                final newTop = childRect.top < parentRect.top
                    ? childRect.top
                    : parentRect.top;

                final newParentRect =
                    Rect.fromLTRB(newLeft, newTop, newRight, newBottom);

                if (newParentRect != parentRect) {
                  // Calculate how much the parent's position will change
                  final newParentCenter = newParentRect.center;

                  final newParent = parent.copyWith(
                    position: newParentCenter,
                    size: newParentRect.size,
                  );
                  newNodes[parent.id] = newParent;
                }
              }
            }
          }
        }

        final newNode = node.copyWith(position: newPosition);
        newNodes[id] = newNode;
      }
    }

    // Calculate batch updates for index
    for (final entry in newNodes.entries) {
      final originalNode = state.nodes[entry.key];
      if (originalNode != null && originalNode != entry.value) {
        nodeUpdates[originalNode] = entry.value;
      }
    }

    newNodeIndex = newNodeIndex.updateNodes(nodeUpdates);

    return state.copyWith(
      nodes: newNodes,
      nodeIndex: newNodeIndex,
    );
  }

  Offset _clampPositionToRect(Offset position, Size size, Rect extent) {
    double x = position.dx;
    double y = position.dy;

    // Clamp x
    if (x < extent.left) x = extent.left;
    if (x + size.width > extent.right) x = extent.right - size.width;

    // Clamp y
    if (y < extent.top) y = extent.top;
    if (y + size.height > extent.bottom) y = extent.bottom - size.height;

    return Offset(x, y);
  }

  FlowCanvasState updateNode(FlowCanvasState state, FlowNode node) {
    if (!state.nodes.containsKey(node.id)) return state;

    final oldNode = state.nodes[node.id]!;
    final newNodes = Map<String, FlowNode>.from(state.nodes);
    newNodes[node.id] = node;

    final newNodeIndex = state.nodeIndex!.updateNode(oldNode, node);

    return state.copyWith(
      nodes: newNodes,
      nodeIndex: newNodeIndex,
    );
  }

  FlowCanvasState updateNodeRuntimeState(
      FlowCanvasState state, String nodeId, NodeRuntimeState runtime) {
    if (nodeId.isEmpty) return state;

    final newNodeStates = Map<String, NodeRuntimeState>.from(state.nodeStates);
    newNodeStates[nodeId] = runtime;
    return state.copyWith(
      nodeStates: newNodeStates,
    );
  }

  // TODO: test if this function works?
  /// Resizes a single node directionally based on the gesture delta.
  ///
  /// - [direction]: Specifies the resize handle/direction (e.g., bottomRight fixes top-left).
  /// - [delta]: The gesture delta (e.g., from onPanUpdate). Positive dx/dy expands in that direction.
  /// - [minSize]: Optional minimum size to clamp to (defaults to Size(50, 50)).
  ///
  /// Returns a new state with the updated node and index. Assumes directional resizing
  /// (fixed opposite point) for intuitive UX—e.g., dragging bottom-right expands
  /// width/height while keeping top-left anchored.
  FlowCanvasState resizeNode(
    FlowCanvasState state,
    String nodeId,
    ResizeDirection direction,
    Offset delta, {
    Size minSize = const Size(50, 50),
  }) {
    final node = state.nodes[nodeId];
    if (node == null || delta == Offset.zero) return state;

    final rect = node.rect;
    double newLeft = rect.left;
    double newTop = rect.top;
    double newRight = rect.right;
    double newBottom = rect.bottom;

    switch (direction) {
      case ResizeDirection.topLeft:
        newLeft += delta.dx;
        newTop += delta.dy;
        break;
      case ResizeDirection.topRight:
        newTop += delta.dy;
        newRight += delta.dx;
        break;
      case ResizeDirection.bottomLeft:
        newLeft += delta.dx;
        newBottom += delta.dy;
        break;
      case ResizeDirection.bottomRight:
        newRight += delta.dx;
        newBottom += delta.dy;
        break;
      case ResizeDirection.top:
        newTop += delta.dy;
        break;
      case ResizeDirection.bottom:
        newBottom += delta.dy;
        break;
      case ResizeDirection.left:
        newLeft += delta.dx;
        break;
      case ResizeDirection.right:
        newRight += delta.dx;
        break;
    }

    switch (direction) {
      case ResizeDirection.topLeft:
        newLeft = math.min(newLeft, rect.right - minSize.width);
        newTop = math.min(newTop, rect.bottom - minSize.height);
        break;
      case ResizeDirection.topRight:
        newTop = math.min(newTop, rect.bottom - minSize.height);
        newRight = math.max(newRight, rect.left + minSize.width);
        break;
      case ResizeDirection.bottomLeft:
        newLeft = math.min(newLeft, rect.right - minSize.width);
        newBottom = math.max(newBottom, rect.top + minSize.height);
        break;
      case ResizeDirection.bottomRight:
        newRight = math.max(newRight, rect.left + minSize.width);
        newBottom = math.max(newBottom, rect.top + minSize.height);
        break;
      case ResizeDirection.top:
        newTop = math.min(newTop, rect.bottom - minSize.height);
        break;
      case ResizeDirection.bottom:
        newBottom = math.max(newBottom, rect.top + minSize.height);
        break;
      case ResizeDirection.left:
        newLeft = math.min(newLeft, rect.right - minSize.width);
        break;
      case ResizeDirection.right:
        newRight = math.max(newRight, rect.left + minSize.width);
        break;
    }

    final newRect = Rect.fromLTRB(newLeft, newTop, newRight, newBottom);
    final newNode = node.copyWith(
      position: newRect.center,
      size: newRect.size,
    );

    return updateNode(state, newNode);
  }

  /// returns a set of all descendant nodes for the given roots
  Set<String> getDescendants(
      FlowCanvasState state, Iterable<String> rootNodeIds) {
    if (rootNodeIds.isEmpty) return {};

    final parentToChildren = <String, List<String>>{};
    for (final node in state.nodes.values) {
      if (node.parentId != null) {
        parentToChildren.putIfAbsent(node.parentId!, () => []).add(node.id);
      }
    }

    final allNodes = <String>{};
    final queue = List<String>.from(rootNodeIds);

    while (queue.isNotEmpty) {
      final id = queue.removeLast();
      if (allNodes.contains(id)) continue;
      allNodes.add(id);

      final children = parentToChildren[id];
      if (children != null) {
        queue.addAll(children);
      }
    }
    return allNodes;
  }
}
