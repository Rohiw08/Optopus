import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'active_workspace_view_controller.g.dart';

// 0 select workspace
// 1 create workspace

@riverpod
class WorkspaceView extends _$WorkspaceView {
  @override
  int build() {
    return 0;
  }

  void set(int view) {
    state = view;
  }
}
