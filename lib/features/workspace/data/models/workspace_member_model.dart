import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:optopus/core/models/account_entity.dart';
import 'package:optopus/features/workspace/domain/entities/workspace_member_entity.dart';
import 'package:optopus/features/workspace/domain/enums/workspace_role.dart';

part 'workspace_member_model.freezed.dart';
part 'workspace_member_model.g.dart';

@freezed
abstract class WorkspaceMemberModel extends WorkspaceMemberEntity
    with _$WorkspaceMemberModel {
  const factory WorkspaceMemberModel({
    required String id,
    @JsonKey(name: 'workspace_id') required String workspaceId,
    @JsonKey(name: 'user_id') required String userId,
    required WorkspaceRole role,
    @JsonKey(name: 'joined_at') required DateTime joinedAt,
    AccountEntity? profile,
  }) = _WorkspaceMemberModel;

  const WorkspaceMemberModel._();

  factory WorkspaceMemberModel.fromJson(Map<String, dynamic> json) =>
      _$WorkspaceMemberModelFromJson(json);

  factory WorkspaceMemberModel.fromSupabaseJson(Map<String, dynamic> json) {
    final profileData = json['profiles'] as Map<String, dynamic>?;

    return WorkspaceMemberModel(
      id: json['id'] as String,
      workspaceId: json['workspace_id'] as String,
      userId: json['user_id'] as String,

      role: _parseRole(json['role']),

      joinedAt: DateTime.parse(json['joined_at'] as String),

      profile: profileData != null ? AccountEntity.fromJson(profileData) : null,
    );
  }
  static WorkspaceRole _parseRole(dynamic value) {
    if (value == null) return WorkspaceRole.viewer;
    try {
      return WorkspaceRole.values.byName(value as String);
    } catch (_) {
      return WorkspaceRole.viewer;
    }
  }
}
