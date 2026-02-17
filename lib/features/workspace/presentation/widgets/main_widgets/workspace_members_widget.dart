import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:optopus/features/workspace/domain/entities/workspace_entity.dart';
import 'package:optopus/features/workspace/presentation/controllers/workspace_list_controller.dart';

class WorkspaceMembersWidget extends ConsumerStatefulWidget {
  final WorkspaceEntity workspace;
  const WorkspaceMembersWidget({super.key, required this.workspace});

  @override
  ConsumerState<WorkspaceMembersWidget> createState() =>
      _WorkspaceMembersWidgetState();
}

class _WorkspaceMembersWidgetState
    extends ConsumerState<WorkspaceMembersWidget> {
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _inviteMember() async {
    final email = _emailController.text.trim();
    if (email.isEmpty) return;

    try {
      await ref
          .read(workspaceListControllerProvider.notifier)
          .inviteMember(workspaceId: widget.workspace.id, email: email);
      if (mounted) {
        _emailController.clear();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invitation sent successfully')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error sending invitation: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: Fetch members list from repository (Mocking for now or needs a provider)
    // For now showing invitation UI
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Invite New Member",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: "Email Address",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: _inviteMember,
                child: const Text("Invite"),
              ),
            ],
          ),
          const Divider(height: 30),
          Text(
            "Current Members",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 10),
          // TODO: List members here
          const Expanded(
            child: Center(child: Text("Members list will appear here")),
          ),
        ],
      ),
    );
  }
}
