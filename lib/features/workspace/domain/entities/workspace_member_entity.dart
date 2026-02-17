import 'package:optopus/features/workspace/domain/enums/workspace_role.dart';

class WorkspaceMemberEntity {
  final String id;
  final String workspaceId;
  final String userId;
  final WorkspaceRole role;
  final DateTime joinedAt;

  // Denormalized fields from profiles join (for display)
  final String? fullName;
  final String? avatarUrl;
  final String? email;

  const WorkspaceMemberEntity({
    required this.id,
    required this.workspaceId,
    required this.userId,
    required this.role,
    required this.joinedAt,
    this.fullName,
    this.avatarUrl,
    this.email,
  });
}
