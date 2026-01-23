import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flow_canvas/flow_canvas.dart';
import 'package:optopus/views/node_editor_view.dart';
import 'package:optopus/views/components/home_app_bar.dart';
import 'package:optopus/views/components/home_navigation_rail.dart';
import 'package:optopus/views/components/home_file_explorer.dart';
import 'package:optopus/views/components/home_right_actions.dart';
import 'package:optopus/views/components/node_library_drawer.dart';

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
      endDrawer: const NodeLibraryDrawer(),
      appBar: const HomeAppBar(),
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
          Expanded(child: NodeEditorView(controller: _controller)),
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
          HomeRightActions(width: _rightSidebarWidth, controller: _controller),
        ],
      ),
    );
  }
}
