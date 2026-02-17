import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:optopus/features/workspace/presentation/controllers/active_workspace_view_controller.dart';
import 'package:optopus/features/workspace/presentation/widgets/components/bottom_navigation_widget.dart';
import 'package:optopus/features/workspace/presentation/widgets/components/create_workspace_options_widget.dart';
import 'package:optopus/features/workspace/presentation/widgets/components/create_workspace_sidebar_header_widget.dart';
import 'package:optopus/router/router.dart';

class WorkspaceOptionsSelectionsWidget extends ConsumerStatefulWidget {
  const WorkspaceOptionsSelectionsWidget({super.key});

  @override
  ConsumerState<WorkspaceOptionsSelectionsWidget> createState() =>
      _WorkspaceOptionsSelectionsWidgetState();
}

class _WorkspaceOptionsSelectionsWidgetState
    extends ConsumerState<WorkspaceOptionsSelectionsWidget> {
  void next() {
    ref.read(workspaceViewProvider.notifier).set(1);
  }

  void cancel() {
    ref.read(routerProvider).go("/home");
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: 400,
      color: theme.colorScheme.surface,
      padding: EdgeInsets.all(40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CreateWorkspaceSidebarHeaderWidget(),
          const SizedBox(height: 40),
          Expanded(child: CreateWorkspaceOptionsWidget()),
          const SizedBox(height: 30),
          BottomNavigationWidget(
            cancelText: "Cancel",
            proceedText: "Next",
            onCancel: cancel,
            onProceed: next,
          ),
        ],
      ),
    );
  }
}
