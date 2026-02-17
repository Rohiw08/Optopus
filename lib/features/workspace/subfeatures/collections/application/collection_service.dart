import 'package:optopus/features/workspace/subfeatures/collections/domain/entities/collection_entity.dart';
import 'package:optopus/features/workspace/subfeatures/collections/domain/repositories/collection_repository.dart';

class CollectionService {
  final CollectionRepository _repository;

  CollectionService(this._repository);

  Future<List<CollectionEntity>> getCollections(String workspaceId) async {
    final result = await _repository.getCollections(workspaceId);
    return result.fold(
      (failure) => throw failure,
      (collections) => collections,
    );
  }

  Future<CollectionEntity> createCollection({
    required String name,
    required String workspaceId,
    String? parentId,
  }) async {
    final result = await _repository.createCollection(
      name: name,
      workspaceId: workspaceId,
      parentId: parentId,
    );
    return result.fold((failure) => throw failure, (collection) => collection);
  }

  Future<void> deleteCollection(String collectionId) async {
    final result = await _repository.deleteCollection(collectionId);
    return result.fold((failure) => throw failure, (_) {});
  }
}
