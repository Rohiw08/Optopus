import 'package:optopus/features/workspace/domain/entities/workspace_entity.dart';
import 'package:optopus/features/workspace/domain/entities/workspace_member_entity.dart';

import 'package:optopus/features/workspace/domain/enums/workspace_role.dart';
import 'package:optopus/features/workspace/domain/repositories/workspace_repository.dart';

class WorkspaceService {
  final WorkspaceRepository _repository;

  WorkspaceService(this._repository);

  // ── Workspaces ──

  Future<WorkspaceEntity> createWorkspace({
    required String name,
    String? description,
  }) {
    final trimmedName = name.trim();
    if (trimmedName.isEmpty) {
      throw ArgumentError('Workspace name cannot be empty');
    }
    return _repository.createWorkspace(
      name: trimmedName,
      description: description?.trim(),
    );
  }

  Future<List<WorkspaceEntity>> getUserWorkspaces() {
    return _repository.getUserWorkspaces();
  }

  Future<WorkspaceEntity> getWorkspace(String workspaceId) {
    return _repository.getWorkspace(workspaceId);
  }

  Future<void> updateWorkspace({
    required String workspaceId,
    String? name,
    String? description,
  }) {
    final trimmedName = name?.trim();
    if (trimmedName != null && trimmedName.isEmpty) {
      throw ArgumentError('Workspace name cannot be empty');
    }
    return _repository.updateWorkspace(
      workspaceId: workspaceId,
      name: trimmedName,
      description: description?.trim(),
    );
  }

  Future<void> deleteWorkspace(String workspaceId) {
    return _repository.deleteWorkspace(workspaceId);
  }

  // ── Members ──

  Future<List<WorkspaceMemberEntity>> getMembers(String workspaceId) {
    return _repository.getMembers(workspaceId);
  }

  Future<void> inviteMember({
    required String workspaceId,
    required String email,
    WorkspaceRole role = WorkspaceRole.viewer,
  }) {
    final trimmedEmail = email.trim();
    if (!trimmedEmail.contains('@')) {
      throw ArgumentError('Invalid email address');
    }
    return _repository.inviteMember(
      workspaceId: workspaceId,
      email: trimmedEmail,
      role: role,
    );
  }

  Future<void> updateMemberRole({
    required String memberId,
    required WorkspaceRole role,
  }) {
    return _repository.updateMemberRole(memberId: memberId, role: role);
  }

  Future<void> removeMember(String memberId) {
    return _repository.removeMember(memberId);
  }
}
