import 'package:optopus/core/models/account_entity.dart';
import 'package:optopus/features/workspace/domain/enums/workspace_role.dart';

abstract class WorkspaceMemberEntity {
  const WorkspaceMemberEntity();

  String get id;
  String get workspaceId;
  String get userId;
  WorkspaceRole get role;
  DateTime get joinedAt;

  // Normalized profile data
  AccountEntity? get profile;
}
