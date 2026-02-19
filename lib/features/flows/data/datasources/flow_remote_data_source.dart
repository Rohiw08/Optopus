abstract class FlowRemoteDataSource {
  Future<List<Map<String, dynamic>>> getFlows(String collectionId);
  Future<List<Map<String, dynamic>>> getFlowsByWorkspace(String workspaceId);
  Future<Map<String, dynamic>> createFlow({
    required String name,
    required String collectionId,
    Map<String, dynamic>? data,
  });
  Future<void> updateFlow({
    required String flowId,
    String? name,
    Map<String, dynamic>? data,
  });
  Future<void> deleteFlow(String flowId);
  Future<Map<String, dynamic>> getFlowById(String flowId);
}
