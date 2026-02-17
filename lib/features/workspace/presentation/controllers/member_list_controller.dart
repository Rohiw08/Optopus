import 'package:optopus/features/workspace/domain/entities/workspace_member_entity.dart';
import 'package:optopus/features/workspace/domain/enums/workspace_role.dart';
import 'package:optopus/features/workspace/providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'member_list_controller.g.dart';

@riverpod
class MemberListController extends _$MemberListController {
  @override
  Future<List<WorkspaceMemberEntity>> build(String workspaceId) {
    return ref.read(workspaceServiceProvider).getMembers(workspaceId);
  }

  Future<void> inviteMember({
    required String email,
    WorkspaceRole role = WorkspaceRole.viewer,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref
          .read(workspaceServiceProvider)
          .inviteMember(workspaceId: workspaceId, email: email, role: role);
      return ref.read(workspaceServiceProvider).getMembers(workspaceId);
    });
  }

  Future<void> updateRole({
    required String memberId,
    required WorkspaceRole role,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref
          .read(workspaceServiceProvider)
          .updateMemberRole(memberId: memberId, role: role);
      return ref.read(workspaceServiceProvider).getMembers(workspaceId);
    });
  }

  Future<void> removeMember(String memberId) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref.read(workspaceServiceProvider).removeMember(memberId);
      return ref.read(workspaceServiceProvider).getMembers(workspaceId);
    });
  }
}
