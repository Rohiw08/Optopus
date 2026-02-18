import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:optopus/features/home/presentation/controllers/home_view_controller.dart';
import 'package:optopus/features/workspace/presentation/controllers/workspace_list_controller.dart';
import 'package:optopus/features/workspace/presentation/sections/create_workspace_section.dart';
import 'package:optopus/core/widgets/create_button.dart';
import 'package:optopus/core/widgets/search_bar.dart';
import 'package:optopus/core/widgets/sidebar_content_bar.dart';
import 'package:optopus/core/widgets/button_text.dart';

class HomeFileExplorer extends ConsumerWidget {
  final double width;
  const HomeFileExplorer({super.key, required this.width});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final workspacesAsync = ref.watch(workspaceListControllerProvider);

    return SideBar(
      minWidth: 200,
      width: width,
      height: double.infinity,
      border: Border(
        right: BorderSide(color: Theme.of(context).dividerColor, width: 0.5),
      ),
      child: Column(
        children: [
          const SizedBox(height: 10),
          Row(
            children: [
              const SizedBox(width: 5),
              const Expanded(
                flex: 2,
                child: CustomSearchBar(
                  height: 25,
                  width: double.infinity,
                  hintText: "Search",
                ),
              ),
              const SizedBox(width: 5),
              CreateButton(
                icon: Icons.add,
                text: width > 220 ? "Create" : "",
                height: 25,
                width: width > 220 ? 100 : 30,
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => Center(
                      child: Material(
                        type: MaterialType.transparency,
                        child: Center(
                          child: CreateWorkspaceSection(
                            onCancel: () => Navigator.pop(context),
                            onSuccess: (workspace) {
                              Navigator.pop(context);
                              if (workspace != null) {
                                ref
                                    .read(homeViewControllerProvider.notifier)
                                    .openWorkspace(workspace);
                              }
                            },
                          ),
                        ),
                        // CreateWorkspaceWidget(
                        //   onCancel: () => Navigator.pop(context),
                        //   onSuccess: (workspace) {
                        //     Navigator.pop(context);
                        //     if (workspace != null) {
                        //       ref
                        //           .read(homeViewControllerProvider.notifier)
                        //           .openWorkspace(workspace);
                        //     }
                        //   },
                        // ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(width: 5),
            ],
          ),
          const SizedBox(width: 20),
          Expanded(
            child: workspacesAsync.when(
              data: (workspaces) {
                if (workspaces.isEmpty) {
                  return const Center(child: Text("No workspaces yet"));
                }
                return ListView.builder(
                  itemCount: workspaces.length,
                  itemBuilder: (context, index) {
                    final workspace = workspaces[index];
                    return ListTile(
                      title: CustomButtonText(workspace.name),
                      trailing: const Icon(Icons.chevron_right, size: 16),
                      onTap: () {
                        ref
                            .read(homeViewControllerProvider.notifier)
                            .openWorkspace(workspace);
                      },
                    );
                  },
                );
              },
              error: (err, stack) => Center(child: Text("Error: $err")),
              loading: () => const Center(child: CircularProgressIndicator()),
            ),
          ),
        ],
      ),
    );
  }
}
