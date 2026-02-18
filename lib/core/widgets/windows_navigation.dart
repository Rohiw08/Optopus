import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:optopus/core/utils/screen_width.dart';
import 'package:optopus/core/widgets/sidebar_content_bar.dart';
import 'package:optopus/core/widgets/window_buttons.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';

class WindowsNavigation extends ConsumerWidget implements PreferredSizeWidget {
  const WindowsNavigation({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double screenWidth = getScreenWidth(context);

    return PreferredSize(
      preferredSize: const Size(double.infinity, 60),
      child: SideBar(
        height: 50,
        width: screenWidth,
        minWidth: screenWidth,
        child: Row(
          children: [
            if (!kIsWeb &&
                (Platform.isWindows || Platform.isLinux || Platform.isMacOS))
              Expanded(child: MoveWindow()),
            if (!kIsWeb &&
                (Platform.isWindows || Platform.isLinux || Platform.isMacOS))
              const WindowButtons(),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
