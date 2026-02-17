import 'package:optopus/core/domain/failures/failure.dart';
import 'package:optopus/features/workspace/domain/entities/workspace_entity.dart';
import 'package:optopus/features/workspace/subfeatures/collections/domain/entities/collection_entity.dart';
import 'package:optopus/features/workspace/subfeatures/flows/domain/entities/flow_entity.dart';
import 'package:optopus/features/workspace/subfeatures/collections/application/collection_service.dart';
import 'package:optopus/features/workspace/subfeatures/flows/application/flow_service.dart';

/// Service layer for Home feature
/// Handles business logic for workspace navigation and opening
class HomeService {
  final CollectionService _collectionService;
  final FlowService _flowService;

  HomeService(this._collectionService, this._flowService);

  /// Opens a workspace by ensuring it has a collection and flow
  /// Creates default collection and flow if they don't exist
  /// Returns the flow to open in the editor
  Future<FlowEntity> openWorkspace(WorkspaceEntity workspace) async {
    try {
      // 1. Get or create collection
      final collection = await _getOrCreateCollection(workspace.id);

      // 2. Get or create flow
      final flow = await _getOrCreateFlow(collection.id);

      return flow;
    } on WorkspaceFailure {
      rethrow;
    } catch (e) {
      throw UnknownWorkspaceFailure('Failed to open workspace: $e');
    }
  }

  /// Gets existing collection or creates a default one
  Future<CollectionEntity> _getOrCreateCollection(String workspaceId) async {
    final collections = await _collectionService.getCollections(workspaceId);

    if (collections.isNotEmpty) {
      return collections.first;
    }

    // Create default collection
    return await _collectionService.createCollection(
      workspaceId: workspaceId,
      name: 'General',
    );
  }

  /// Gets existing flow or creates a default one
  Future<FlowEntity> _getOrCreateFlow(String collectionId) async {
    final flows = await _flowService.getFlows(collectionId);

    if (flows.isNotEmpty) {
      return flows.first;
    }

    // Create default flow
    return await _flowService.createFlow(
      collectionId: collectionId,
      name: 'Main Flow',
    );
  }
}
