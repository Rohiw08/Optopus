import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:optopus/core/utils/snack_bar.dart';
import 'package:optopus/core/widgets/custom_outlined_widget.dart';
import 'package:optopus/features/auth/domain/enums/auth_mode_enum.dart';
import 'package:optopus/features/auth/domain/state/auth_state.dart';
import 'package:optopus/features/auth/presentation/controller/auth_controller.dart';
import 'package:optopus/features/auth/presentation/controller/auth_view_provider.dart';
import 'package:optopus/core/utils/failure_utils.dart';

import 'package:optopus/core/widgets/redirect_text.dart';
import 'package:optopus/core/widgets/custom_textfield_widget.dart';

class SignUpWidget extends ConsumerStatefulWidget {
  const SignUpWidget({super.key});

  @override
  ConsumerState<SignUpWidget> createState() => SignUpWidgetState();
}

class SignUpWidgetState extends ConsumerState<SignUpWidget> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void _signUp() async {
    await ref
        .read(authControllerProvider.notifier)
        .signUpWithEmail(
          email: emailController.text,
          password: passwordController.text,
        );
  }

  void continueWithGoogle() {
    ref.read(authControllerProvider.notifier).signInWithGoogle();
  }

  void toggleSignIn() {
    ref.read(authViewProvider.notifier).set(0);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final authState = ref.watch(authControllerProvider);
    final isEmailLoading =
        authState is AuthLoading && authState.action == AuthAction.signUpEmail;
    final isGoogleLoading =
        authState is AuthLoading && authState.action == AuthAction.signInGoogle;
    final isLoading = authState is AuthLoading;

    ref.listen(authControllerProvider, (previous, next) {
      if (next is AuthError) {
        showSnackBar(context, next.failure.userMessage);
      } else if (next is AuthSuccess) {
        showSnackBar(context, "Account created successfully!");
      }
    });

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 15,
        children: [
          Text(
            "Give your business \nan extra hand. \nOr eight.",
            style: theme.textTheme.headlineMedium!.copyWith(
              fontWeight: FontWeight.bold,
              height: 1.2,
            ),
          ),
          CustomTextfield(
            hintText: "Email",
            width: 293,
            controller: emailController,
          ),
          CustomTextfield(
            hintText: "Password",
            width: 293,
            controller: passwordController,
            isPassword: true,
          ),
          CustomTextfield(
            hintText: "Confirm Password",
            width: 293,
            controller: confirmPasswordController,
            isPassword: true,
          ),
          CustomOutlinedButton(
            text: "Continue with Email",
            textColor: theme.colorScheme.onPrimary,
            width: 300,
            backgroundColor: theme.colorScheme.primary,
            hoverBackgroundColor: theme.colorScheme.primary.withValues(
              alpha: 0.8,
            ),
            hoverBorderColor: theme.colorScheme.primary.withValues(alpha: 0.8),
            borderColor: theme.colorScheme.primary,
            isLoading: isEmailLoading,
            onPressed: isLoading ? () {} : _signUp,
          ),
          SizedBox(height: 2),
          SizedBox(
            width: 300,
            child: Center(
              child: AuthToggleText(
                text1: "Already have an account? ",
                text2: "Sign In",
                fontSize: 14,
                onTapText2: toggleSignIn,
              ),
            ),
          ),
          SizedBox(height: 2),
          CustomOutlinedButton(
            text: "Continue with Google",
            width: 300,
            isLoading: isGoogleLoading,
            onPressed: isLoading ? () {} : continueWithGoogle,
          ),
        ],
      ),
    );
  }
}
