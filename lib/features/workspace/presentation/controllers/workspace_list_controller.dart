import 'package:optopus/features/workspace/domain/entities/workspace_entity.dart';
import 'package:optopus/features/workspace/providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'workspace_list_controller.g.dart';

@Riverpod(keepAlive: true)
class WorkspaceListController extends _$WorkspaceListController {
  @override
  Future<List<WorkspaceEntity>> build() {
    return ref.read(workspaceServiceProvider).getUserWorkspaces();
  }

  Future<WorkspaceEntity?> createWorkspace({
    required String name,
    String? description,
  }) async {
    state = const AsyncLoading();
    WorkspaceEntity? createdWorkspace;
    state = await AsyncValue.guard(() async {
      createdWorkspace = await ref
          .read(workspaceServiceProvider)
          .createWorkspace(name: name, description: description);
      return ref.read(workspaceServiceProvider).getUserWorkspaces();
    });
    return createdWorkspace;
  }

  Future<void> deleteWorkspace(String workspaceId) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref.read(workspaceServiceProvider).deleteWorkspace(workspaceId);
      return ref.read(workspaceServiceProvider).getUserWorkspaces();
    });
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(workspaceServiceProvider).getUserWorkspaces(),
    );
  }

  Future<void> inviteMember({
    required String workspaceId,
    required String email,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref
          .read(workspaceServiceProvider)
          .inviteMember(workspaceId: workspaceId, email: email);
      return ref.read(workspaceServiceProvider).getUserWorkspaces();
    });
  }
}
