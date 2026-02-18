import 'package:flutter/material.dart';
import 'package:optopus/core/utils/snack_bar.dart';
import 'package:optopus/core/utils/failure_utils.dart';
import 'package:optopus/core/widgets/custom_outlined_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:optopus/features/auth/domain/enums/auth_mode_enum.dart';
import 'package:optopus/features/auth/domain/state/auth_state.dart';
import 'package:optopus/features/auth/presentation/controller/auth_controller.dart';
import 'package:optopus/core/widgets/redirect_text.dart';
import 'package:optopus/core/widgets/custom_textfield_widget.dart';
import 'package:optopus/features/auth/presentation/controller/auth_view_provider.dart';

class SignInWidget extends ConsumerStatefulWidget {
  const SignInWidget({super.key});

  @override
  ConsumerState<SignInWidget> createState() => SignInWidgetState();
}

class SignInWidgetState extends ConsumerState<SignInWidget> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void signIn() {
    ref
        .read(authControllerProvider.notifier)
        .signInWithEmail(
          email: emailController.text,
          password: passwordController.text,
        );
  }

  void continueWithGoogle() {
    ref.read(authControllerProvider.notifier).signInWithGoogle();
  }

  void toggleSignUp() {
    ref.read(authViewProvider.notifier).set(1);
  }

  void toggleResetPassword() {
    ref.read(authViewProvider.notifier).set(2);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final authState = ref.watch(authControllerProvider);
    final isEmailLoading =
        authState is AuthLoading && authState.action == AuthAction.signInEmail;
    final isGoogleLoading =
        authState is AuthLoading && authState.action == AuthAction.signInGoogle;
    final isLoading = authState is AuthLoading;

    ref.listen(authControllerProvider, (previous, next) {
      if (next is AuthError) {
        showSnackBar(context, next.failure.userMessage);
      } else if (next is AuthSuccess) {
        showSnackBar(context, "Signed in successfully!");
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
          SizedBox(
            width: 300,
            child: Align(
              alignment: Alignment.centerLeft,
              child: AuthToggleText(
                text1: "Forgot your password? ",
                text2: "Reset Password",
                fontSize: 14,
                onTapText2: toggleResetPassword,
              ),
            ),
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
            onPressed: isLoading ? () {} : signIn,
          ),
          SizedBox(height: 2),
          SizedBox(
            width: 300,
            child: Center(
              child: AuthToggleText(
                text1: "Don't have an account? ",
                text2: "Sign Up",
                fontSize: 14,
                onTapText2: toggleSignUp,
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
