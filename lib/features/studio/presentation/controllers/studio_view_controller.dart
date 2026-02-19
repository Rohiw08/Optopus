import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:optopus/features/workspace/domain/entities/workspace_entity.dart';
import 'package:optopus/features/flows/domain/entities/flow_entity.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'studio_view_controller.freezed.dart';
part 'studio_view_controller.g.dart';

@freezed
sealed class StudioViewState with _$StudioViewState {
  const factory StudioViewState.empty() = StudioViewEmpty;
  const factory StudioViewState.dashboard(WorkspaceEntity workspace) =
      StudioViewDashboard;
  const factory StudioViewState.editor(FlowEntity flow) = StudioViewEditor;
}

@riverpod
class StudioViewController extends _$StudioViewController {
  @override
  StudioViewState build() {
    return const StudioViewState.empty();
  }

  void showDashboard(WorkspaceEntity workspace) {
    state = StudioViewState.dashboard(workspace);
  }

  void showEditor(FlowEntity flow) {
    state = StudioViewState.editor(flow);
  }

  void clear() {
    state = const StudioViewState.empty();
  }
}
