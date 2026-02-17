import 'package:flutter/material.dart';

class SelectionIndicator extends StatelessWidget {
  final bool isSelected;

  const SelectionIndicator({super.key, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: 15,
      height: 15,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isSelected ? theme.colorScheme.tertiary : Colors.transparent,
        border: Border.all(
          color: isSelected
              ? theme.colorScheme.tertiary
              : theme.colorScheme.onSurface.withValues(alpha: 0.25),
          width: 1,
        ),
      ),
      child: isSelected
          ? Icon(Icons.check, size: 14, color: Colors.black)
          : null,
    );
  }
}
