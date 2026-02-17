import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:optopus/features/workspace/subfeatures/flows/data/datasources/flow_remote_data_source.dart';

class FlowRemoteDataSourceImpl implements FlowRemoteDataSource {
  final SupabaseClient supabaseClient;

  FlowRemoteDataSourceImpl(this.supabaseClient);

  @override
  Future<List<Map<String, dynamic>>> getFlows(String collectionId) async {
    final response = await supabaseClient
        .from('flows')
        .select()
        .eq('collection_id', collectionId)
        .order('created_at', ascending: false);

    return List<Map<String, dynamic>>.from(response);
  }

  @override
  Future<Map<String, dynamic>> createFlow({
    required String name,
    required String collectionId,
    Map<String, dynamic>? data,
  }) async {
    final response = await supabaseClient
        .from('flows')
        .insert({
          'name': name,
          'collection_id': collectionId,
          'data': data ?? {},
        })
        .select()
        .single();

    return response;
  }

  @override
  Future<void> updateFlow({
    required String flowId,
    String? name,
    Map<String, dynamic>? data,
  }) async {
    final updates = <String, dynamic>{};
    if (name != null) updates['name'] = name;
    if (data != null) updates['data'] = data;

    if (updates.isEmpty) return;

    await supabaseClient.from('flows').update(updates).eq('id', flowId);
  }

  @override
  Future<void> deleteFlow(String flowId) async {
    await supabaseClient.from('flows').delete().eq('id', flowId);
  }
}
