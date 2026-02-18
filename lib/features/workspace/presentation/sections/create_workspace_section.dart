import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:optopus/features/workspace/domain/entities/workspace_entity.dart';
import 'package:optopus/core/widgets/custom_textfield_widget.dart';
import 'package:optopus/features/workspace/presentation/states/active_workspace_view_controller.dart';
import 'package:optopus/features/workspace/presentation/controllers/workspace_actions_controller.dart';
import 'package:optopus/core/widgets/bottom_navigation_widget.dart';

class CreateWorkspaceSection extends ConsumerStatefulWidget {
  final VoidCallback? onCancel;
  final void Function(WorkspaceEntity?)? onSuccess;

  const CreateWorkspaceSection({super.key, this.onCancel, this.onSuccess});

  @override
  ConsumerState<CreateWorkspaceSection> createState() =>
      _CreateWorkspaceSectionState();
}

class _CreateWorkspaceSectionState
    extends ConsumerState<CreateWorkspaceSection> {
  late final TextEditingController _nameController;
  late final TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _descriptionController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _create() async {
    final newWorkspace = await ref
        .read(workspaceActionsControllerProvider.notifier)
        .createWorkspace(
          name: _nameController.text,
          description: _descriptionController.text,
        );

    if (mounted && newWorkspace != null) {
      if (widget.onSuccess != null) {
        widget.onSuccess!(newWorkspace);
      }
    }
  }

  void _back() {
    if (widget.onCancel != null) {
      widget.onCancel!();
    } else {
      ref.read(workspaceViewProvider.notifier).set(0);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final actionState = ref.watch(workspaceActionsControllerProvider);

    return Container(
      width: 400,
      color: theme.colorScheme.surface,
      padding: EdgeInsets.all(40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextfield(
            controller: _nameController,
            hintText: "Workspace name",
          ),
          const SizedBox(height: 24),
          CustomTextfield(
            controller: _descriptionController,
            hintText: "Workspace description (optional)",
            maxLines: 5,
            minLines: 3,
          ),
          const Spacer(),
          BottomNavigationWidget(
            cancelText: "Cancel",
            proceedText: "Create",
            isProceedLoading: actionState.isLoading,
            onCancel: _back,
            onProceed: _create,
          ),
        ],
      ),
    );
  }
}
