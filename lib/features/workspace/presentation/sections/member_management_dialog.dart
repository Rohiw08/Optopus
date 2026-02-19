import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:optopus/core/providers/auth_state_provider.dart';
import 'package:optopus/core/session/session_provider.dart';
import 'package:optopus/core/widgets/custom_textfield_widget.dart';
import 'package:optopus/features/workspace/domain/entities/workspace_entity.dart';
import 'package:optopus/features/workspace/domain/entities/workspace_member_entity.dart';
import 'package:optopus/features/workspace/domain/enums/workspace_role.dart';
import 'package:optopus/features/workspace/presentation/controllers/member_list_controller.dart';

class MemberManagementDialog extends ConsumerStatefulWidget {
  final WorkspaceEntity workspace;
  const MemberManagementDialog({super.key, required this.workspace});

  @override
  ConsumerState<MemberManagementDialog> createState() =>
      _MemberManagementDialogState();
}

class _MemberManagementDialogState
    extends ConsumerState<MemberManagementDialog> {
  final TextEditingController _emailController = TextEditingController();
  WorkspaceRole _selectedRole = WorkspaceRole.viewer;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final membersAsync = ref.watch(
      memberListControllerProvider(widget.workspace.id),
    );

    return AlertDialog(
      title: const Text("Manage Members"),
      content: SizedBox(
        width: 500,
        height: 600,
        child: Column(
          children: [
            // Invite Section
            Row(
              children: [
                Expanded(
                  child: CustomTextfield(
                    controller: _emailController,
                    hintText: "Enter email to invite",
                  ),
                ),
                const SizedBox(width: 8),
                DropdownButton<WorkspaceRole>(
                  value: _selectedRole,
                  underline: const SizedBox(),
                  onChanged: (role) {
                    if (role != null) setState(() => _selectedRole = role);
                  },
                  items: WorkspaceRole.values.map((role) {
                    return DropdownMenuItem(
                      value: role,
                      child: Text(
                        role.toString().split('.').last.toUpperCase(),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () async {
                    final email = _emailController.text.trim();
                    if (email.isEmpty) return;

                    final currentUser = ref.read(authStateProvider).value;
                    if (currentUser?.email == email) {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("You cannot invite yourself"),
                            backgroundColor: Colors.orange,
                          ),
                        );
                      }
                      return;
                    }

                    await ref
                        .read(
                          memberListControllerProvider(
                            widget.workspace.id,
                          ).notifier,
                        )
                        .inviteMember(email: email, role: _selectedRole);
                    _emailController.clear();
                  },
                  child: const Text("Invite"),
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Divider(),
            const SizedBox(height: 8),
            Expanded(
              child: membersAsync.when(
                data: (members) => ListView.builder(
                  itemCount: members.length,
                  itemBuilder: (context, index) {
                    final member = members[index];
                    return _buildMemberTile(context, ref, member);
                  },
                ),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (err, _) => Center(child: Text("Error: $err")),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text("Done"),
        ),
      ],
    );
  }

  Widget _buildMemberTile(
    BuildContext context,
    WidgetRef ref,
    WorkspaceMemberEntity member,
  ) {
    final profileAsync = ref.watch(profileProvider(member.userId));

    return ListTile(
      leading: profileAsync.when(
        data: (profile) => CircleAvatar(
          backgroundImage: profile?.avatarUrl != null
              ? NetworkImage(profile!.avatarUrl!)
              : null,
          child: profile?.avatarUrl == null
              ? Text(profile?.displayName[0].toUpperCase() ?? "U")
              : null,
        ),
        loading: () => const CircleAvatar(
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
        error: (_, __) => const CircleAvatar(child: Icon(Icons.error)),
      ),
      title: Text(member.profile?.displayName ?? "Unknown User"),
      subtitle: Text(member.role.toString().split('.').last.toUpperCase()),
      trailing:
          widget.workspace.memberRole == 'owner' ||
              widget.workspace.memberRole == 'admin'
          ? Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (member.userId != widget.workspace.ownerId)
                  PopupMenuButton<WorkspaceRole>(
                    icon: const Icon(Icons.edit_outlined, size: 20),
                    onSelected: (role) {
                      ref
                          .read(
                            memberListControllerProvider(
                              widget.workspace.id,
                            ).notifier,
                          )
                          .updateRole(memberId: member.id, role: role);
                    },
                    itemBuilder: (context) => WorkspaceRole.values
                        .map(
                          (role) => PopupMenuItem(
                            value: role,
                            child: Text(
                              role.toString().split('.').last.toUpperCase(),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                if (member.userId != widget.workspace.ownerId)
                  IconButton(
                    icon: const Icon(
                      Icons.remove_circle_outline,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      ref
                          .read(
                            memberListControllerProvider(
                              widget.workspace.id,
                            ).notifier,
                          )
                          .removeMember(member.id);
                    },
                  ),
              ],
            )
          : null,
    );
  }
}
