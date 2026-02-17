abstract interface class EditorDataSource {
  Future<void> executeFlow({
    required String flowId,
    required Map<String, dynamic> data,
  });
}

class EditorDataSourceImpl implements EditorDataSource {
  // TODO: Inject Supabase or Http client
  // final SupabaseClient _supabaseClient;

  EditorDataSourceImpl();

  @override
  Future<void> executeFlow({
    required String flowId,
    required Map<String, dynamic> data,
  }) async {
    // Placeholder for actual execution logic (e.g., calling an edge function)
    await Future.delayed(const Duration(seconds: 1));
    // throw Exception('Execution failed'); // Simulate error
  }
}
