import 'package:fpdart/fpdart.dart';
import 'package:optopus/core/domain/failures/failure.dart';

import 'package:optopus/features/collections/domain/entities/collection_entity.dart';

abstract class CollectionRepository {
  Future<Either<Failure, List<CollectionEntity>>> getCollections(
    String workspaceId,
  );
  Future<Either<Failure, CollectionEntity>> createCollection({
    required String name,
    required String workspaceId,
    String? parentId,
  });
  Future<Either<Failure, void>> deleteCollection(String collectionId);
}
