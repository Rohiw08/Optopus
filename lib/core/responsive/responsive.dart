import 'package:flutter/material.dart';
import 'package:optopus/core/responsive/layouts/mobile_layout.dart';
import 'package:optopus/core/responsive/layouts/tab_layout.dart';
import 'package:optopus/core/responsive/layouts/desktop_layout.dart';

class Responsive extends StatelessWidget {
  final MobileLayout mobileLayout;
  final TabLayout tabLayout;
  final DesktopLayout desktopLayout;
  const Responsive({
    super.key,
    required this.mobileLayout,
    required this.tabLayout,
    required this.desktopLayout,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          return mobileLayout;
        } else if (constraints.maxWidth < 900) {
          return tabLayout;
        } else {
          return desktopLayout;
        }
      },
    );
  }
}
