import 'package:optopus/features/collections/domain/entities/collection_entity.dart';
import 'package:optopus/features/collections/providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'collection_list_controller.g.dart';

@riverpod
class CollectionListController extends _$CollectionListController {
  @override
  Future<List<CollectionEntity>> build(String workspaceId) {
    return ref.read(collectionServiceProvider).getCollections(workspaceId);
  }

  Future<void> createCollection({
    required String name,
    required String workspaceId,
    String? parentId,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref
          .read(collectionServiceProvider)
          .createCollection(
            name: name,
            workspaceId: workspaceId,
            parentId: parentId,
          );
      return ref.read(collectionServiceProvider).getCollections(workspaceId);
    });
  }

  Future<void> deleteCollection(String collectionId, String workspaceId) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref.read(collectionServiceProvider).deleteCollection(collectionId);
      return ref.read(collectionServiceProvider).getCollections(workspaceId);
    });
  }
}
