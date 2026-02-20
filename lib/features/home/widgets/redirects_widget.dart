import 'package:flutter/material.dart';
import 'package:optopus/core/widgets/navigation_tile_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class RedirectsWidget extends StatelessWidget {
  const RedirectsWidget({super.key});

  final List<Map<String, String>> redirects = const [
    {"What is Optopus?": "http://localhost:8000/docs#/"},
    {"How to use Optopus?": "http://localhost:8000/docs#/"},
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Expanded(
      child: ListView.builder(
        itemCount: redirects.length,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: NavigationTileWidget(
            onPressed: () {
              launchUrl(Uri.parse(redirects[index].values.first));
            },
            text: redirects[index].keys.first,
            height: 40,
            fontSize: 12,
            textColor: theme.colorScheme.onSurface.withValues(alpha: 0.6),
            borderColor: Colors.transparent,
            hoverBackgroundColor: theme.colorScheme.surfaceBright,
            hoverBorderColor: Colors.transparent,
            trailing: Icon(
              Icons.arrow_outward,
              size: 12,
              color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
            ),
          ),
        ),
      ),
    );
  }
}
