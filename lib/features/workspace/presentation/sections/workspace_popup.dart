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
      height: 400,
      constraints: const BoxConstraints(maxHeight: 400),
      padding: const EdgeInsets.symmetric(vertical: 8),
      color: theme.scaffoldBackgroundColor,
      child: const SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [WorkspaceListSection()],
        ),
      ),
    );
  }
}
