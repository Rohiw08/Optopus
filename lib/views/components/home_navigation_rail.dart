import 'package:flutter/material.dart';
import 'package:optopus/core/common/sidebar_content_bar.dart';
import 'package:optopus/core/common/square_icon_button.dart';

class HomeNavigationRail extends StatelessWidget {
  const HomeNavigationRail({super.key});

  @override
  Widget build(BuildContext context) {
    return const SideBar(
      minWidth: 45,
      width: 80,
      height: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 10),
          SquareIconButton(
            icon: Icons.folder_open_sharp,
            text: "Reports",
            height: 45,
            maxHeight: 80,
            iconSize: 25,
          ),
          SizedBox(height: 5),
          SquareIconButton(
            icon: Icons.history_sharp,
            text: "History",
            height: 45,
            maxHeight: 80,
            iconSize: 25,
          ),
        ],
      ),
    );
  }
}
