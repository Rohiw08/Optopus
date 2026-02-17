import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class AuthToggleText extends StatelessWidget {
  final String text1;
  final String text2;
  final double fontSize;
  final VoidCallback? onTapText1;
  final VoidCallback? onTapText2;

  const AuthToggleText({
    super.key,
    required this.text1,
    this.text2 = "",
    this.fontSize = 15,
    this.onTapText1,
    this.onTapText2,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return RichText(
      text: TextSpan(
        text: text1,
        style: TextStyle(
          color: theme.onSurface,
          fontSize: fontSize,
          height: 1.2,
        ),
        recognizer: TapGestureRecognizer()..onTap = onTapText1,
        children: [
          TextSpan(
            text: text2,
            style: TextStyle(
              color: theme.tertiary,
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
            ),
            recognizer: TapGestureRecognizer()..onTap = onTapText2,
          ),
        ],
      ),
    );
  }
}
