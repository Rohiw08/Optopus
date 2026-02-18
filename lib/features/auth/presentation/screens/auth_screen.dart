import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:optopus/core/responsive/layouts/desktop_layout.dart';
import 'package:optopus/core/responsive/layouts/mobile_layout.dart';
import 'package:optopus/core/responsive/layouts/tab_layout.dart';
import 'package:optopus/core/responsive/responsive.dart';
import 'package:optopus/features/auth/presentation/controller/auth_view_provider.dart';
import 'package:optopus/core/widgets/animation_wrapper.dart';
import 'package:optopus/features/auth/presentation/widgets/auth_branding_panel.dart';
import 'package:optopus/core/widgets/windows_navigation.dart';
import 'package:optopus/features/auth/presentation/widgets/signin_widget.dart';
import 'package:optopus/features/auth/presentation/widgets/signup_widget.dart';
import 'package:optopus/features/auth/presentation/widgets/reset_password_widget.dart';

class AuthScreen extends ConsumerWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authView = ref.watch(authViewProvider);

    return Scaffold(
      appBar: WindowsNavigation(),
      body: Responsive(
        mobileLayout: MobileLayout(
          child: AnimationWrapper(
            index: authView,
            widgets: const [
              SignInWidget(),
              SignUpWidget(),
              ResetPasswordWidget(),
            ],
            direction: Direction.rightToLeft,
          ),
        ),
        tabLayout: TabLayout(
          child: Row(
            children: [
              Expanded(child: AuthBrandingPanel()),
              Expanded(
                child: AnimationWrapper(
                  index: authView,
                  widgets: const [
                    SignInWidget(),
                    SignUpWidget(),
                    ResetPasswordWidget(),
                  ],
                  direction: Direction.rightToLeft,
                ),
              ),
            ],
          ),
        ),
        desktopLayout: DesktopLayout(
          child: Row(
            children: [
              Expanded(child: AuthBrandingPanel()),
              Expanded(
                child: AnimationWrapper(
                  index: authView,
                  widgets: const [
                    SignInWidget(),
                    SignUpWidget(),
                    ResetPasswordWidget(),
                  ],
                  direction: Direction.rightToLeft,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
