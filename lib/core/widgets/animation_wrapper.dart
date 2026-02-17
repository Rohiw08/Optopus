import 'package:flutter/material.dart';

enum Direction { leftToRight, rightToLeft, topToBottom, bottomToTop }

class AnimationWrapper extends StatelessWidget {
  final int index;
  final Direction direction;
  final List<Widget> widgets;
  final Duration duration;

  const AnimationWrapper({
    super.key,
    required this.index,
    required this.direction,
    required this.widgets,
    this.duration = const Duration(milliseconds: 300),
  });

  Offset _getBeginOffset() {
    switch (direction) {
      case Direction.leftToRight:
        return const Offset(-1.0, 0.0);
      case Direction.rightToLeft:
        return const Offset(1.0, 0.0);
      case Direction.topToBottom:
        return const Offset(0.0, -1.0);
      case Direction.bottomToTop:
        return const Offset(0.0, 1.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (index < 0 || index >= widgets.length) {
      return const SizedBox.shrink();
    }

    return AnimatedSwitcher(
      duration: duration,
      transitionBuilder: (Widget child, Animation<double> animation) {
        return SlideTransition(
          position: Tween<Offset>(begin: _getBeginOffset(), end: Offset.zero)
              .animate(
                CurvedAnimation(parent: animation, curve: Curves.easeInOut),
              ),
          child: FadeTransition(opacity: animation, child: child),
        );
      },
      child: Container(key: ValueKey<int>(index), child: widgets[index]),
    );
  }
}
