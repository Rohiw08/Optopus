import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:optopus/core/widgets/custom_textfield_widget.dart';
import 'package:optopus/features/workspace/domain/entities/workspace_entity.dart';
import 'package:optopus/features/workspace/presentation/controllers/workspace_actions_controller.dart';

class WorkspaceSettingsDialog extends ConsumerStatefulWidget {
  final WorkspaceEntity workspace;
  const WorkspaceSettingsDialog({super.key, required this.workspace});

  @override
  ConsumerState<WorkspaceSettingsDialog> createState() =>
      _WorkspaceSettingsDialogState();
}

class _WorkspaceSettingsDialogState
    extends ConsumerState<WorkspaceSettingsDialog> {
  late final TextEditingController _nameController;
  late final TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.workspace.name);
    _descriptionController = TextEditingController(
      text: widget.workspace.description,
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final actionState = ref.watch(workspaceActionsControllerProvider);

    return AlertDialog(
      title: const Text("Workspace Settings"),
      content: SizedBox(
        width: 400,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Name", style: theme.textTheme.labelLarge),
            const SizedBox(height: 8),
            CustomTextfield(
              controller: _nameController,
              hintText: "Enter workspace name",
            ),
            const SizedBox(height: 16),
            Text("Description", style: theme.textTheme.labelLarge),
            const SizedBox(height: 8),
            CustomTextfield(
              controller: _descriptionController,
              hintText: "Enter workspace description",
              maxLines: 3,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: actionState.isLoading
              ? null
              : () async {
                  try {
                    await ref
                        .read(workspaceActionsControllerProvider.notifier)
                        .updateWorkspace(
                          workspaceId: widget.workspace.id,
                          name: _nameController.text,
                          description: _descriptionController.text,
                        );
                    if (context.mounted) Navigator.of(context).pop();
                  } catch (e) {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Failed to update: $e")),
                      );
                    }
                  }
                },
          child: actionState.isLoading
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text("Save Changes"),
        ),
      ],
    );
  }
}
