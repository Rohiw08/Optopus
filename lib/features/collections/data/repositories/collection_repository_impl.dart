import 'package:fpdart/fpdart.dart';
import 'package:optopus/core/domain/failures/failure.dart';
import 'package:optopus/features/collections/domain/repositories/collection_remote_data_source.dart';
import 'package:optopus/features/collections/data/models/collection_model.dart';
import 'package:optopus/features/collections/domain/entities/collection_entity.dart';
import 'package:optopus/features/collections/domain/repositories/collection_repository.dart';

class CollectionRepositoryImpl implements CollectionRepository {
  final CollectionRemoteDataSource remoteDataSource;

  CollectionRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<CollectionEntity>>> getCollections(
    String workspaceId,
  ) async {
    try {
      final collectionsData = await remoteDataSource.getCollections(
        workspaceId,
      );
      final collections = collectionsData
          .map((data) => CollectionModel.fromJson(data))
          .toList();
      return right(collections);
    } catch (e) {
      return left(UnknownWorkspaceFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, CollectionEntity>> createCollection({
    required String name,
    required String workspaceId,
    String? parentId,
  }) async {
    try {
      final collectionData = await remoteDataSource.createCollection(
        name: name,
        workspaceId: workspaceId,
        parentId: parentId,
      );
      return right(CollectionModel.fromJson(collectionData));
    } catch (e) {
      return left(UnknownWorkspaceFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteCollection(String collectionId) async {
    try {
      await remoteDataSource.deleteCollection(collectionId);
      return right(null);
    } catch (e) {
      return left(UnknownWorkspaceFailure(e.toString()));
    }
  }
}
