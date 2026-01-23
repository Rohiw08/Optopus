import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:optopus/core/common/search_bar.dart';

class NodeLibraryDrawer extends StatelessWidget {
  const NodeLibraryDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    // Determine width based on screen size, similar to n8n drawer
    final double width = 400;

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
            child: ListView(
              children: const [
                NodeListTile(
                  title: 'Webhook',
                  description: 'Triggers the flow via HTTP request',
                  icon: Icons.webhook,
                  color: Colors.deepOrange,
                ),
                NodeListTile(
                  title: 'HTTP Request',
                  description: 'Make an HTTP call to an API',
                  icon: Icons.cloud_queue,
                  color: Colors.blueAccent,
                ),
                NodeListTile(
                  title: 'Code',
                  description: 'Execute custom JavaScript/Dart code',
                  icon: Icons.code,
                  color: Colors.amber,
                ),
                NodeListTile(
                  title: 'IF',
                  description: 'Split the flow based on conditions',
                  icon: Icons.call_split,
                  color: Colors.teal,
                ),
                NodeListTile(
                  title: 'Schedule',
                  description: 'Trigger flow at specific times',
                  icon: Icons.schedule,
                  color: Colors.purple,
                ),
                NodeListTile(
                  title: 'Merge',
                  description: 'Merge multiple branches into one',
                  icon: Icons.call_merge,
                  color: Colors.indigo,
                ),
                NodeListTile(
                  title: 'Google Sheets',
                  description: 'Read and write to Google Sheets',
                  icon: Icons.grid_on,
                  color: Colors.green,
                ),
                NodeListTile(
                  title: 'Slack',
                  description: 'Send messages to Slack',
                  icon: Icons.alternate_email,
                  color: Colors.redAccent,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class NodeListTile extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final Color color;

  const NodeListTile({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
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
        // TODO: Add node to canvas logic
        Scaffold.of(context).closeEndDrawer();
      },
      hoverColor: Theme.of(context).hoverColor,
    );
  }
}
