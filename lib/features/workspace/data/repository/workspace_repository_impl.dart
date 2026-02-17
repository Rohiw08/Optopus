import 'dart:io';

import 'package:optopus/core/domain/failures/failure.dart';
import 'package:optopus/features/workspace/data/data_sources/workspace_remote_data_source.dart';
import 'package:optopus/features/workspace/data/models/workspace_model.dart';
import 'package:optopus/features/workspace/data/models/workspace_member_model.dart';
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
        return list.map(WorkspaceMemberModel.fromJson).toList();
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

  // ── Error Guard ──

  Future<T> _guard<T>(Future<T> Function() fn) async {
    try {
      return await fn();
    } on PostgrestException catch (e) {
      if (e.code == '42501' || e.code == 'PGRST301') {
        throw const WorkspacePermissionDeniedFailure();
      }
      if (e.code == '23505') {
        throw const MemberAlreadyExistsFailure('Member already in workspace');
      }
      if (e.code == 'PGRST116') {
        throw const WorkspaceNotFoundFailure();
      }
      throw UnknownWorkspaceFailure(e.message);
    } on SocketException {
      throw const NetworkFailure();
    } on Failure {
      rethrow;
    } catch (_) {
      throw const UnknownWorkspaceFailure();
    }
  }
}
