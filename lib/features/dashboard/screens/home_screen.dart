import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:optopus/core/responsive/layouts/desktop_layout.dart';
import 'package:optopus/core/responsive/layouts/mobile_layout.dart';
import 'package:optopus/core/responsive/layouts/tab_layout.dart';
import 'package:optopus/core/responsive/responsive.dart';
import 'package:optopus/app/presentation/app_bar.dart';
import 'package:optopus/features/dashboard/widgets/app_updates_bar.dart';
import 'package:optopus/features/dashboard/widgets/home_redirect_bar.dart';
import 'package:optopus/features/workspace/presentation/sections/workspace_list_section.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBarWidget(),
      body: Responsive(
        // TODO: Implement mobile layout later
        mobileLayout: MobileLayout(child: Placeholder()),
        tabLayout: TabLayout(
          child: Row(
            children: [
              HomeRedirectBar(),
              Expanded(flex: 2, child: Container()),
              Expanded(flex: 1, child: AppUpdatesBar()),
            ],
          ),
        ),
        desktopLayout: DesktopLayout(
          child: Row(
            children: [
              HomeRedirectBar(),
              Expanded(
                flex: 2,
                child: Column(children: [WorkspaceListSection()]),
              ),
              Expanded(flex: 1, child: AppUpdatesBar()),
            ],
          ),
        ),
      ),
    );
  }
}
