import 'dart:convert';
import 'package:flow_canvas/flow_canvas.dart';
import 'package:flutter/material.dart';
import 'package:optopus/core/common/icon_button.dart';
import 'package:optopus/core/common/sidebar_content_bar.dart';

class HomeRightActions extends StatelessWidget {
  final double width;
  final FlowCanvasController controller;

  const HomeRightActions({
    super.key,
    required this.width,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
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
        ],
      ),
    );
  }
}
