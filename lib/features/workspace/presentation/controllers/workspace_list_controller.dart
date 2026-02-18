import 'package:optopus/core/providers/auth_state_provider.dart';
import 'package:optopus/features/workspace/domain/entities/workspace_entity.dart';
import 'package:optopus/features/workspace/presentation/controllers/workspace_ui_controller.dart';
import 'package:optopus/features/workspace/providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'workspace_list_controller.g.dart';

@Riverpod(keepAlive: true)
class WorkspaceListController extends _$WorkspaceListController {
  @override
  Future<List<WorkspaceEntity>> build() async {
    // Watch auth state to ensure we rebuild on login/logout
    final authState = ref.watch(authStateProvider);

    final user = authState.value;
    if (user == null) {
      // If loading or error or unauthenticated, return empty list
      return [];
    }

    final searchQuery = ref.watch(workspaceSearchQueryProvider);
    final sortStrategy = ref.watch(workspaceSortProvider);

    List<WorkspaceEntity> workspaces;
    if (searchQuery.trim().isEmpty) {
      workspaces = await ref
          .watch(workspaceServiceProvider)
          .getUserWorkspacesWithStats();
    } else {
      workspaces = await ref
          .watch(workspaceServiceProvider)
          .searchWorkspaces(searchQuery);
    }

    // Apply Sorting
    switch (sortStrategy) {
      case WorkspaceSortStrategy.nameAz:
        workspaces.sort(
          (a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()),
        );
        break;
      case WorkspaceSortStrategy.nameZa:
        workspaces.sort(
          (a, b) => b.name.toLowerCase().compareTo(a.name.toLowerCase()),
        );
        break;
      case WorkspaceSortStrategy.lastUpdated:
        workspaces.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
        break;
      case WorkspaceSortStrategy.createdNewest:
        workspaces.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        break;
    }

    return workspaces;
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(workspaceServiceProvider).getUserWorkspacesWithStats(),
    );
  }
}
