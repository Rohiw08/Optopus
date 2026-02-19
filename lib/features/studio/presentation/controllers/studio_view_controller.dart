import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'studio_view_controller.freezed.dart';
part 'studio_view_controller.g.dart';

@freezed
sealed class StudioViewState with _$StudioViewState {
  const factory StudioViewState.empty() = StudioViewEmpty;
  const factory StudioViewState.dashboard(String workspaceId) =
      StudioViewDashboard;
  const factory StudioViewState.editor(String flowId) = StudioViewEditor;
}

@riverpod
class StudioViewController extends _$StudioViewController {
  @override
  StudioViewState build() {
    return const StudioViewState.empty();
  }

  void showDashboard(String workspaceId) {
    state = StudioViewState.dashboard(workspaceId);
  }

  void showEditor(String flowId) {
    state = StudioViewState.editor(flowId);
  }

  void clear() {
    state = const StudioViewState.empty();
  }
}
