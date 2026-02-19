import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:optopus/app/router/router.dart';
import 'package:optopus/core/widgets/navigation_tile_widget.dart';
import 'package:optopus/features/workspace/domain/entities/workspace_entity.dart';
import 'package:optopus/features/workspace/presentation/controllers/workspace_list_controller.dart';

class WorkspaceListSection extends ConsumerWidget {
  const WorkspaceListSection({super.key});

  void _openWorkspace(WorkspaceEntity workspace, WidgetRef ref) {
    // Navigate to studio with workspace ID.
    // The ProjectStudioScreen will handle loading the workspace into the controller.
    ref.read(routerProvider).go('/studio/${workspace.id}');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    return ref
        .watch(workspaceListControllerProvider)
        .when(
          data: (worskpaces) => ListView.builder(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
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
          error: (error, stackTrace) => Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Text(
                error.toString(),
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.error,
                ),
              ),
            ),
          ),
          loading: () => const Padding(
            padding: EdgeInsets.all(32.0),
            child: Center(
              child: SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            ),
          ),
        );
  }
}
