import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:optopus/features/workspace/domain/entities/workspace_entity.dart';
import 'package:optopus/features/workspace/subfeatures/flows/domain/entities/flow_entity.dart';
import 'package:optopus/features/home/presentation/providers/home_providers.dart';
import 'package:optopus/core/domain/failures/failure.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_view_controller.freezed.dart';
part 'home_view_controller.g.dart';

@freezed
sealed class HomeViewState with _$HomeViewState {
  const factory HomeViewState.empty() = HomeViewEmpty;
  const factory HomeViewState.dashboard(WorkspaceEntity workspace) =
      HomeViewDashboard;
  const factory HomeViewState.editor(FlowEntity flow) = HomeViewEditor;
}

@riverpod
class HomeViewController extends _$HomeViewController {
  @override
  HomeViewState build() {
    return const HomeViewState.empty();
  }

  void showDashboard(WorkspaceEntity workspace) {
    state = HomeViewState.dashboard(workspace);
  }

  void showEditor(FlowEntity flow) {
    state = HomeViewState.editor(flow);
  }

  Future<void> openWorkspace(WorkspaceEntity workspace) async {
    try {
      final flow = await ref.read(homeServiceProvider).openWorkspace(workspace);
      state = HomeViewState.editor(flow);
    } on WorkspaceFailure catch (e) {
      // Log error - in production, you might want to update state with error
      print('Failed to open workspace: ${e.message}');
      // Optionally: state = HomeViewState.error(e);
    } catch (e) {
      print('Unexpected error opening workspace: $e');
    }
  }

  void clear() {
    state = const HomeViewState.empty();
  }
}
