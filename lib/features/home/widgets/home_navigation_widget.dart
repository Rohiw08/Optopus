import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:optopus/core/widgets/navigation_tile_widget.dart';

class HomeNavigationWidget extends StatelessWidget {
  const HomeNavigationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final items = [
      (
        text: 'Create Workspace',
        route: '/workspaces',
        icon: Icons.add_circle_outline,
      ),
    ];

    return Expanded(
      child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: NavigationTileWidget(
              onPressed: () => context.go(item.route),
              text: item.text,
              height: 40,
              fontSize: 14,
              width: double.infinity,
              textColor: theme.colorScheme.onSurface,
              borderColor: Colors.transparent,
              hoverBackgroundColor: theme.colorScheme.surfaceBright,
            ),
          );
        },
      ),
    );
  }
}
