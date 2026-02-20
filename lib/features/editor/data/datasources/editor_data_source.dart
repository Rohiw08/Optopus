import 'package:optopus/core/network/api_client.dart';

abstract interface class EditorDataSource {
  Future<Map<String, dynamic>> executeFlow({
    required String flowId,
    required Map<String, dynamic> data,
  });
}

class EditorDataSourceImpl implements EditorDataSource {
  final OptopusApiClient _apiClient;

  EditorDataSourceImpl(this._apiClient);

  @override
  Future<Map<String, dynamic>> executeFlow({
    required String flowId,
    required Map<String, dynamic> data,
  }) async {
    return await _apiClient.optimize(data);
  }
}
