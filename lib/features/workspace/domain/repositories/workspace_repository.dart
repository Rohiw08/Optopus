import 'package:optopus/features/workspace/domain/entities/workspace_entity.dart';
import 'package:optopus/features/workspace/domain/entities/workspace_member_entity.dart';
import 'package:optopus/features/workspace/domain/enums/workspace_role.dart';

abstract interface class WorkspaceRepository {
  // ── Workspaces ──

  Future<WorkspaceEntity> createWorkspace({
    required String name,
    String? description,
  });

  Future<List<WorkspaceEntity>> getUserWorkspaces();

  Future<List<WorkspaceEntity>> getUserWorkspacesWithStats();

  Future<List<WorkspaceEntity>> searchWorkspaces(String query);

  Future<WorkspaceEntity> getWorkspace(String workspaceId);

  Future<void> updateWorkspace({
    required String workspaceId,
    String? name,
    String? description,
  });

  Future<void> deleteWorkspace(String workspaceId);

  // ── Members ──

  Future<List<WorkspaceMemberEntity>> getMembers(String workspaceId);

  Future<void> inviteMember({
    required String workspaceId,
    required String email,
    WorkspaceRole role = WorkspaceRole.viewer,
  });

  Future<void> updateMemberRole({
    required String memberId,
    required WorkspaceRole role,
  });

  Future<void> removeMember(String memberId);

  Future<void> leaveWorkspace(String workspaceId);
}
