import 'package:flutter/material.dart';
import 'package:optopus/core/widgets/button_text.dart';
import 'package:optopus/core/utils/screen_width.dart';

class SquareIconButton extends StatelessWidget {
  const SquareIconButton({
    super.key,
    required this.icon,
    required this.text,
    required this.height,
    required this.iconSize,
    required this.maxHeight,
  });

  final IconData icon;
  final String text;
  final double height;
  final double iconSize;
  final double maxHeight;

  @override
  Widget build(BuildContext context) {
    double screenWidth = getScreenWidth(context);

    return Container(
      height: screenWidth < 700 ? height - 5 : maxHeight - 5,
      width: double.maxFinite - 5,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                icon,
                weight: 0.5, // Adjust weight as needed
                size: iconSize,
                color: Theme.of(context).iconTheme.color,
              ),
              if (screenWidth > 700) CustomButtonText(text),
            ],
          ),
        ),
      ),
    );
  }
}
