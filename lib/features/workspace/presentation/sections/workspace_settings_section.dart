import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:optopus/features/workspace/domain/entities/workspace_entity.dart';
import 'package:optopus/features/workspace/presentation/controllers/workspace_actions_controller.dart';

class WorkspaceSettingsSection extends ConsumerWidget {
  final WorkspaceEntity workspace;
  const WorkspaceSettingsSection({super.key, required this.workspace});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Workspace Settings",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 20),
          ListTile(
            leading: const Icon(Icons.delete, color: Colors.red),
            title: const Text(
              "Delete Workspace",
              style: TextStyle(color: Colors.red),
            ),
            subtitle: const Text(
              "Permanently delete this workspace and all its data.",
            ),
            onTap: () async {
              final confirm = await showDialog<bool>(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text("Delete Workspace?"),
                  content: Text(
                    "Are you sure you want to delete '${workspace.name}'? This action cannot be undone.",
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: const Text("Cancel"),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, true),
                      child: const Text(
                        "Delete",
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                ),
              );

              if (confirm == true) {
                await ref
                    .read(workspaceActionsControllerProvider.notifier)
                    .deleteWorkspace(workspace.id);
                if (context.mounted) {
                  // Usually we'd navigate back or clear active workspace
                  Navigator.pop(context);
                }
              }
            },
          ),
        ],
      ),
    );
  }
}
