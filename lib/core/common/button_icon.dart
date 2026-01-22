import 'package:flutter/material.dart';
import 'package:optopus/core/utils/button_text.dart';

class CustomButtonIcon extends StatelessWidget {
  const CustomButtonIcon({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.height,
    required this.width,
    required this.text,
  });

  final VoidCallback onPressed;
  final IconData icon;
  final double height;
  final double width;
  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      // decoration: BoxDecoration(
      //     border: Border.all(
      //       color: const Color(0xff4D4D4D),
      //       width: 0.5,
      //     ),
      //     borderRadius: BorderRadius.circular(3.0)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment
          //     .spaceEvenly,
          children: [
            CustomButtonText(text),
            const SizedBox(width: 5),
            Icon(
              icon,
              weight: 0.3,
              size: 20,
              color: Theme.of(context).iconTheme.color,
            ),
          ],
        ),
      ),
    );
  }
}
