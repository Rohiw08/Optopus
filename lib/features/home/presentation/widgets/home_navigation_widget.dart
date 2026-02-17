import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:optopus/features/home/presentation/widgets/shared/navigation_tile_widget.dart';

class HomeNavigationWidget extends StatelessWidget {
  const HomeNavigationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final currentPath = GoRouterState.of(context).uri.path;

    final items = [
      _NavItem(text: 'Home', route: '/home', icon: Icons.home_outlined),
      _NavItem(
        text: 'Create Workspace',
        route: '/create-workspace',
        icon: Icons.add_circle_outline,
      ),
    ];

    return Expanded(
      child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          final isActive = currentPath == item.route;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 2),
            child: NavigationTileWidget(
              onPressed: () => context.go(item.route),
              text: item.text,
              height: 40,
              fontSize: 14,
              width: double.infinity,
              backgroundColor: isActive
                  ? theme.colorScheme.surfaceBright
                  : Colors.transparent,
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

class _NavItem {
  final String text;
  final String route;
  final IconData icon;

  const _NavItem({required this.text, required this.route, required this.icon});
}
