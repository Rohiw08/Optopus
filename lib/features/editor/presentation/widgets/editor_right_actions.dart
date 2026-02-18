import 'dart:convert';
import 'package:flow_canvas/flow_canvas.dart';
import 'package:flutter/material.dart';
import 'package:optopus/core/widgets/icon_button.dart';
import 'package:optopus/core/widgets/sidebar_content_bar.dart';
import 'package:optopus/features/flows/domain/entities/flow_entity.dart';
import 'package:optopus/features/editor/presentation/controllers/editor_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EditorRightActions extends ConsumerWidget {
  final double width;
  final FlowCanvasController controller;
  final FlowEntity? flow;

  const EditorRightActions({
    super.key,
    required this.width,
    required this.controller,
    this.flow,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SideBar(
      minWidth: 45,
      width: width,
      height: double.infinity,
      border: Border(
        left: BorderSide(color: Theme.of(context).dividerColor, width: 0.5),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          CustomIconButton(
            icon: Icons.add,
            onPressed: () {
              Scaffold.of(context).openEndDrawer();
            },
            size: 24,
            tooltip: "Add Node",
          ),
          const SizedBox(height: 10),
          CustomIconButton(
            icon: Icons.data_object,
            onPressed: () {
              final json = controller.currentState.toJson();
              final jsonString = const JsonEncoder.withIndent(
                '  ',
              ).convert(json);
              showDialog(
                context: context,
                builder: (context) => Dialog(
                  child: Container(
                    width: 600,
                    height: 500,
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Flow JSON',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            IconButton(
                              icon: const Icon(Icons.close),
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Theme.of(context).dividerColor,
                              ),
                              borderRadius: BorderRadius.circular(4),
                              color: Theme.of(context).colorScheme.surface,
                            ),
                            padding: const EdgeInsets.all(10),
                            child: SingleChildScrollView(
                              child: SelectableText(
                                jsonString,
                                style: const TextStyle(
                                  fontFamily: 'monospace',
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
            size: 24,
            tooltip: "Show JSON",
          ),
          const SizedBox(height: 10),
          if (flow != null) ...[
            CustomIconButton(
              icon: Icons.save,
              onPressed: () async {
                final json = controller.currentState.toJson();
                await ref
                    .read(editorControllerProvider.notifier)
                    .saveFlow(flowId: flow!.id, data: json);

                final saveState = ref.read(editorControllerProvider);
                if (context.mounted) {
                  saveState.when(
                    data: (_) => ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(const SnackBar(content: Text('Flow saved'))),
                    error: (error, _) =>
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Error saving flow: $error')),
                        ),
                    loading: () {},
                  );
                }
              },
              size: 24,
              tooltip: "Save Flow",
            ),
            const SizedBox(height: 10),
            CustomIconButton(
              icon: Icons.play_arrow,
              onPressed: () async {
                final json = controller.currentState.toJson();
                await ref
                    .read(editorControllerProvider.notifier)
                    .executeFlow(flowId: flow!.id, data: json);

                final executeState = ref.read(editorControllerProvider);
                if (context.mounted) {
                  executeState.when(
                    data: (_) => ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Flow executed successfully'),
                      ),
                    ),
                    error: (error, _) =>
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Error executing flow: $error'),
                          ),
                        ),
                    loading: () {},
                  );
                }
              },
              size: 24,
              tooltip: "Run Flow",
            ),
          ],
        ],
      ),
    );
  }
}
