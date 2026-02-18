import 'dart:io';
import 'package:optopus/core/domain/failures/failure.dart';
import 'package:optopus/features/workspace/data/data_sources/workspace_remote_data_source.dart';
import 'package:optopus/features/workspace/data/models/workspace_member_model.dart';
import 'package:optopus/features/workspace/data/models/workspace_model.dart';
import 'package:optopus/features/workspace/domain/entities/workspace_entity.dart';
import 'package:optopus/features/workspace/domain/entities/workspace_member_entity.dart';
import 'package:optopus/features/workspace/domain/enums/workspace_role.dart';
import 'package:optopus/features/workspace/domain/repositories/workspace_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class WorkspaceRepositoryImpl implements WorkspaceRepository {
  final WorkspaceRemoteDataSource _remote;

  WorkspaceRepositoryImpl(this._remote);

  // ── Workspaces ──

  @override
  Future<WorkspaceEntity> createWorkspace({
    required String name,
    String? description,
  }) => _guard(() async {
    final json = await _remote.createWorkspace(
      name: name,
      description: description,
    );
    return WorkspaceModel.fromJson(json);
  });

  @override
  Future<List<WorkspaceEntity>> getUserWorkspaces() => _guard(() async {
    final list = await _remote.getUserWorkspaces();
    // get_user_workspaces() returns {workspace_id, workspace_name, member_role}
    // so we map it manually to WorkspaceModel
    return list.map((json) {
      return WorkspaceModel.fromJson({
        'id': json['workspace_id'],
        'name': json['workspace_name'],
        'owner_id': '', // not returned by the function, safe default
        'description': null,
        'created_at': DateTime.now().toIso8601String(),
        'updated_at': DateTime.now().toIso8601String(),
        'member_role': json['member_role'],
      });
    }).toList();
  });

  @override
  Future<List<WorkspaceEntity>> getUserWorkspacesWithStats() =>
      _guard(() async {
        // Returns full workspace rows + member_count + collection_count
        final list = await _remote.getUserWorkspacesWithStats();
        return list.map(WorkspaceModel.fromJson).toList();
      });

  @override
  Future<List<WorkspaceEntity>> searchWorkspaces(String query) =>
      _guard(() async {
        final list = await _remote.searchWorkspaces(query);
        return list.map(WorkspaceModel.fromJson).toList();
      });

  @override
  Future<WorkspaceEntity> getWorkspace(String workspaceId) => _guard(() async {
    final json = await _remote.getWorkspace(workspaceId);
    return WorkspaceModel.fromJson(json);
  });

  @override
  Future<void> updateWorkspace({
    required String workspaceId,
    String? name,
    String? description,
  }) => _guard(
    () => _remote.updateWorkspace(
      workspaceId: workspaceId,
      name: name,
      description: description,
    ),
  );

  @override
  Future<void> deleteWorkspace(String workspaceId) =>
      _guard(() => _remote.deleteWorkspace(workspaceId));

  // ── Members ──

  @override
  Future<List<WorkspaceMemberEntity>> getMembers(String workspaceId) =>
      _guard(() async {
        final list = await _remote.getMembers(workspaceId);
        // FIX: was using fromJson which can't handle nested profiles join
        return list.map(WorkspaceMemberModel.fromSupabaseJson).toList();
      });

  @override
  Future<void> inviteMember({
    required String workspaceId,
    required String email,
    WorkspaceRole role = WorkspaceRole.viewer,
  }) => _guard(() async {
    final userId = await _remote.findUserIdByEmail(email);
    if (userId == null) {
      throw const MemberNotFoundFailure('No account found for this email');
    }
    await _remote.inviteMember(
      workspaceId: workspaceId,
      userId: userId,
      role: role.name,
    );
  });

  @override
  Future<void> updateMemberRole({
    required String memberId,
    required WorkspaceRole role,
  }) => _guard(
    () => _remote.updateMemberRole(memberId: memberId, role: role.name),
  );

  @override
  Future<void> removeMember(String memberId) =>
      _guard(() => _remote.removeMember(memberId));

  @override
  Future<void> leaveWorkspace(String workspaceId) =>
      _guard(() => _remote.leaveWorkspace(workspaceId));

  // ── Error Guard ──

  Future<T> _guard<T>(Future<T> Function() fn) async {
    try {
      return await fn();
    } on PostgrestException catch (e) {
      switch (e.code) {
        case '42501' || 'PGRST301':
          throw const WorkspacePermissionDeniedFailure();
        case '23505':
          throw const MemberAlreadyExistsFailure('Member already in workspace');
        case 'PGRST116':
          throw const WorkspaceNotFoundFailure();
        default:
          throw UnknownWorkspaceFailure(e.message);
      }
    } on AuthException catch (e) {
      throw WorkspacePermissionDeniedFailure(e.message);
    } on SocketException {
      throw const NetworkFailure();
    } on Failure {
      rethrow; // already a typed failure, let it bubble up
    } catch (e) {
      throw UnknownWorkspaceFailure(e.toString());
      // FIX: was throwing const with no message, now includes actual error
    }
  }
}
