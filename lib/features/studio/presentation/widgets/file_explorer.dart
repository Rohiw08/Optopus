import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:optopus/core/widgets/create_button.dart';
import 'package:optopus/core/widgets/search_bar.dart';
import 'package:optopus/core/widgets/sidebar_content_bar.dart';

import 'package:optopus/features/collections/presentation/widgets/collection_list.dart';
import 'package:optopus/features/collections/presentation/controllers/collection_list_controller.dart';

class StudioFileExplorer extends ConsumerWidget {
  final double width;
  final String workspaceId;

  const StudioFileExplorer({
    super.key,
    required this.width,
    required this.workspaceId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
              Expanded(
                flex: 2,
                child: CustomSearchBar(
                  height: 25,
                  width: double.infinity,
                  hintText: "Search",
                  onChanged: (value) {
                    ref
                        .read(collectionSearchQueryProvider.notifier)
                        .setQuery(value);
                  },
                ),
              ),
              const SizedBox(width: 5),
              CreateButton(
                icon: Icons.add,
                text: width > 220 ? "Create" : "",
                height: 25,
                width: width > 220 ? 100 : 30,
                onPressed: () {
                  ref.read(isCreatingCollectionProvider.notifier).set(true);
                },
              ),
              const SizedBox(width: 5),
            ],
          ),
          const SizedBox(width: 20),
          Expanded(child: CollectionList(workspaceId: workspaceId)),
        ],
      ),
    );
  }
}
