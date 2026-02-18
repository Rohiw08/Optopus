import 'package:supabase_flutter/supabase_flutter.dart';

/// Remote data source for workspace-related operations using Supabase
class WorkspaceRemoteDataSource {
  final SupabaseClient _supabase;

  WorkspaceRemoteDataSource(this._supabase);

  String get _currentUserId {
    final uid = _supabase.auth.currentUser?.id;
    if (uid == null) throw Exception('User not authenticated');
    return uid;
  }

  // ── Workspaces ──

  Future<Map<String, dynamic>> createWorkspace({
    required String name,
    String? description,
  }) async {
    final userId = _currentUserId;

    final response = await _supabase
        .from('workspaces')
        .insert({'name': name, 'description': description, 'owner_id': userId})
        .select()
        .single();

    return response;
  }

  /// Fetches all workspaces the current user owns OR is a member of.
  Future<List<Map<String, dynamic>>> getUserWorkspaces() async {
    final userId = _currentUserId;

    // FIX: original .or('owner_id.eq.$userId') only fetched owned workspaces
    // and ignored workspaces the user joined as a member.
    // We use the helper function we created in SQL which handles both cases.
    final response = await _supabase.rpc(
      'get_user_workspaces',
      params: {'user_uuid': userId},
    );

    return (response as List).cast<Map<String, dynamic>>();
  }

  /// Fetches all workspaces with full details (name, description, member count etc.)
  /// for the current user — both owned and joined.
  Future<List<Map<String, dynamic>>> getUserWorkspacesWithStats() async {
    final userId = _currentUserId;

    // Pull from the view which includes member_count and collection_count
    // RLS on the view ensures only accessible workspaces are returned
    final response = await _supabase
        .from('workspaces_with_stats')
        .select()
        .or(
          'owner_id.eq.$userId,id.in.(${await _getMemberWorkspaceIds(userId)})',
        );

    return (response as List).cast<Map<String, dynamic>>();
  }

  /// Helper: get workspace IDs where user is a member (not owner)
  Future<String> _getMemberWorkspaceIds(String userId) async {
    final memberships = await _supabase
        .from('workspace_members')
        .select('workspace_id')
        .eq('user_id', userId);

    final ids = (memberships as List)
        .map((m) => m['workspace_id'] as String)
        .toList();

    // Return comma-separated for use in .in() filter
    // If empty return a placeholder that won't match anything
    return ids.isEmpty ? '00000000-0000-0000-0000-000000000000' : ids.join(',');
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

  // ── Search ──

  /// Search workspaces by name — returns only workspaces the user has access to.
  /// RLS ensures users can't see workspaces they don't belong to.
  Future<List<Map<String, dynamic>>> searchWorkspaces(String query) async {
    if (query.trim().isEmpty) return getUserWorkspaces();

    final userId = _currentUserId;

    // ilike = case-insensitive LIKE search
    final owned = await _supabase
        .from('workspaces')
        .select()
        .eq('owner_id', userId)
        .ilike('name', '%$query%');

    final memberWorkspaceIds = await _supabase
        .from('workspace_members')
        .select('workspace_id')
        .eq('user_id', userId);

    final ids = (memberWorkspaceIds as List)
        .map((m) => m['workspace_id'] as String)
        .toList();

    List<Map<String, dynamic>> joined = [];
    if (ids.isNotEmpty) {
      joined = await _supabase
          .from('workspaces')
          .select()
          .inFilter('id', ids)
          .ilike('name', '%$query%');
    }

    // Merge and deduplicate by id
    final all = [...(owned as List).cast<Map<String, dynamic>>(), ...joined];
    final seen = <String>{};
    return all.where((w) => seen.add(w['id'] as String)).toList();
  }

  // ── Members ──

  Future<List<Map<String, dynamic>>> getMembers(String workspaceId) async {
    final response = await _supabase
        .from('workspace_members')
        .select('''
          *,
          profiles:user_id (
            id,
            username,
            full_name,
            avatar_url,
            bio,
            website,
            location,
            twitter_handle,
            github_handle,
            role,
            preferences,
            created_at,
            email
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

  /// Uses the secure SQL function to add a member (bypasses RLS safely)
  Future<void> inviteMember({
    required String workspaceId,
    required String userId,
    required String role,
  }) async {
    // FIX: direct insert into workspace_members fails due to RLS.
    // Use the add_workspace_member() security definer function instead.
    await _supabase.rpc(
      'add_workspace_member',
      params: {'ws_id': workspaceId, 'member_id': userId, 'member_role': role},
    );
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

  Future<void> leaveWorkspace(String workspaceId) async {
    final userId = _currentUserId;
    await _supabase
        .from('workspace_members')
        .delete()
        .eq('workspace_id', workspaceId)
        .eq('user_id', userId);
  }
}
