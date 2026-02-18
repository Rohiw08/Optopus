import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:optopus/core/widgets/custom_outlined_widget.dart';
import 'package:optopus/core/widgets/selection_indicator_widget.dart';
import 'package:optopus/features/workspace/domain/entities/workspace_template_entity.dart';
import 'package:optopus/features/workspace/presentation/states/selected_template_controller.dart';

class TemplateSelectionSection extends ConsumerWidget {
  final List<WorkspaceTemplateEntity> workspaceTemplates;
  const TemplateSelectionSection({super.key, required this.workspaceTemplates});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final selectedIndex = ref.watch(selectedTemplateControllerProvider);
    return ListView.builder(
      shrinkWrap: true,
      itemCount: workspaceTemplates.length,
      itemBuilder: (context, index) {
        final item = workspaceTemplates[index];
        final isSelected = selectedIndex == index;

        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: CustomOutlinedButton(
            onPressed: () {
              ref
                  .read(selectedTemplateControllerProvider.notifier)
                  .select(index);
            },
            text: item.title,
            height: 55,
            fontSize: 13,
            width: double.infinity,
            alignment: Alignment.centerLeft,
            backgroundColor: Colors.transparent,
            hoverBackgroundColor: Colors.transparent,
            textColor: theme.colorScheme.onSurface,
            borderColor: isSelected
                ? theme.colorScheme.tertiary
                : theme.colorScheme.outline.withValues(alpha: 0.1),
            hoverBorderColor: isSelected
                ? theme.colorScheme.tertiary
                : theme.colorScheme.outline.withValues(alpha: 0.2),
            leading: Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Icon(
                item.icon,
                size: 20,
                color: theme.colorScheme.onSurface.withValues(alpha: 0.2),
              ),
            ),
            trailing: SelectionIndicator(isSelected: isSelected),
          ),
        );
      },
    );
  }
}
