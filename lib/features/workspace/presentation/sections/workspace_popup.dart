import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:optopus/features/workspace/presentation/sections/workspace_list_section.dart';

class WorkspacePopup extends ConsumerWidget {
  const WorkspacePopup({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return Container(
      width: 300,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      color: theme.scaffoldBackgroundColor,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment:
            CrossAxisAlignment.center, // Center align for top section
        children: [WorkspaceListSection()],
      ),
    );
  }
}
