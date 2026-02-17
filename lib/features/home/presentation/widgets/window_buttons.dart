import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';

class WindowButtons extends StatelessWidget {
  const WindowButtons({super.key});

  @override
  Widget build(BuildContext context) {
    // Window button colors for normal and hover states
    final buttonColors = WindowButtonColors(
      iconNormal: Theme.of(context).colorScheme.onSurface,
      mouseOver: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.1),
      mouseDown: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.2),
      iconMouseOver: Theme.of(context).colorScheme.onSurface,
      iconMouseDown: Theme.of(context).colorScheme.onSurface,
    );

    // Close button specific colors (usually red on hover)
    final closeButtonColors = WindowButtonColors(
      mouseOver: const Color(0xFFD32F2F),
      mouseDown: const Color(0xFFB71C1C),
      iconNormal: Theme.of(context).colorScheme.onSurface,
      iconMouseOver: Colors.white,
    );

    return SizedBox(
      height: 50, // Match AppBar height
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          MinimizeWindowButton(colors: buttonColors),
          MaximizeWindowButton(colors: buttonColors),
          CloseWindowButton(colors: closeButtonColors),
        ],
      ),
    );
  }
}
