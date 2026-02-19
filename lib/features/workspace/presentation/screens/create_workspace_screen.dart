import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:optopus/app/router/router.dart';
import 'package:optopus/core/responsive/layouts/desktop_layout.dart';
import 'package:optopus/core/responsive/layouts/mobile_layout.dart';
import 'package:optopus/core/responsive/layouts/tab_layout.dart';
import 'package:optopus/core/responsive/responsive.dart';
import 'package:optopus/app/presentation/app_bar.dart';
import 'package:optopus/features/workspace/presentation/sections/all_workspaces_section.dart';
import 'package:optopus/features/workspace/presentation/sections/create_workspace_section.dart';
import 'package:go_router/go_router.dart';

class CreateWorkspaceScreen extends ConsumerWidget {
  const CreateWorkspaceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: const AppBarWidget(),
      body: Responsive(
        mobileLayout: MobileLayout(
          child: CreateWorkspaceSection(
            onSuccess: (workspace) {
              if (workspace != null) {
                ref.read(routerProvider).push('/studio/${workspace.id}');
              }
            },
            onCancel: () => context.go('/home'),
          ),
        ),
        tabLayout: TabLayout(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CreateWorkspaceSection(
                onSuccess: (workspace) {
                  if (workspace != null) {
                    ref.read(routerProvider).push('/studio/${workspace.id}');
                  }
                },
                onCancel: () => context.go('/home'),
              ),
              Expanded(child: AllWorkspacesSection()),
            ],
          ),
        ),
        desktopLayout: DesktopLayout(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CreateWorkspaceSection(
                onSuccess: (workspace) {
                  if (workspace != null) {
                    ref.read(routerProvider).push('/studio/${workspace.id}');
                  }
                },
                onCancel: () => context.go('/home'),
              ),
              Expanded(child: AllWorkspacesSection()),
            ],
          ),
        ),
      ),
    );
  }
}
