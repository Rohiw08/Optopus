import 'package:optopus/features/workspace/domain/entities/workspace_entity.dart';
import 'package:optopus/features/workspace/providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'workspace_detail_controller.g.dart';

@riverpod
class WorkspaceDetailController extends _$WorkspaceDetailController {
  @override
  Future<WorkspaceEntity> build(String workspaceId) {
    return ref.watch(workspaceServiceProvider).getWorkspace(workspaceId);
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(workspaceServiceProvider).getWorkspace(workspaceId),
    );
  }
}
