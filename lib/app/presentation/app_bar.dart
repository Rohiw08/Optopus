import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:optopus/app/router/router.dart';
import 'package:optopus/core/widgets/button_icon.dart';
import 'package:optopus/core/widgets/custom_outlined_widget.dart';
import 'package:optopus/core/widgets/icon_button.dart';
import 'package:optopus/core/widgets/search_bar.dart';
import 'package:optopus/core/widgets/sidebar_content_bar.dart';

import 'package:optopus/core/utils/screen_width.dart';
import 'package:optopus/core/theme/theme_provider.dart' hide Theme;
import 'package:optopus/core/session/session_provider.dart';
import 'package:optopus/features/profile/presentation/widgets/profile_popup.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:optopus/core/widgets/window_buttons.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';

import 'package:optopus/core/navigation/navigation_history_controller.dart';
import 'package:optopus/features/workspace/presentation/sections/workspace_popup.dart';

class AppBarWidget extends ConsumerWidget implements PreferredSizeWidget {
  const AppBarWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenWidth = getScreenWidth(context);

    return PreferredSize(
      preferredSize: const Size(double.infinity, 60),
      child: SideBar(
        height: 50,
        width: screenWidth,
        minWidth: screenWidth,
        child: Stack(
          children: [
            if (!kIsWeb &&
                (Platform.isWindows || Platform.isLinux || Platform.isMacOS))
              MoveWindow(child: Container()),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildLeadingActions(context, ref, screenWidth),
                if (screenWidth > 700) _buildSearchArea(),
                _buildTrailingActions(context, ref, screenWidth),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLeadingActions(
    BuildContext context,
    WidgetRef ref,
    double screenWidth,
  ) {
    return Expanded(
      child: Row(
        children: [
          const SizedBox(width: 10),
          _buildNavigationHistory(ref),
          const SizedBox(width: 10),
          if (screenWidth < 700)
            CustomIconButton(
              onPressed: () {},
              icon: Icons.person_add_alt,
              size: 20,
            )
          else
            CustomOutlinedButton(
              text: "Home",
              height: 25,
              width: 95,
              onPressed: () => ref.read(routerProvider).go("/home"),
            ),
          _buildWorkspaceMenu(context),
        ],
      ),
    );
  }

  Widget _buildNavigationHistory(WidgetRef ref) {
    final history = ref.watch(navigationHistoryControllerProvider);
    final historyNotifier = ref.read(
      navigationHistoryControllerProvider.notifier,
    );
    final router = ref.read(routerProvider);

    return Row(
      children: [
        Opacity(
          opacity: history.backStack.isNotEmpty ? 1.0 : 0.5,
          child: CustomIconButton(
            onPressed: history.backStack.isNotEmpty
                ? () {
                    final path = historyNotifier.goBack();
                    if (path != null) router.go(path);
                  }
                : null,
            icon: Icons.chevron_left,
            size: 20,
          ),
        ),
        const SizedBox(width: 5),
        Opacity(
          opacity: history.forwardStack.isNotEmpty ? 1.0 : 0.5,
          child: CustomIconButton(
            onPressed: history.forwardStack.isNotEmpty
                ? () {
                    final path = historyNotifier.goForward();
                    if (path != null) router.go(path);
                  }
                : null,
            icon: Icons.chevron_right,
            size: 20,
          ),
        ),
      ],
    );
  }

  Widget _buildWorkspaceMenu(BuildContext context) {
    final theme = Theme.of(context);
    return MenuAnchor(
      alignmentOffset: const Offset(0, 5),
      style: MenuStyle(
        backgroundColor: WidgetStateProperty.all(theme.scaffoldBackgroundColor),
        surfaceTintColor: WidgetStateProperty.all(Colors.transparent),
      ),
      builder: (context, controller, child) {
        return GestureDetector(
          onTap: () {
            if (controller.isOpen) {
              controller.close();
            } else {
              controller.open();
            }
          },
          child: CustomButtonIcon(
            height: 25,
            width: 150,
            text: "Workspace",
            onPressed: () {},
            icon: Icons.keyboard_arrow_down_sharp,
          ),
        );
      },
      menuChildren: [const WorkspacePopup()],
    );
  }

  Widget _buildSearchArea() {
    return const Expanded(
      child: Center(
        child: CustomSearchBar(
          height: 33,
          width: 180,
          hintText: "Search directory",
        ),
      ),
    );
  }

  Widget _buildTrailingActions(
    BuildContext context,
    WidgetRef ref,
    double screenWidth,
  ) {
    final themeMode = ref.watch(themeProvider);

    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (screenWidth <= 700)
            CustomIconButton(
              onPressed: () {},
              icon: Icons.search_outlined,
              size: 20,
            ),
          const SizedBox(width: 5),
          CustomIconButton(
            onPressed: () {},
            icon: Icons.person_add_alt,
            size: 20,
          ),
          const SizedBox(width: 5),
          CustomIconButton(
            icon: Icons.settings_outlined,
            onPressed: () {},
            size: 20,
          ),
          CustomIconButton(
            icon: Icons.notifications_none_outlined,
            onPressed: () {},
            size: 20,
          ),
          CustomIconButton(
            onPressed: () => ref.read(themeProvider.notifier).toggle(),
            icon: themeMode == ThemeMode.dark
                ? Icons.dark_mode
                : Icons.light_mode,
            size: 20,
          ),
          const SizedBox(width: 10),
          _buildProfileMenu(context, ref),
          if (!kIsWeb &&
              (Platform.isWindows || Platform.isLinux || Platform.isMacOS)) ...[
            const WindowButtons(),
            const SizedBox(width: 5),
          ],
        ],
      ),
    );
  }

  Widget _buildProfileMenu(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final sessionAsync = ref.watch(sessionProvider);
    final account = sessionAsync.hasValue ? sessionAsync.value : null;

    return MenuAnchor(
      alignmentOffset: const Offset(-280, 5),
      style: MenuStyle(
        backgroundColor: WidgetStateProperty.all(theme.scaffoldBackgroundColor),
        surfaceTintColor: WidgetStateProperty.all(Colors.transparent),
      ),
      builder: (context, controller, child) {
        return GestureDetector(
          onTap: () {
            if (controller.isOpen) {
              controller.close();
            } else {
              controller.open();
            }
          },
          child: CircleAvatar(
            radius: 13,
            backgroundImage: account?.avatarUrl != null
                ? NetworkImage(account!.avatarUrl!)
                : null,
            backgroundColor: Colors.deepPurpleAccent,
            child: account?.avatarUrl == null
                ? const Icon(Icons.person, size: 16, color: Colors.white)
                : null,
          ),
        );
      },
      menuChildren: [const ProfilePopup()],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
