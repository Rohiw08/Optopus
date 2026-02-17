import 'package:flutter/material.dart';

class CustomOutlinedButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final double? width;
  final double? height;
  final Color? backgroundColor;
  final Color? hoverBackgroundColor;
  final Color? borderColor;
  final Color? hoverBorderColor;
  final Color? focustedBorderColor;
  final Color? textColor;
  final bool isLoading;
  final AlignmentGeometry? alignment;
  final double? fontSize;
  final Widget? leading;
  final Widget? trailing;

  const CustomOutlinedButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.width,
    this.height,
    this.backgroundColor,
    this.hoverBackgroundColor,
    this.borderColor,
    this.hoverBorderColor,
    this.focustedBorderColor,
    this.textColor,
    this.isLoading = false,
    this.alignment,
    this.fontSize,
    this.leading,
    this.trailing,
  });

  @override
  State<CustomOutlinedButton> createState() => _CustomOutlinedButtonState();
}

class _CustomOutlinedButtonState extends State<CustomOutlinedButton> {
  bool _isHovered = false;
  bool _isFocused = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final backgroundColor = widget.backgroundColor ?? Colors.transparent;
    final hoverBackgroundColor =
        widget.hoverBackgroundColor ??
        theme.colorScheme.surfaceContainerHighest;
    final borderColor = widget.borderColor ?? theme.colorScheme.outline;
    final hoverBorderColor =
        widget.hoverBorderColor ?? theme.colorScheme.primary;
    final focustedBorderColor =
        widget.focustedBorderColor ?? theme.colorScheme.primary;
    final textColor = widget.textColor ?? theme.colorScheme.onSurface;

    Color currentBorderColor = borderColor;
    if (_isFocused) {
      currentBorderColor = focustedBorderColor;
    } else if (_isHovered) {
      currentBorderColor = hoverBorderColor;
    }

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: Focus(
        onFocusChange: (focused) => setState(() => _isFocused = focused),
        child: GestureDetector(
          onTap: widget.isLoading ? null : widget.onPressed,
          child: Container(
            width: widget.width,
            height: widget.height ?? 48,
            decoration: BoxDecoration(
              color: _isHovered ? hoverBackgroundColor : backgroundColor,
              border: Border.all(color: currentBorderColor, width: 1.5),
              borderRadius: BorderRadius.circular(8),
            ),
            alignment: widget.alignment ?? Alignment.center,
            padding: (widget.leading != null || widget.trailing != null)
                ? const EdgeInsets.symmetric(horizontal: 16)
                : null,
            child: widget.isLoading
                ? SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: textColor,
                    ),
                  )
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (widget.leading != null) ...[
                        widget.leading!,
                        const SizedBox(width: 8),
                      ],
                      Text(
                        widget.text,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: textColor,
                          fontWeight: FontWeight.w500,
                          fontSize: widget.fontSize,
                        ),
                      ),
                      if (widget.trailing != null) ...[
                        const SizedBox(width: 8),
                        widget.trailing!,
                      ],
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
