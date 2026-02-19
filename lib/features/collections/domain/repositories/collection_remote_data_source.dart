abstract class CollectionRemoteDataSource {
  Future<List<Map<String, dynamic>>> getCollections(String workspaceId);
  Future<Map<String, dynamic>> createCollection({
    required String name,
    required String workspaceId,
    String? parentId,
  });
  Future<void> deleteCollection(String collectionId);
  Future<Map<String, dynamic>> updateCollection({
    required String collectionId,
    String? name,
    String? description,
    String? parentId,
  });
}
