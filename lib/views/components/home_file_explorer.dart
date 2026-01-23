import 'package:flutter/material.dart';
import 'package:optopus/core/common/create_button.dart';
import 'package:optopus/core/common/search_bar.dart';
import 'package:optopus/core/common/sidebar_content_bar.dart';
import 'package:optopus/core/utils/button_text.dart';

class HomeFileExplorer extends StatelessWidget {
  final double width;
  const HomeFileExplorer({super.key, required this.width});

  @override
  Widget build(BuildContext context) {
    return SideBar(
      minWidth: 200,
      width: width,
      height: double.infinity,
      border: Border(
        right: BorderSide(color: Theme.of(context).dividerColor, width: 0.5),
      ),
      child: Column(
        children: [
          const SizedBox(height: 10),
          Row(
            children: [
              const SizedBox(width: 5),
              const Expanded(
                flex: 2,
                child: CustomSearchBar(
                  height: 25,
                  width: double.infinity,
                  hintText: "Search",
                ),
              ),
              const SizedBox(width: 5),
              CreateButton(
                icon: Icons.add,
                text: width > 220 ? "Create" : "",
                height: 25,
                // If width is small (<220), force small width (30), else let it expand or be fixed (80)
                width: width > 220 ? 100 : 30,
                onPressed: () {},
              ),
              const SizedBox(width: 5),
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
