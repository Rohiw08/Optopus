import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    super.key,
    this.onPressed,
    required this.icon,
    this.iconWidget,
    required this.size,
    this.tooltip = "",
  });

  final VoidCallback? onPressed;
  final IconData icon;
  final Widget? iconWidget;
  final double size;
  final String tooltip;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      iconSize: size,
      icon:
          iconWidget ??
          Icon(
            icon,
            weight: 0.5, // Adjust weight as needed
            color: Theme.of(context).iconTheme.color,
          ),
      tooltip: tooltip,
    );
  }
}
