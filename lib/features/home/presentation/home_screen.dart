import 'package:flutter/material.dart';
import 'package:optopus/features/home/presentation/controllers/home_view_controller.dart';
import 'package:optopus/features/home/presentation/widgets/app_bar.dart';
import 'package:optopus/features/workspace/presentation/screens/workspace_dashboard_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flow_canvas/flow_canvas.dart';
import 'package:optopus/features/editor/presentation/screens/editor_screen.dart';
import 'package:optopus/features/home/presentation/widgets/home_navigation_rail.dart';
import 'package:optopus/features/home/presentation/widgets/home_file_explorer.dart';
import 'package:optopus/features/editor/presentation/widgets/editor_right_actions.dart';
import 'package:optopus/features/editor/presentation/widgets/editor_node_library.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final FlowCanvasController _controller = FlowCanvasController();
  double _leftSidebarWidth = 220.0;
  double _rightSidebarWidth = 45.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      endDrawer: ref
          .watch(homeViewControllerProvider)
          .maybeWhen(
            editor: (_) => const EditorNodeLibraryDrawer(),
            orElse: () => null,
          ),
      appBar: const AppBarWidget(),
      body: Row(
        children: [
          const HomeNavigationRail(),
          HomeFileExplorer(width: _leftSidebarWidth),
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
              child: Container(width: 4, color: Colors.transparent),
            ),
          ),
          Expanded(
            child: Consumer(
              builder: (context, ref, child) {
                final viewState = ref.watch(homeViewControllerProvider);
                return viewState.when(
                  empty: () =>
                      const Center(child: Text("Select a workspace or flow")),
                  dashboard: (workspace) =>
                      WorkspaceDashboardScreen(workspace: workspace),
                  editor: (flow) => EditorScreen(
                    controller: _controller,
                  ), // TODO: Pass flow data to controller
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
                  // Clamp width
                  if (_rightSidebarWidth < 45) _rightSidebarWidth = 45;
                  if (_rightSidebarWidth > 500) _rightSidebarWidth = 500;
                });
              },
              child: Container(width: 4, color: Colors.transparent),
            ),
          ),
          Consumer(
            builder: (context, ref, child) {
              final viewState = ref.watch(homeViewControllerProvider);
              return viewState.maybeWhen(
                editor: (flow) => EditorRightActions(
                  width: _rightSidebarWidth,
                  controller: _controller,
                  flow: flow,
                ),
                orElse: () => SizedBox(
                  width: _rightSidebarWidth,
                ), // Or specific HomeRightActions
              );
            },
          ),
        ],
      ),
    );
  }
}
