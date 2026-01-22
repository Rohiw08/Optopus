import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:optopus/views/node_editor_view.dart';
import 'package:optopus/views/components/home_app_bar.dart';
import 'package:optopus/views/components/home_navigation_rail.dart';
import 'package:optopus/views/components/home_file_explorer.dart';
import 'package:optopus/views/components/home_right_actions.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: const HomeAppBar(),
      body: const Row(
        children: [
          HomeNavigationRail(),
          HomeFileExplorer(),
          Expanded(flex: 4, child: NodeEditorView()),
          HomeRightActions(),
        ],
      ),
    );
  }
}
