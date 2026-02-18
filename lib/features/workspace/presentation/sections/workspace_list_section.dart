import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:optopus/app/router/router.dart';
import 'package:optopus/core/widgets/error_screen.dart';
import 'package:optopus/core/widgets/loading_screen.dart';
import 'package:optopus/core/widgets/navigation_tile_widget.dart';
import 'package:optopus/features/home/presentation/controllers/home_view_controller.dart';
import 'package:optopus/features/workspace/domain/entities/workspace_entity.dart';
import 'package:optopus/features/workspace/presentation/controllers/workspace_list_controller.dart';

class WorkspaceListSection extends ConsumerWidget {
  const WorkspaceListSection({super.key});

  void _openWorkspace(WorkspaceEntity workspace, WidgetRef ref) {
    ref.read(homeViewControllerProvider.notifier).openWorkspace(workspace);
    ref.read(routerProvider).go('/home');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    return ref
        .watch(workspaceListControllerProvider)
        .when(
          data: (worskpaces) => Expanded(
            child: ListView.builder(
              itemCount: worskpaces.length,
              itemBuilder: (context, index) {
                final item = worskpaces[index];

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: NavigationTileWidget(
                    onPressed: () => _openWorkspace(item, ref),
                    text: item.name,
                    height: 40,
                    fontSize: 14,
                    width: double.infinity,
                    textColor: theme.colorScheme.onSurface,
                    borderColor: Colors.transparent,
                    hoverBackgroundColor: theme.colorScheme.surfaceBright,
                  ),
                );
              },
            ),
          ),
          error: (error, stackTrace) => ErrorScreen(message: error.toString()),
          loading: () => LoadingScreen(),
        );
  }
}
