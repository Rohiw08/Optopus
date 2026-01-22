import 'package:flutter/material.dart';
import 'package:optopus/core/common/icon_button.dart';
import 'package:optopus/core/common/sidebar_content_bar.dart';

class HomeRightActions extends StatelessWidget {
  const HomeRightActions({super.key});

  @override
  Widget build(BuildContext context) {
    return SideBar(
      minWidth: 45,
      width: 45,
      height: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          CustomIconButton(
            icon: Icons.insert_drive_file_outlined,
            onPressed: () {},
            size: 20,
            tooltip: "Change input data",
          ),
          const SizedBox(height: 10),
          CustomIconButton(
            icon: Icons.chat_outlined,
            onPressed: () {},
            size: 20,
            tooltip: "Chatbot",
          ),
          const SizedBox(height: 10),
          CustomIconButton(
            icon: Icons.picture_as_pdf_outlined,
            onPressed: () {},
            size: 20,
            tooltip: "Save report",
          ),
          const SizedBox(height: 10),
          CustomIconButton(
            icon: Icons.info_outline,
            onPressed: () {},
            size: 20,
            tooltip: "info",
          ),
        ],
      ),
    );
  }
}
