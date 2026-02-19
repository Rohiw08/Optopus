import 'package:optopus/features/collections/domain/entities/collection_entity.dart';
import 'package:optopus/features/collections/providers.dart';
import 'package:optopus/features/flows/presentation/controllers/flow_list_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:optopus/features/collections/data/models/collection_model.dart';

part 'collection_list_controller.g.dart';

@riverpod
class CollectionSearchQuery extends _$CollectionSearchQuery {
  @override
  String build() => '';

  void setQuery(String query) {
    state = query;
  }
}

@riverpod
class IsCreatingCollection extends _$IsCreatingCollection {
  @override
  bool build() => false;

  void toggle() {
    state = !state;
  }

  void set(bool value) {
    state = value;
  }
}

@riverpod
class RenamingCollectionId extends _$RenamingCollectionId {
  @override
  String? build() => null;

  void set(String? id) {
    state = id;
  }
}

@riverpod
class CreatingSubCollectionForId extends _$CreatingSubCollectionForId {
  @override
  String? build() => null;

  void set(String? id) {
    state = id;
  }
}

@riverpod
class CreatingFlowForCollectionId extends _$CreatingFlowForCollectionId {
  @override
  String? build() => null;

  void set(String? id) => state = id;
}

@riverpod
class CollectionListController extends _$CollectionListController {
  @override
  Future<List<CollectionEntity>> build(String workspaceId) async {
    final collections = await ref
        .read(collectionServiceProvider)
        .getCollections(workspaceId);
    final query = ref.watch(collectionSearchQueryProvider);

    if (query.isEmpty) {
      return collections;
    }

    final lowerQuery = query.toLowerCase();

    // We need to identify which collections match the query directly,
    // OR contain flows that match the query.
    // FlowListController already filters by query, so if it returns items, we have matches.

    final matchingCollections = <CollectionEntity>{};

    for (final c in collections) {
      // 1. Direct match
      if (c.name.toLowerCase().contains(lowerQuery) ||
          (c.description?.toLowerCase().contains(lowerQuery) ?? false)) {
        matchingCollections.add(c);
        continue;
      }

      // 2. Flow match (watching the provider ensures we get updates and it uses the same query)
      final flowsAsync = ref.watch(flowListControllerProvider(c.id));

      // If data is available and list is not empty (meaning filters matched something)
      if (flowsAsync.hasValue && flowsAsync.value!.isNotEmpty) {
        matchingCollections.add(c);
      }
    }

    final result = <CollectionEntity>{...matchingCollections};

    for (final match in matchingCollections) {
      var current = match;
      while (current.parentId != null) {
        final parent = collections.firstWhere(
          (c) => c.id == current.parentId,
          orElse: () => current, // Should not happen if integrity is good
        );
        if (parent == current) break; // Parent not found or cycle
        result.add(parent);
        current = parent;
      }
    }

    return result.toList();
  }

  Future<void> createCollection({
    required String name,
    required String workspaceId,
    String? parentId,
  }) async {
    final previousState = state;
    final tempId = 'temp_${DateTime.now().millisecondsSinceEpoch}';
    final tempCollection = CollectionModel(
      id: tempId,
      workspaceId: workspaceId,
      name: name,
      parentId: parentId,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    // Optimistic Prepend
    if (state.hasValue) {
      state = AsyncData([tempCollection, ...state.value!]);
    }

    try {
      final newCollection = await ref
          .read(collectionServiceProvider)
          .createCollection(
            name: name,
            workspaceId: workspaceId,
            parentId: parentId,
          );

      // Replace temp with actual
      if (state.hasValue) {
        state = AsyncData(
          state.value!.map((c) => c.id == tempId ? newCollection : c).toList(),
        );
      }
    } catch (e) {
      // Revert on failure
      state = previousState;
      rethrow;
    }
  }

  Future<void> deleteCollection(String collectionId, String workspaceId) async {
    final previousState = state;
    // Optimistic update
    if (state.hasValue) {
      state = AsyncData(
        state.value!.where((element) => element.id != collectionId).toList(),
      );
    }

    try {
      await ref.read(collectionServiceProvider).deleteCollection(collectionId);
    } catch (e) {
      // Revert on failure
      state = previousState;
      rethrow;
    }
  }

  Future<void> updateCollection({
    required String collectionId,
    required String workspaceId,
    String? name,
    String? description,
    String? parentId,
  }) async {
    final previousState = state;

    try {
      final updatedCollection = await ref
          .read(collectionServiceProvider)
          .updateCollection(
            collectionId: collectionId,
            name: name,
            description: description,
            parentId: parentId,
          );

      // Update with actual result
      if (state.hasValue) {
        state = AsyncData(
          state.value!
              .map((c) => c.id == collectionId ? updatedCollection : c)
              .toList(),
        );
      }
    } catch (e) {
      state = previousState;
      rethrow;
    }
  }
}
