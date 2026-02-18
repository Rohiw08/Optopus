import 'package:flutter/material.dart';

class DividerWidget extends StatelessWidget {
  const DividerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Divider(
      color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
      thickness: 0.1,
      height: 1,
      indent: 25,
      endIndent: 45,
    );
  }
}
