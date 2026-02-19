import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:optopus/features/collections/domain/repositories/collection_remote_data_source.dart';

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

  @override
  Future<Map<String, dynamic>> updateCollection({
    required String collectionId,
    String? name,
    String? description,
    String? parentId,
  }) async {
    final updates = <String, dynamic>{};
    if (name != null) updates['name'] = name;
    if (description != null) updates['description'] = description;
    if (parentId != null) updates['parent_id'] = parentId;
    updates['updated_at'] = DateTime.now().toIso8601String();

    if (updates.isNotEmpty) {
      final response = await supabaseClient
          .from('collections')
          .update(updates)
          .eq('id', collectionId)
          .select()
          .single();
      return response;
    } else {
      // If no updates, fetch the current state to return
      final response = await supabaseClient
          .from('collections')
          .select()
          .eq('id', collectionId)
          .single();
      return response;
    }
  }
}
