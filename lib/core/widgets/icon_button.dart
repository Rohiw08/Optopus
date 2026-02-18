import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    super.key,
    this.onPressed,
    required this.icon,
    required this.size,
    this.tooltip = "",
  });

  final VoidCallback? onPressed;
  final IconData icon;
  final double size;
  final String tooltip;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: UnconstrainedBox(
        child: Icon(
          icon,
          weight: 0.5, // Adjust weight as needed
          size: size,
          color: Theme.of(context).iconTheme.color,
        ),
      ),
      tooltip: tooltip,
    );
  }
}
