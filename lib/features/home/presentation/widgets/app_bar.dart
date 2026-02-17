import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:optopus/core/widgets/button_icon.dart';
import 'package:optopus/core/widgets/create_button.dart';
import 'package:optopus/core/widgets/icon_button.dart';
import 'package:optopus/core/widgets/invitation_dialog.dart';
import 'package:optopus/core/widgets/search_bar.dart';
import 'package:optopus/core/widgets/sidebar_content_bar.dart';

import 'package:optopus/core/utils/screen_width.dart';
import 'package:optopus/core/theme/theme_provider.dart' hide Theme;
import 'package:optopus/core/session/session_provider.dart';
import 'package:optopus/features/home/presentation/widgets/profile_popup.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:optopus/features/home/presentation/widgets/window_buttons.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';

// TODO: update the app bar for clean architecture
class AppBarWidget extends ConsumerWidget implements PreferredSizeWidget {
  const AppBarWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double screenWidth = getScreenWidth(context);
    final theme = Theme.of(context);

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
                Expanded(
                  child: Row(
                    children: [
                      const SizedBox(width: 10),
                      CustomIconButton(
                        onPressed: () {},
                        icon: Icons.chevron_left,
                        size: 20,
                      ),
                      const SizedBox(width: 5),
                      CustomIconButton(
                        onPressed: () {},
                        icon: Icons.chevron_right,
                        size: 20,
                      ),
                      const SizedBox(width: 10),
                      CustomButtonIcon(
                        height: 25,
                        width: 150,
                        text: "Workspace",
                        onPressed: () {},
                        icon: Icons.keyboard_arrow_down_sharp,
                      ),
                    ],
                  ),
                ),
                if (screenWidth > 700)
                  const Expanded(
                    child: Center(
                      child: CustomSearchBar(
                        height: 33,
                        width: 180,
                        hintText: "Search directory",
                      ),
                    ),
                  ),
                Expanded(
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
                      screenWidth < 700
                          ? CustomIconButton(
                              onPressed: () {},
                              icon: Icons.person_add_alt,
                              size: 20,
                            )
                          : CreateButton(
                              text: "Invite",
                              icon: Icons.person_add_alt,
                              height: 25,
                              width: 95,
                              onPressed: () {
                                showInvitationDialog(context);
                              },
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
                        onPressed: () {
                          ref.read(themeProvider.notifier).toggle();
                        },
                        icon: ref.watch(themeProvider) == ThemeMode.dark
                            ? Icons.dark_mode
                            : Icons.light_mode,
                        size: 20,
                      ),
                      const SizedBox(width: 10),
                      MenuAnchor(
                        alignmentOffset: const Offset(-280, 5),
                        style: MenuStyle(
                          backgroundColor: WidgetStateProperty.all(
                            theme.scaffoldBackgroundColor,
                          ),
                          surfaceTintColor: WidgetStateProperty.all(
                            Colors.transparent,
                          ),
                        ),
                        builder: (context, controller, child) {
                          final sessionAsync = ref.watch(sessionProvider);
                          final account = sessionAsync.hasValue
                              ? sessionAsync.value
                              : null;
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
                                  ? const Icon(
                                      Icons.person,
                                      size: 16,
                                      color: Colors.white,
                                    )
                                  : null,
                            ),
                          );
                        },
                        menuChildren: [const ProfilePopup()],
                      ),

                      if (!kIsWeb &&
                          (Platform.isWindows ||
                              Platform.isLinux ||
                              Platform.isMacOS)) ...[
                        const WindowButtons(),
                        const SizedBox(width: 5),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
