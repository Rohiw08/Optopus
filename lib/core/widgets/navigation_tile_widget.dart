import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NavigationTileWidget extends ConsumerWidget {
  final Color? backgroundColor;
  final Color? hoverBackgroundColor;
  final Color? textColor;
  final Color? borderColor;
  final Color? hoverBorderColor;
  final String text;
  final VoidCallback onPressed;
  final double height;
  final double width;
  final double fontSize;
  final Widget? trailing;
  final Alignment alignment;

  const NavigationTileWidget({
    super.key,
    this.backgroundColor,
    this.hoverBackgroundColor,
    required this.text,
    required this.onPressed,
    this.textColor,
    this.borderColor,
    this.hoverBorderColor,
    this.height = 40,
    this.width = double.infinity,
    this.fontSize = 12,
    this.trailing,
    this.alignment = Alignment.centerLeft,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return OutlinedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        // Allow overriding background color
        backgroundColor:
            (backgroundColor != null || hoverBackgroundColor != null)
            ? WidgetStateProperty.resolveWith<Color>((states) {
                if (states.contains(WidgetState.hovered)) {
                  return hoverBackgroundColor ??
                      backgroundColor ??
                      Colors.transparent;
                }
                return backgroundColor ?? Colors.transparent;
              })
            : null,

        // Allow overriding text color
        foregroundColor: textColor != null
            ? WidgetStateProperty.all(textColor)
            : null,

        // Allow overriding border color
        side: (borderColor != null || hoverBorderColor != null)
            ? WidgetStateProperty.resolveWith<BorderSide>((states) {
                if (states.contains(WidgetState.hovered)) {
                  return BorderSide(
                    color:
                        hoverBorderColor ??
                        borderColor ??
                        colorScheme.onSurface,
                    width: 1,
                  );
                }
                return BorderSide(
                  color: borderColor ?? colorScheme.outline,
                  width: 1,
                );
              })
            : null,

        // Allow overriding dimensions
        minimumSize: WidgetStateProperty.all(Size(width, height)),
        alignment: alignment,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            text,
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w500),
          ),
          if (trailing != null) ...[const SizedBox(width: 4), trailing!],
        ],
      ),
    );
  }
}
