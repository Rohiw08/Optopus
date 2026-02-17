import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:optopus/features/workspace/domain/data/workspace_templates.dart';
import 'package:optopus/features/workspace/presentation/controllers/selected_template_controller.dart';

class CreateWorkspaceImageHolderWidget extends ConsumerWidget {
  const CreateWorkspaceImageHolderWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(selectedTemplateControllerProvider);

    return Center(
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        switchInCurve: Curves.easeOut,
        switchOutCurve: Curves.easeIn,
        child: Image.asset(
          workspaceTemplates[selectedIndex].imagePath,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
