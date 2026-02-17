import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:optopus/features/workspace/domain/entities/workspace_entity.dart';
import 'package:optopus/features/workspace/presentation/widgets/main_widgets/workspace_members_widget.dart';
import 'package:optopus/features/workspace/presentation/widgets/main_widgets/workspace_settings_widget.dart'; // Will create this too

class WorkspaceDashboardScreen extends ConsumerStatefulWidget {
  final WorkspaceEntity workspace;
  const WorkspaceDashboardScreen({super.key, required this.workspace});

  @override
  ConsumerState<WorkspaceDashboardScreen> createState() =>
      _WorkspaceDashboardScreenState();
}

class _WorkspaceDashboardScreenState
    extends ConsumerState<WorkspaceDashboardScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.workspace.name),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Overview'),
            Tab(text: 'Members'),
            Tab(text: 'Settings'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Center(
            child: Text("Overview Content (Comming Soon)"),
          ), // TODO: Add overview
          WorkspaceMembersWidget(workspace: widget.workspace),
          WorkspaceSettingsWidget(workspace: widget.workspace),
        ],
      ),
    );
  }
}
