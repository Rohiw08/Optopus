import 'package:flutter/material.dart';

class CustomButtonText extends StatelessWidget {
  final String text;
  const CustomButtonText(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 13,
        color:
            Theme.of(context).textTheme.bodySmall?.color ??
            const Color(0xff4D4D4D),
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
