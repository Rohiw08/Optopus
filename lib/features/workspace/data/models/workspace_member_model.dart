import 'package:optopus/features/workspace/domain/entities/workspace_member_entity.dart';
import 'package:optopus/features/workspace/domain/enums/workspace_role.dart';

class WorkspaceMemberModel extends WorkspaceMemberEntity {
  const WorkspaceMemberModel({
    required super.id,
    required super.workspaceId,
    required super.userId,
    required super.role,
    required super.joinedAt,
    super.fullName,
    super.avatarUrl,
    super.email,
  });

  factory WorkspaceMemberModel.fromJson(Map<String, dynamic> json) {
    // Handle joined profile data (from Supabase select with join)
    final profile = json['profiles'] as Map<String, dynamic>?;

    return WorkspaceMemberModel(
      id: json['id'] as String,
      workspaceId: json['workspace_id'] as String,
      userId: json['user_id'] as String,
      role: WorkspaceRole.values.firstWhere(
        (r) => r.name == (json['role'] as String),
        orElse: () => WorkspaceRole.viewer,
      ),
      joinedAt: DateTime.parse(json['joined_at'] as String),
      fullName: profile?['full_name'] as String?,
      avatarUrl: profile?['avatar_url'] as String?,
      email: profile?['email'] as String?,
    );
  }
}
