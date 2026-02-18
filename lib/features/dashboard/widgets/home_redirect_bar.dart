import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:optopus/core/widgets/divider_widget.dart';
import 'package:optopus/features/dashboard/widgets/home_navigation_widget.dart';
import 'package:optopus/features/dashboard/widgets/redirects_widget.dart';
import 'package:optopus/features/profile/presentation/home_profile_widget.dart';

class HomeRedirectBar extends ConsumerWidget {
  const HomeRedirectBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context).colorScheme;

    return Container(
      width: 320,
      height: double.infinity,
      color: theme.surface,

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 40),
          HomeProfileWidget(),
          SizedBox(height: 40),
          DividerWidget(),
          SizedBox(height: 20),
          HomeNavigationWidget(),
          DividerWidget(),
          SizedBox(height: 20),
          RedirectsWidget(),
        ],
      ),
    );
  }
}
