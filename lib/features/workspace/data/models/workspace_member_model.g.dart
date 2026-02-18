// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workspace_member_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_WorkspaceMemberModel _$WorkspaceMemberModelFromJson(
  Map<String, dynamic> json,
) => _WorkspaceMemberModel(
  id: json['id'] as String,
  workspaceId: json['workspace_id'] as String,
  userId: json['user_id'] as String,
  role: $enumDecode(_$WorkspaceRoleEnumMap, json['role']),
  joinedAt: DateTime.parse(json['joined_at'] as String),
  profile: json['profile'] == null
      ? null
      : AccountEntity.fromJson(json['profile'] as Map<String, dynamic>),
);

Map<String, dynamic> _$WorkspaceMemberModelToJson(
  _WorkspaceMemberModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'workspace_id': instance.workspaceId,
  'user_id': instance.userId,
  'role': _$WorkspaceRoleEnumMap[instance.role]!,
  'joined_at': instance.joinedAt.toIso8601String(),
  'profile': instance.profile,
};

const _$WorkspaceRoleEnumMap = {
  WorkspaceRole.admin: 'admin',
  WorkspaceRole.editor: 'editor',
  WorkspaceRole.viewer: 'viewer',
};
