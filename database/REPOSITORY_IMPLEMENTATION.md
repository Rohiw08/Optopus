# Supabase Repository Implementation Guide

This guide shows how to implement the repository methods using the new database schema.

## Table Names Reference

- `profiles` - User profile information
- `workspaces` - Workspace entities
- `workspace_members` - Workspace membership with roles
- `collections` - Collections for organizing flows
- `flows` - Flow definitions with JSONB data

## Key Field Mappings

### Profiles Table
- `id` → `id`
- `full_name` → `fullName`
- `avatar_url` → `avatarUrl`

### Workspaces Table
- `id` → `id`
- `name` → `name`
- `description` → `description`
- `owner_id` → `ownerId`
- `created_at` → `createdAt`
- `updated_at` → `updatedAt`

### Collections Table
- `id` → `id`
- `workspace_id` → `workspaceId`
- `parent_id` → `parentId`

### Flows Table
- `id` → `id`
- `collection_id` → `collectionId`
- `data` → `data` (JSONB)

## Example Repository Queries

### Get User Workspaces
```dart
Future<List<WorkspaceEntity>> getUserWorkspaces() async {
  final userId = _supabase.auth.currentUser?.id;
  if (userId == null) throw UnauthorizedWorkspaceFailure();

  final response = await _supabase
      .from('workspaces')
      .select()
      .or('owner_id.eq.$userId,workspace_members.user_id.eq.$userId');

  return (response as List)
      .map((json) => WorkspaceModel.fromJson(json))
      .toList();
}
```

### Get Workspace Members (with Profile Data)
```dart
Future<List<WorkspaceMemberEntity>> getMembers(String workspaceId) async {
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

  return (response as List)
      .map((json) => WorkspaceMemberModel.fromJson(json))
      .toList();
}
```

### Create Workspace
```dart
Future<WorkspaceEntity> createWorkspace({
  required String name,
  String? description,
}) async {
  final userId = _supabase.auth.currentUser?.id;
  if (userId == null) throw UnauthorizedWorkspaceFailure();

  final response = await _supabase
      .from('workspaces')
      .insert({
        'name': name,
        'description': description,
        'owner_id': userId,
      })
      .select()
      .single();

  return WorkspaceModel.fromJson(response);
}
```

### Get Collections
```dart
Future<List<CollectionEntity>> getCollections(String workspaceId) async {
  final response = await _supabase
      .from('collections')
      .select()
      .eq('workspace_id', workspaceId)
      .order('created_at', ascending: false);

  return (response as List)
      .map((json) => CollectionModel.fromJson(json))
      .toList();
}
```

### Create Collection
```dart
Future<CollectionEntity> createCollection({
  required String workspaceId,
  required String name,
  String? description,
  String? parentId,
}) async {
  final response = await _supabase
      .from('collections')
      .insert({
        'workspace_id': workspaceId,
        'name': name,
        'description': description,
        'parent_id': parentId,
      })
      .select()
      .single();

  return CollectionModel.fromJson(response);
}
```

### Get Flows
```dart
Future<List<FlowEntity>> getFlows(String collectionId) async {
  final response = await _supabase
      .from('flows')
      .select()
      .eq('collection_id', collectionId)
      .order('created_at', ascending: false);

  return (response as List)
      .map((json) => FlowModel.fromJson(json))
      .toList();
}
```

### Get Single Flow
```dart
Future<FlowEntity> getFlow(String flowId) async {
  final response = await _supabase
      .from('flows')
      .select()
      .eq('id', flowId)
      .single();

  return FlowModel.fromJson(response);
}
```

### Create Flow
```dart
Future<FlowEntity> createFlow({
  required String collectionId,
  required String name,
  Map<String, dynamic>? data,
}) async {
  final response = await _supabase
      .from('flows')
      .insert({
        'collection_id': collectionId,
        'name': name,
        'data': data ?? {},
      })
      .select()
      .single();

  return FlowModel.fromJson(response);
}
```

### Update Flow
```dart
Future<void> updateFlow({
  required String flowId,
  String? name,
  Map<String, dynamic>? data,
}) async {
  final updates = <String, dynamic>{};
  if (name != null) updates['name'] = name;
  if (data != null) updates['data'] = data;

  await _supabase
      .from('flows')
      .update(updates)
      .eq('id', flowId);
}
```

### Invite Member
```dart
Future<void> inviteMember({
  required String workspaceId,
  required String email,
  WorkspaceRole role = WorkspaceRole.viewer,
}) async {
  // First, find user by email
  final userResponse = await _supabase
      .from('profiles')
      .select('id')
      .eq('email', email)
      .single();

  final userId = userResponse['id'] as String;

  // Then add as member
  await _supabase
      .from('workspace_members')
      .insert({
        'workspace_id': workspaceId,
        'user_id': userId,
        'role': role.name,
      });
}
```

### Update Member Role
```dart
Future<void> updateMemberRole({
  required String memberId,
  required WorkspaceRole role,
}) async {
  await _supabase
      .from('workspace_members')
      .update({'role': role.name})
      .eq('id', memberId);
}
```

### Delete Operations
```dart
// Delete workspace (cascades to members, collections, flows)
Future<void> deleteWorkspace(String workspaceId) async {
  await _supabase
      .from('workspaces')
      .delete()
      .eq('id', workspaceId);
}

// Delete collection (cascades to flows)
Future<void> deleteCollection(String collectionId) async {
  await _supabase
      .from('collections')
      .delete()
      .eq('id', collectionId);
}

// Delete flow
Future<void> deleteFlow(String flowId) async {
  await _supabase
      .from('flows')
      .delete()
      .eq('id', flowId);
}

// Remove member
Future<void> removeMember(String memberId) async {
  await _supabase
      .from('workspace_members')
      .delete()
      .eq('id', memberId);
}
```

## Error Handling

All repository methods should catch Supabase exceptions and convert them to domain failures:

```dart
try {
  // Supabase operation
} on PostgrestException catch (e) {
  if (e.code == '23505') {
    // Unique constraint violation
    throw DuplicateWorkspaceFailure(e.message);
  } else if (e.code == '23503') {
    // Foreign key violation
    throw WorkspaceNotFoundFailure(e.message);
  } else {
    throw UnknownWorkspaceFailure(e.message);
  }
} catch (e) {
  throw UnknownWorkspaceFailure('Unexpected error: $e');
}
```

## RLS Policy Notes

- Users can only see workspaces they own or are members of
- Only workspace owners can delete workspaces
- Editors and admins can create/update collections and flows
- Viewers have read-only access
- All policies are enforced at the database level
