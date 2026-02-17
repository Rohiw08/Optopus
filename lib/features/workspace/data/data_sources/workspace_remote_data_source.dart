import 'package:supabase_flutter/supabase_flutter.dart';

/// Remote data source for workspace-related operations using Supabase
class WorkspaceRemoteDataSource {
  final SupabaseClient _supabase;

  WorkspaceRemoteDataSource(this._supabase);

  // ── Workspaces ──

  Future<Map<String, dynamic>> createWorkspace({
    required String name,
    String? description,
  }) async {
    final userId = _supabase.auth.currentUser?.id;
    if (userId == null) throw Exception('User not authenticated');

    final response = await _supabase
        .from('workspaces')
        .insert({'name': name, 'description': description, 'owner_id': userId})
        .select()
        .single();

    return response;
  }

  Future<List<Map<String, dynamic>>> getUserWorkspaces() async {
    final userId = _supabase.auth.currentUser?.id;
    if (userId == null) throw Exception('User not authenticated');

    final response = await _supabase
        .from('workspaces')
        .select()
        .or('owner_id.eq.$userId');

    return (response as List).cast<Map<String, dynamic>>();
  }

  Future<Map<String, dynamic>> getWorkspace(String workspaceId) async {
    final response = await _supabase
        .from('workspaces')
        .select()
        .eq('id', workspaceId)
        .single();

    return response;
  }

  Future<void> updateWorkspace({
    required String workspaceId,
    String? name,
    String? description,
  }) async {
    final updates = <String, dynamic>{};
    if (name != null) updates['name'] = name;
    if (description != null) updates['description'] = description;

    if (updates.isEmpty) return;

    await _supabase.from('workspaces').update(updates).eq('id', workspaceId);
  }

  Future<void> deleteWorkspace(String workspaceId) async {
    await _supabase.from('workspaces').delete().eq('id', workspaceId);
  }

  // ── Members ──

  Future<List<Map<String, dynamic>>> getMembers(String workspaceId) async {
    final response = await _supabase
        .from('workspace_members')
        .select('''
          *,
          profiles:user_id (
            full_name,
            avatar_url
          )
        ''')
        .eq('workspace_id', workspaceId);

    return (response as List).cast<Map<String, dynamic>>();
  }

  Future<String?> findUserIdByEmail(String email) async {
    try {
      final response = await _supabase
          .from('profiles')
          .select('id')
          .eq('email', email)
          .single();

      return response['id'] as String?;
    } catch (_) {
      return null;
    }
  }

  Future<void> inviteMember({
    required String workspaceId,
    required String userId,
    required String role,
  }) async {
    await _supabase.from('workspace_members').insert({
      'workspace_id': workspaceId,
      'user_id': userId,
      'role': role,
    });
  }

  Future<void> updateMemberRole({
    required String memberId,
    required String role,
  }) async {
    await _supabase
        .from('workspace_members')
        .update({'role': role})
        .eq('id', memberId);
  }

  Future<void> removeMember(String memberId) async {
    await _supabase.from('workspace_members').delete().eq('id', memberId);
  }
}
