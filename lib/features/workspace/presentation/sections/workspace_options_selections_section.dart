import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:optopus/features/workspace/domain/entities/workspace_template_entity.dart';
import 'package:optopus/features/workspace/presentation/states/active_workspace_view_controller.dart';
import 'package:optopus/core/widgets/bottom_navigation_widget.dart';
import 'package:optopus/features/workspace/presentation/sections/header_section.dart';
import 'package:optopus/app/router/router.dart';
import 'package:optopus/features/workspace/presentation/sections/template_selection_section.dart';

class WorkspaceOptionsSelectionsSection extends ConsumerWidget {
  final List<WorkspaceTemplateEntity> workspaceTemplates;
  const WorkspaceOptionsSelectionsSection({
    super.key,
    required this.workspaceTemplates,
  });

  void next(WidgetRef ref) {
    ref.read(workspaceViewProvider.notifier).set(1);
  }

  void cancel(WidgetRef ref) {
    ref.read(routerProvider).go("/home");
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return Container(
      width: 400,
      color: theme.colorScheme.surface,
      padding: EdgeInsets.all(40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CreateWorkspaceHeaderWidget(),
          const SizedBox(height: 40),
          Expanded(
            child: TemplateSelectionSection(
              workspaceTemplates: workspaceTemplates,
            ),
          ),
          const SizedBox(height: 30),
          BottomNavigationWidget(
            cancelText: "Cancel",
            proceedText: "Next",
            onCancel: () => cancel(ref),
            onProceed: () => next(ref),
          ),
        ],
      ),
    );
  }
}
