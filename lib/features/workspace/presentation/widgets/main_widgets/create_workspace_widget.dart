import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:optopus/features/workspace/domain/entities/workspace_entity.dart';
import 'package:optopus/core/widgets/custom_textfield_widget.dart';
import 'package:optopus/features/workspace/presentation/controllers/active_workspace_view_controller.dart';
import 'package:optopus/features/workspace/presentation/controllers/workspace_list_controller.dart';
import 'package:optopus/features/workspace/presentation/widgets/components/bottom_navigation_widget.dart';

class CreateWorkspaceWidget extends ConsumerStatefulWidget {
  final VoidCallback? onCancel;
  final void Function(WorkspaceEntity?)? onSuccess;

  const CreateWorkspaceWidget({super.key, this.onCancel, this.onSuccess});

  @override
  ConsumerState<CreateWorkspaceWidget> createState() =>
      _CreateWorkspaceWidgetState();
}

class _CreateWorkspaceWidgetState extends ConsumerState<CreateWorkspaceWidget> {
  late final TextEditingController _textEditingController;
  bool _isCreating = false;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  Future<void> _create() async {
    setState(() => _isCreating = true);
    final newWorkspace = await ref
        .read(workspaceListControllerProvider.notifier)
        .createWorkspace(name: _textEditingController.text);
    if (mounted) {
      setState(() => _isCreating = false);
      if (widget.onSuccess != null) {
        widget.onSuccess!(newWorkspace);
      } else {
        // Default behavior if no callback
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

    return Container(
      width: 400,
      color: theme.colorScheme.surface,
      padding: EdgeInsets.all(40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextfield(
            controller: _textEditingController,
            hintText: "Workspace name",
          ),
          Spacer(),
          BottomNavigationWidget(
            cancelText: "Cancel",
            proceedText: "Create",
            isProceedLoading: _isCreating,
            onCancel: _back,
            onProceed: _create,
          ),
        ],
      ),
    );
  }
}
