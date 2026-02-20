import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:optopus/core/widgets/search_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:optopus/features/nodes/presentation/providers/node_types_provider.dart';
import 'package:optopus/core/widgets/loading_screen.dart';
import 'package:optopus/core/widgets/error_screen.dart';

class EditorNodeLibraryDrawer extends ConsumerWidget {
  const EditorNodeLibraryDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final double width = 400;

    final nodeTypesAsync = ref.watch(nodeTypesProvider);

    return Drawer(
      width: width,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Nodes',
              style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).textTheme.bodyLarge?.color,
              ),
            ),
          ),

          // Search Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: CustomSearchBar(
              height: 35,
              width: double.infinity,
              hintText: "Search nodes...",
            ),
          ),
          const SizedBox(height: 16),
          Divider(height: 1, color: Theme.of(context).dividerColor),

          // List
          Expanded(
            child: nodeTypesAsync.when(
              data: (nodes) {
                if (nodes.isEmpty) {
                  return const Center(child: Text("No nodes found"));
                }

                return ListView.builder(
                  itemCount: nodes.length,
                  itemBuilder: (context, index) {
                    final node = nodes[index];
                    return NodeListTile(
                      title: node.type.toUpperCase(),
                      type: node.type,
                      description: node.description,
                      icon: _getIconForDomain(node.domain),
                      color: _getColorForDomain(node.domain),
                    );
                  },
                );
              },
              loading: () => const Center(child: LoadingScreen()),
              error: (err, stack) => ErrorScreen(message: err.toString()),
            ),
          ),
        ],
      ),
    );
  }

  IconData _getIconForDomain(String domain) {
    switch (domain) {
      case 'logistics':
        return Icons.local_shipping;
      case 'manufacturing':
        return Icons.precision_manufacturing;
      case 'aviation':
        return Icons.flight;
      default:
        return Icons.category;
    }
  }

  Color _getColorForDomain(String domain) {
    switch (domain) {
      case 'logistics':
        return Colors.blueAccent;
      case 'manufacturing':
        return Colors.amber;
      case 'aviation':
        return Colors.lightBlue;
      default:
        return Colors.deepOrange;
    }
  }
}

class NodeListTile extends StatelessWidget {
  final String title;
  final String type;
  final String description;
  final IconData icon;
  final Color color;

  const NodeListTile({
    super.key,
    required this.title,
    required this.type,
    required this.description,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Draggable<String>(
      data: type,
      onDragStarted: () {
        // Close the drawer so the user can see the canvas while dragging
        Scaffold.of(context).closeEndDrawer();
      },
      feedback: Material(
        color: Colors.transparent,
        child: Container(
          width: 200,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(blurRadius: 8, color: Colors.black.withOpacity(0.2)),
            ],
          ),
          child: Row(
            children: [
              Icon(icon, color: color, size: 24),
              const SizedBox(width: 10),
              Text(
                title,
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
      child: ListTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: color.withAlpha(25), // Light background
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: color.withAlpha(50), width: 1),
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        title: Text(
          title,
          style: GoogleFonts.inter(fontWeight: FontWeight.w500, fontSize: 14),
        ),
        subtitle: Text(
          description,
          style: GoogleFonts.inter(
            fontSize: 12,
            color: Theme.of(context).textTheme.bodySmall?.color?.withAlpha(180),
          ),
        ),
        onTap: () {
          // Keep tap for expected behavior if needed, or remove
          Scaffold.of(context).closeEndDrawer();
        },
        hoverColor: Theme.of(context).hoverColor,
      ),
    );
  }
}
