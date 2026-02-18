import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:optopus/core/responsive/layouts/desktop_layout.dart';
import 'package:optopus/core/responsive/layouts/mobile_layout.dart';
import 'package:optopus/core/responsive/layouts/tab_layout.dart';
import 'package:optopus/core/responsive/responsive.dart';
import 'package:optopus/core/widgets/animation_wrapper.dart';
import 'package:optopus/app/presentation/app_bar.dart';
import 'package:optopus/features/workspace/presentation/states/active_workspace_view_controller.dart';
import 'package:optopus/features/workspace/presentation/sections/all_workspaces_section.dart';
import 'package:optopus/features/workspace/presentation/sections/create_workspace_section.dart';
import 'package:optopus/features/workspace/presentation/sections/workspace_options_selections_section.dart';
import 'package:go_router/go_router.dart';
import 'package:optopus/features/home/presentation/controllers/home_view_controller.dart';
import 'package:optopus/features/workspace/domain/providers/workspace_templates_provider.dart';

class CreateWorkspaceScreen extends ConsumerWidget {
  const CreateWorkspaceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final view = ref.watch(workspaceViewProvider);
    final workspaceTemplates = ref.watch(workspaceTemplatesProvider);

    return Scaffold(
      appBar: const AppBarWidget(),
      body: Responsive(
        mobileLayout: MobileLayout(
          child: AnimationWrapper(
            index: view,
            direction: Direction.leftToRight,
            widgets: [
              WorkspaceOptionsSelectionsSection(
                workspaceTemplates: workspaceTemplates,
              ),
              CreateWorkspaceSection(
                onSuccess: (workspace) {
                  if (workspace != null) {
                    ref
                        .read(homeViewControllerProvider.notifier)
                        .openWorkspace(workspace);
                    context.go('/home');
                  }
                },
              ),
            ],
          ),
        ),
        tabLayout: TabLayout(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AnimationWrapper(
                index: view,
                direction: Direction.leftToRight,
                widgets: [
                  WorkspaceOptionsSelectionsSection(
                    workspaceTemplates: workspaceTemplates,
                  ),
                  CreateWorkspaceSection(
                    onSuccess: (workspace) {
                      if (workspace != null) {
                        ref
                            .read(homeViewControllerProvider.notifier)
                            .openWorkspace(workspace);
                        context.go('/home');
                      }
                    },
                  ),
                ],
              ),
              Expanded(child: AllWorkspacesSection()),
            ],
          ),
        ),
        desktopLayout: DesktopLayout(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AnimationWrapper(
                index: view,
                direction: Direction.leftToRight,
                widgets: [
                  WorkspaceOptionsSelectionsSection(
                    workspaceTemplates: workspaceTemplates,
                  ),
                  CreateWorkspaceSection(
                    onSuccess: (workspace) {
                      if (workspace != null) {
                        ref
                            .read(homeViewControllerProvider.notifier)
                            .openWorkspace(workspace);
                        context.go('/home');
                      }
                    },
                  ),
                ],
              ),
              Expanded(child: AllWorkspacesSection()),
            ],
          ),
        ),
      ),
    );
  }
}
