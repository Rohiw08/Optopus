import 'package:flutter/material.dart';
import 'package:optopus/core/utils/button_text.dart';

class CreateButton extends StatelessWidget {
  final double height;
  final double width;
  final String text;
  final IconData icon;
  final VoidCallback onPressed; // Callback function type (no arguments)

  const CreateButton({
    required this.height,
    required this.width,
    required this.text,
    required this.onPressed,
    required this.icon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: TextButton.icon(
        onPressed: onPressed, // Use the provided callback function
        icon: Icon(
          icon,
          weight: 0.3,
          size: 20,
          color: Theme.of(context).iconTheme.color,
        ),
        label: CustomButtonText(text),
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(
            Theme.of(context).colorScheme.surface,
          ),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(3.0),
              side: BorderSide(
                color: Theme.of(context).dividerColor,
                width: 0.2, // Set border width
              ),
            ),
          ),
        ),
      ),
    );
  }
}
