import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:optopus/app/router/router.dart';
import 'package:optopus/features/workspace/presentation/controllers/workspace_list_controller.dart';
import 'package:optopus/features/workspace/presentation/sections/workspace_table_section.dart';
import 'package:optopus/features/workspace/presentation/controllers/workspace_ui_controller.dart';

class AllWorkspacesSection extends ConsumerWidget {
  const AllWorkspacesSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),
          _buildHeader(context, ref),
          const SizedBox(height: 32),
          _buildFilters(context, ref),
          const SizedBox(height: 24),
          _buildWorkspaceList(context, ref),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "All workspaces",
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "A directory of all workspaces you can access.",
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFilters(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final currentSort = ref.watch(workspaceSortProvider);

    return Row(
      children: [
        Expanded(
          flex: 2,
          child: TextField(
            onChanged: (value) {
              ref.read(workspaceSearchQueryProvider.notifier).set(value);
            },
            decoration: InputDecoration(
              hintText: "Search workspaces...",
              prefixIcon: const Icon(Icons.search, size: 18),
              contentPadding: const EdgeInsets.symmetric(vertical: 0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: theme.dividerColor),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: theme.dividerColor.withValues(alpha: 0.2),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: theme.dividerColor.withValues(alpha: 0.2),
            ),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<WorkspaceSortStrategy>(
              value: currentSort,
              icon: const Icon(Icons.sort, size: 18),
              style: theme.textTheme.bodyMedium,
              onChanged: (value) {
                if (value != null) {
                  ref.read(workspaceSortProvider.notifier).set(value);
                }
              },
              items: [
                const DropdownMenuItem(
                  value: WorkspaceSortStrategy.lastUpdated,
                  child: Text("Last Updated"),
                ),
                const DropdownMenuItem(
                  value: WorkspaceSortStrategy.nameAz,
                  child: Text("Name (A-Z)"),
                ),
                const DropdownMenuItem(
                  value: WorkspaceSortStrategy.nameZa,
                  child: Text("Name (Z-A)"),
                ),
                const DropdownMenuItem(
                  value: WorkspaceSortStrategy.createdNewest,
                  child: Text("Recently Created"),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildWorkspaceList(BuildContext context, WidgetRef ref) {
    final workspaceListAsync = ref.watch(workspaceListControllerProvider);

    return workspaceListAsync.when(
      data: (workspaces) => WorkspaceTableSection(
        workspaces: workspaces,
        onWorkspaceTap: (workspace) {
          ref.read(routerProvider).push('/studio/${workspace.id}');
        },
      ),
      loading: () => const Center(
        child: Padding(
          padding: EdgeInsets.all(32.0),
          child: CircularProgressIndicator(),
        ),
      ),
      error: (err, stack) => Center(child: Text('Error: $err')),
      skipLoadingOnReload: true,
    );
  }
}
