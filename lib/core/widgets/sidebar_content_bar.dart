import 'package:flutter/material.dart';
import 'package:optopus/core/utils/screen_width.dart';

class SideBar extends StatelessWidget {
  final double minWidth;
  final double width;
  final double height;
  final Widget child;
  final BoxBorder? border;

  const SideBar({
    super.key,
    required this.minWidth,
    required this.width,
    required this.height,
    required this.child,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = getScreenWidth(context);

    return Container(
      width: screenWidth < 700 ? minWidth : width,
      height: height,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        border:
            border ??
            Border.all(
              style: BorderStyle.solid,
              width: 0.1,
              color: Theme.of(context).dividerColor,
            ),
      ),
      child: child,
    );
  }
}
