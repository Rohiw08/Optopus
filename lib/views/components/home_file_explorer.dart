import 'package:flutter/material.dart';
import 'package:optopus/core/common/create_button.dart';
import 'package:optopus/core/common/search_bar.dart';
import 'package:optopus/core/common/sidebar_content_bar.dart';
import 'package:optopus/core/utils/button_text.dart';

class HomeFileExplorer extends StatelessWidget {
  const HomeFileExplorer({super.key});

  @override
  Widget build(BuildContext context) {
    return SideBar(
      minWidth: 270,
      width: 270,
      height: double.infinity,
      child: Column(
        children: [
          const SizedBox(height: 10),
          Row(
            children: [
              const SizedBox(width: 5),
              const CustomSearchBar(
                height: 25,
                width: 150,
                hintText: "Search file",
              ),
              const SizedBox(width: 10),
              CreateButton(
                icon: Icons.add,
                text: "Create",
                height: 25,
                width: 100,
                onPressed: () {},
              ),
            ],
          ),
          const SizedBox(width: 20),
          ListTile(
            title: const CustomButtonText("project_plan"),
            trailing: const Icon(Icons.segment_outlined),
          ),
        ],
      ),
    );
  }
}
