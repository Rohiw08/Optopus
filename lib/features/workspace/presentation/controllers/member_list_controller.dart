import 'package:optopus/features/workspace/domain/entities/workspace_member_entity.dart';
import 'package:optopus/features/workspace/domain/enums/workspace_role.dart';
import 'package:optopus/features/workspace/providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'member_list_controller.g.dart';

@Riverpod(keepAlive: true)
class MemberListController extends _$MemberListController {
  @override
  Future<List<WorkspaceMemberEntity>> build(String workspaceId) {
    return ref.watch(workspaceServiceProvider).getMembers(workspaceId);
  }

  Future<void> _performAction(Future<void> Function() action) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await action();
      return ref.read(workspaceServiceProvider).getMembers(workspaceId);
    });
  }

  Future<void> inviteMember({
    required String email,
    WorkspaceRole role = WorkspaceRole.viewer,
  }) async {
    await _performAction(
      () => ref
          .read(workspaceServiceProvider)
          .inviteMember(workspaceId: workspaceId, email: email, role: role),
    );
  }

  Future<void> updateRole({
    required String memberId,
    required WorkspaceRole role,
  }) async {
    await _performAction(
      () => ref
          .read(workspaceServiceProvider)
          .updateMemberRole(memberId: memberId, role: role),
    );
  }

  Future<void> removeMember(String memberId) async {
    await _performAction(
      () => ref.read(workspaceServiceProvider).removeMember(memberId),
    );
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(workspaceServiceProvider).getMembers(workspaceId),
    );
  }
}
