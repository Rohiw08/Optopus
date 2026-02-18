import 'package:optopus/features/workspace/domain/entities/workspace_entity.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'active_workspace_controller.g.dart';

@riverpod
class ActiveWorkspace extends _$ActiveWorkspace {
  @override
  WorkspaceEntity? build() => null;

  void select(WorkspaceEntity workspace) {
    state = workspace;
  }

  void clear() {
    state = null;
  }
}
