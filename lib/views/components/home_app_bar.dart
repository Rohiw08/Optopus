import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:optopus/core/common/button_icon.dart';
import 'package:optopus/core/common/create_button.dart';
import 'package:optopus/core/common/icon_button.dart';
import 'package:optopus/core/common/search_bar.dart';
import 'package:optopus/core/common/sidebar_content_bar.dart';
import 'package:optopus/core/utils/screen_width.dart';
import 'package:optopus/core/providers/theme_provider.dart';
import 'package:optopus/core/common/invitation_dialog.dart';

class HomeAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

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
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: Center(
                child: CustomButtonIcon(
                  height: 25,
                  width: 150,
                  text: "Workspace",
                  onPressed: () {},
                  icon: Icons.keyboard_arrow_down_sharp,
                ),
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
                mainAxisAlignment: MainAxisAlignment.center,
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
                      ref
                          .read(themeProvider.notifier)
                          .state = ref.read(themeProvider) == ThemeMode.dark
                          ? ThemeMode.light
                          : ThemeMode.dark;
                    },
                    icon: ref.watch(themeProvider) == ThemeMode.dark
                        ? Icons.dark_mode
                        : Icons.light_mode,
                    size: 20,
                  ),
                  const SizedBox(width: 10),
                  const CircleAvatar(
                    backgroundColor: Colors.deepPurpleAccent,
                    radius: 13,
                    child: Icon(Icons.person),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
