import 'package:optopus/features/workspace/domain/entities/workspace_entity.dart';
import 'package:optopus/features/workspace/presentation/controllers/workspace_list_controller.dart';
import 'package:optopus/features/workspace/providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'workspace_actions_controller.g.dart';

@Riverpod(keepAlive: true)
class WorkspaceActionsController extends _$WorkspaceActionsController {
  @override
  AsyncValue<void> build() => const AsyncData(null);

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

      // Refresh the list after success
      ref.invalidate(workspaceListControllerProvider);
      return;
    });
    return createdWorkspace;
  }

  Future<void> deleteWorkspace(String workspaceId) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref.read(workspaceServiceProvider).deleteWorkspace(workspaceId);

      // Refresh the list after success
      ref.invalidate(workspaceListControllerProvider);
    });
  }

  Future<void> updateWorkspace({
    required String workspaceId,
    String? name,
    String? description,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref
          .read(workspaceServiceProvider)
          .updateWorkspace(
            workspaceId: workspaceId,
            name: name,
            description: description,
          );

      // Refresh the list after success
      ref.invalidate(workspaceListControllerProvider);
    });
  }

  Future<void> leaveWorkspace(String workspaceId) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref.read(workspaceServiceProvider).leaveWorkspace(workspaceId);

      // Refresh the list after success
      ref.invalidate(workspaceListControllerProvider);
    });
  }
}
