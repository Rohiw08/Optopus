import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:optopus/features/workspace/subfeatures/collections/data/datasources/collection_remote_data_source.dart';

class CollectionRemoteDataSourceImpl implements CollectionRemoteDataSource {
  final SupabaseClient supabaseClient;

  CollectionRemoteDataSourceImpl(this.supabaseClient);

  @override
  Future<List<Map<String, dynamic>>> getCollections(String workspaceId) async {
    final response = await supabaseClient
        .from('collections')
        .select()
        .eq('workspace_id', workspaceId);

    return List<Map<String, dynamic>>.from(response);
  }

  @override
  Future<Map<String, dynamic>> createCollection({
    required String name,
    required String workspaceId,
    String? parentId,
  }) async {
    final response = await supabaseClient
        .from('collections')
        .insert({
          'name': name,
          'workspace_id': workspaceId,
          'parent_id': parentId,
        })
        .select()
        .single();

    return response;
  }

  @override
  Future<void> deleteCollection(String collectionId) async {
    await supabaseClient.from('collections').delete().eq('id', collectionId);
  }
}
