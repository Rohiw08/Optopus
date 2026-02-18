import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:optopus/core/session/session_provider.dart';
import 'package:optopus/features/workspace/domain/entities/workspace_entity.dart';
import 'package:optopus/core/utils/time_utils.dart';
import 'package:optopus/features/workspace/presentation/controllers/workspace_actions_controller.dart';
import 'package:optopus/features/workspace/presentation/widgets/member_management_dialog.dart';
import 'package:optopus/features/workspace/presentation/widgets/workspace_settings_dialog.dart';

class WorkspaceTableSection extends StatelessWidget {
  final List<WorkspaceEntity> workspaces;
  final Function(WorkspaceEntity) onWorkspaceTap;

  const WorkspaceTableSection({
    super.key,
    required this.workspaces,
    required this.onWorkspaceTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (workspaces.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(64.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.workspaces_outline,
                size: 64,
                color: theme.colorScheme.onSurface.withValues(alpha: 0.2),
              ),
              const SizedBox(height: 16),
              Text(
                "No workspaces found",
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final isCompact = constraints.maxWidth < 800;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!isCompact) _buildHeader(context),
            const SizedBox(height: 8),
            ...workspaces.map(
              (workspace) => _buildRow(context, workspace, isCompact),
            ),
          ],
        );
      },
    );
  }

  Widget _buildHeader(BuildContext context) {
    final theme = Theme.of(context);
    final headerStyle = theme.textTheme.labelMedium?.copyWith(
      color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
      fontWeight: FontWeight.w500,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Expanded(flex: 5, child: Text("Name", style: headerStyle)),
          Expanded(flex: 3, child: Text("Created by", style: headerStyle)),
          Expanded(flex: 4, child: Text("Access", style: headerStyle)),
          Expanded(flex: 2, child: Text("Last updated", style: headerStyle)),
          const SizedBox(width: 40), // Space for actions
        ],
      ),
    );
  }

  Widget _buildRow(
    BuildContext context,
    WorkspaceEntity workspace,
    bool isCompact,
  ) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: () => onWorkspaceTap(workspace),
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: theme.dividerColor.withValues(alpha: 0.05),
              width: 1,
            ),
          ),
        ),
        child: isCompact
            ? _buildCompactRow(context, workspace, theme)
            : _buildDesktopRow(context, workspace, theme),
      ),
    );
  }

  Widget _buildDesktopRow(
    BuildContext context,
    WorkspaceEntity workspace,
    ThemeData theme,
  ) {
    return Row(
      children: [
        // Name Column
        Expanded(
          flex: 5,
          child: Row(
            children: [
              Icon(
                workspace.memberCount > 1
                    ? Icons.people_outline
                    : Icons.lock_outline,
                size: 20,
                color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      workspace.name,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "${workspace.memberCount} contributor${workspace.memberCount == 1 ? '' : 's'}",
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurface.withValues(
                          alpha: 0.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Created by Column
        Expanded(
          flex: 3,
          child: Row(
            children: [
              Consumer(
                builder: (context, ref, _) {
                  final profileAsync = ref.watch(
                    profileProvider(workspace.ownerId),
                  );
                  final sessionAsync = ref.watch(sessionProvider);

                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      profileAsync.when(
                        data: (profile) => Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: theme.colorScheme.primaryContainer,
                            image: profile?.avatarUrl != null
                                ? DecorationImage(
                                    image: NetworkImage(profile!.avatarUrl!),
                                    fit: BoxFit.cover,
                                  )
                                : null,
                          ),
                          child: profile?.avatarUrl == null
                              ? Center(
                                  child: Text(
                                    (profile?.displayName ?? "U")[0]
                                        .toUpperCase(),
                                    style: theme.textTheme.labelSmall?.copyWith(
                                      color:
                                          theme.colorScheme.onPrimaryContainer,
                                      fontSize: 10,
                                    ),
                                  ),
                                )
                              : null,
                        ),
                        loading: () => Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: theme.colorScheme.surfaceContainerHighest,
                          ),
                        ),
                        error: (_, __) => Icon(
                          Icons.person_outline,
                          size: 16,
                          color: theme.colorScheme.onSurface.withValues(
                            alpha: 0.5,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      sessionAsync.maybeWhen(
                        data: (currentAccount) {
                          if (currentAccount?.id == workspace.ownerId) {
                            return Text(
                              "You",
                              style: theme.textTheme.bodyMedium,
                            );
                          }
                          return profileAsync.maybeWhen(
                            data: (profile) => Text(
                              profile?.displayName ?? "Owner",
                              style: theme.textTheme.bodyMedium,
                            ),
                            orElse: () => const SizedBox.shrink(),
                          );
                        },
                        orElse: () => const SizedBox.shrink(),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),

        // Access Column
        Expanded(
          flex: 4,
          child: Text(
            workspace.memberRole == 'owner'
                ? "Only you and invited people"
                : "Managed by team admin",
            style: theme.textTheme.bodyMedium,
          ),
        ),

        // Last updated Column
        Expanded(
          flex: 2,
          child: Text(
            formatRelativeTime(workspace.updatedAt),
            style: theme.textTheme.bodyMedium,
          ),
        ),

        // Actions Menu
        Consumer(
          builder: (context, ref, _) {
            return PopupMenuButton<String>(
              icon: const Icon(Icons.more_vert, size: 20),
              tooltip: "Actions",
              onSelected: (value) {
                if (value == 'settings') {
                  showDialog(
                    context: context,
                    builder: (_) =>
                        WorkspaceSettingsDialog(workspace: workspace),
                  );
                } else if (value == 'members') {
                  showDialog(
                    context: context,
                    builder: (_) =>
                        MemberManagementDialog(workspace: workspace),
                  );
                } else if (value == 'delete') {
                  _showDeleteConfirmation(context, ref, workspace);
                } else if (value == 'leave') {
                  _showLeaveConfirmation(context, ref, workspace);
                }
              },
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 'members',
                  child: Row(
                    children: [
                      Icon(Icons.people_outline, size: 18),
                      SizedBox(width: 12),
                      Text("Manage Members"),
                    ],
                  ),
                ),
                if (workspace.canEdit)
                  const PopupMenuItem(
                    value: 'settings',
                    child: Row(
                      children: [
                        Icon(Icons.settings_outlined, size: 18),
                        SizedBox(width: 12),
                        Text("Workspace Settings"),
                      ],
                    ),
                  ),
                if (workspace.isOwner)
                  const PopupMenuItem(
                    value: 'delete',
                    child: Row(
                      children: [
                        Icon(Icons.delete_outline, size: 18, color: Colors.red),
                        SizedBox(width: 12),
                        Text(
                          "Delete Workspace",
                          style: TextStyle(color: Colors.red),
                        ),
                      ],
                    ),
                  ),
                if (!workspace.isOwner)
                  const PopupMenuItem(
                    value: 'leave',
                    child: Row(
                      children: [
                        Icon(
                          Icons.exit_to_app_outlined,
                          size: 18,
                          color: Colors.orange,
                        ),
                        SizedBox(width: 12),
                        Text(
                          "Leave Workspace",
                          style: TextStyle(color: Colors.orange),
                        ),
                      ],
                    ),
                  ),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _buildCompactRow(
    BuildContext context,
    WorkspaceEntity workspace,
    ThemeData theme,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              workspace.memberCount > 1
                  ? Icons.people_outline
                  : Icons.lock_outline,
              size: 18,
              color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                workspace.name,
                style: theme.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Consumer(
              builder: (context, ref, _) {
                final profileAsync = ref.watch(
                  profileProvider(workspace.ownerId),
                );
                return profileAsync.maybeWhen(
                  data: (profile) => profile?.avatarUrl != null
                      ? Container(
                          width: 18,
                          height: 18,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: NetworkImage(profile!.avatarUrl!),
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                      : const SizedBox.shrink(),
                  orElse: () => const SizedBox.shrink(),
                );
              },
            ),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Text(
              "${workspace.memberCount} contributor${workspace.memberCount == 1 ? '' : 's'}",
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              "•",
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.3),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              formatRelativeTime(workspace.updatedAt),
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _showDeleteConfirmation(
    BuildContext context,
    WidgetRef ref,
    WorkspaceEntity workspace,
  ) {
    showDialog(
      context: context,
      builder: (context) {
        bool isDeleting = false;

        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text("Delete Workspace"),
              content: Text(
                "Are you sure you want to delete '${workspace.name}'? This action cannot be undone.",
              ),
              actions: [
                TextButton(
                  onPressed: isDeleting
                      ? null
                      : () => Navigator.of(context).pop(),
                  child: const Text("Cancel"),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: isDeleting
                      ? null
                      : () async {
                          setState(() => isDeleting = true);
                          try {
                            // Clear any previous error
                            ref.invalidate(workspaceActionsControllerProvider);

                            await ref
                                .read(
                                  workspaceActionsControllerProvider.notifier,
                                )
                                .deleteWorkspace(workspace.id);

                            // Check result state
                            final actionState = ref.read(
                              workspaceActionsControllerProvider,
                            );

                            if (actionState.hasError) {
                              throw actionState.error!;
                            }

                            if (context.mounted) {
                              Navigator.of(context).pop();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    "Workspace '${workspace.name}' deleted successfully.",
                                  ),
                                ),
                              );
                            }
                          } catch (e) {
                            if (context.mounted) {
                              setState(() => isDeleting = false);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    "Failed to delete workspace: $e",
                                  ),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          }
                        },
                  child: isDeleting
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Text("Delete"),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showLeaveConfirmation(
    BuildContext context,
    WidgetRef ref,
    WorkspaceEntity workspace,
  ) {
    showDialog(
      context: context,
      builder: (context) {
        bool isLeaving = false;

        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text("Leave Workspace"),
              content: Text(
                "Are you sure you want to leave '${workspace.name}'? You will lose access to all its content.",
              ),
              actions: [
                TextButton(
                  onPressed: isLeaving
                      ? null
                      : () => Navigator.of(context).pop(),
                  child: const Text("Cancel"),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: isLeaving
                      ? null
                      : () async {
                          setState(() => isLeaving = true);
                          try {
                            // Clear any previous error
                            ref.invalidate(workspaceActionsControllerProvider);

                            await ref
                                .read(
                                  workspaceActionsControllerProvider.notifier,
                                )
                                .leaveWorkspace(workspace.id);

                            // Check result state
                            final actionState = ref.read(
                              workspaceActionsControllerProvider,
                            );

                            if (actionState.hasError) {
                              throw actionState.error!;
                            }

                            if (context.mounted) {
                              Navigator.of(context).pop();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    "You have left '${workspace.name}'.",
                                  ),
                                ),
                              );
                            }
                          } catch (e) {
                            if (context.mounted) {
                              setState(() => isLeaving = false);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    "Failed to leave workspace: $e",
                                  ),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          }
                        },
                  child: isLeaving
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Text("Leave"),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
