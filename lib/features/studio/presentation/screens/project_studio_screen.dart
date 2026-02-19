import 'package:flutter/material.dart';
import 'package:optopus/core/widgets/error_screen.dart';
import 'package:optopus/core/widgets/loading_screen.dart';
import 'package:optopus/features/studio/presentation/controllers/studio_view_controller.dart';
import 'package:optopus/app/presentation/app_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flow_canvas/flow_canvas.dart';
import 'package:optopus/features/editor/presentation/screens/editor_screen.dart';
import 'package:optopus/features/studio/presentation/widgets/navigation_rail.dart';
import 'package:optopus/features/studio/presentation/widgets/file_explorer.dart';
import 'package:optopus/features/editor/presentation/widgets/editor_right_actions.dart';
import 'package:optopus/features/editor/presentation/widgets/editor_node_library.dart';
import 'package:optopus/features/workspace/presentation/controllers/workspace_list_controller.dart';
import 'package:optopus/features/workspace/domain/entities/workspace_entity.dart';
import 'package:optopus/features/flows/presentation/controllers/flow_providers.dart';
import 'package:optopus/features/flows/presentation/controllers/flow_list_controller.dart';

class ProjectStudioScreen extends ConsumerStatefulWidget {
  final String? workspaceId;
  const ProjectStudioScreen({super.key, this.workspaceId});

  @override
  ConsumerState<ProjectStudioScreen> createState() =>
      _ProjectStudioScreenState();
}

class _ProjectStudioScreenState extends ConsumerState<ProjectStudioScreen> {
  final FlowCanvasController _controller = FlowCanvasController();
  double _leftSidebarWidth = 220.0;
  double _rightSidebarWidth = 45.0;

  @override
  void initState() {
    super.initState();
    if (widget.workspaceId != null) {
      Future.microtask(() {
        // TODO: Handle workspace loading logic here or in a different controller
        // ref
        //     .read(studioViewControllerProvider.notifier)
        //     .loadWorkspaceById(widget.workspaceId!);
      });
    }
  }

  @override
  void didUpdateWidget(covariant ProjectStudioScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.workspaceId != oldWidget.workspaceId) {
      // Clear state when switching workspace
      Future.microtask(() {
        ref.read(studioViewControllerProvider.notifier).clear();
        ref.read(selectedFlowIdProvider.notifier).set(null);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      endDrawer: ref
          .watch(studioViewControllerProvider)
          .maybeWhen(
            editor: (flowId) => const EditorNodeLibraryDrawer(),
            orElse: () => null,
          ),
      appBar: const AppBarWidget(),
      body: ref
          .watch(workspaceListControllerProvider)
          .when(
            data: (workspaces) {
              final workspace = workspaces.cast<WorkspaceEntity>().firstWhere(
                (w) => w.id == widget.workspaceId,
                orElse: () => workspaces.isNotEmpty
                    ? workspaces.first
                    : throw Exception('No workspace found'),
              );
              return Row(
                children: [
                  const StudioNavigationRail(),
                  StudioFileExplorer(
                    width: _leftSidebarWidth,
                    workspaceId: workspace.id,
                  ),
                  MouseRegion(
                    cursor: SystemMouseCursors.resizeColumn,
                    child: GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onHorizontalDragUpdate: (details) {
                        setState(() {
                          _leftSidebarWidth += details.delta.dx;
                          // Clamp width
                          if (_leftSidebarWidth < 200) _leftSidebarWidth = 200;
                          if (_leftSidebarWidth > 500) _leftSidebarWidth = 500;
                        });
                      },
                      child: Container(
                        width: 1,
                        color: Theme.of(context).dividerColor,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Consumer(
                      builder: (context, ref, child) {
                        final viewState = ref.watch(
                          studioViewControllerProvider,
                        );
                        return viewState.when(
                          empty: () => const SizedBox.shrink(),
                          dashboard: (workspaceId) =>
                              Center(child: Text('Dashboard: $workspaceId')),
                          editor: (flowId) => EditorScreen(
                            controller: _controller,
                            flowId: flowId,
                          ),
                        );
                      },
                    ),
                  ),
                  MouseRegion(
                    cursor: SystemMouseCursors.resizeColumn,
                    child: GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onHorizontalDragUpdate: (details) {
                        setState(() {
                          _rightSidebarWidth -= details.delta.dx;
                          if (_rightSidebarWidth < 45) _rightSidebarWidth = 45;
                          if (_rightSidebarWidth > 500) {
                            _rightSidebarWidth = 500;
                          }
                        });
                      },
                      child: Container(
                        width: 1,
                        color: Theme.of(context).dividerColor,
                      ),
                    ),
                  ),
                  Consumer(
                    builder: (context, ref, child) {
                      final viewState = ref.watch(studioViewControllerProvider);
                      return viewState.maybeWhen(
                        editor: (flowId) => Consumer(
                          builder: (context, ref, child) {
                            final flowAsync = ref.watch(flowProvider(flowId));
                            return flowAsync.when(
                              data: (flow) => EditorRightActions(
                                width: _rightSidebarWidth,
                                controller: _controller,
                                flow: flow,
                              ),
                              loading: () =>
                                  SizedBox(width: _rightSidebarWidth),
                              error: (err, _) =>
                                  SizedBox(width: _rightSidebarWidth),
                            );
                          },
                        ),
                        orElse: () => SizedBox(width: _rightSidebarWidth),
                      );
                    },
                  ),
                ],
              );
            },
            error: (error, stackTrace) =>
                ErrorScreen(message: error.toString()),
            loading: () => const Center(child: LoadingScreen()),
          ),
    );
  }
}
