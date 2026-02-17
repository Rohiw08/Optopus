import 'package:flutter/material.dart';
import 'package:optopus/core/utils/snack_bar.dart';
import 'package:optopus/core/widgets/custom_outlined_widget.dart';
import 'package:optopus/features/auth/presentation/controller/reset_cooldown_provider.dart';
import 'package:optopus/core/utils/failure_utils.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:optopus/features/auth/domain/enums/auth_mode_enum.dart';
import 'package:optopus/features/auth/domain/state/auth_state.dart';
import 'package:optopus/features/auth/presentation/controller/auth_controller.dart';
import 'package:optopus/features/auth/presentation/controller/auth_view_provider.dart';
import 'package:optopus/core/widgets/custom_textfield_widget.dart';

class ResetPasswordWidget extends ConsumerStatefulWidget {
  const ResetPasswordWidget({super.key});

  @override
  ConsumerState<ResetPasswordWidget> createState() =>
      ResetPasswordWidgetState();
}

class ResetPasswordWidgetState extends ConsumerState<ResetPasswordWidget> {
  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  void resetPassword() {
    ref
        .read(authControllerProvider.notifier)
        .sendPasswordResetEmail(email: emailController.text);
  }

  void toggleToSignIn() {
    ref.read(authViewProvider.notifier).set(0);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final authState = ref.watch(authControllerProvider);
    final remainingSeconds = ref.watch(resetCooldownProvider);

    final isResetPasswordLoading =
        authState is AuthLoading &&
        authState.action == AuthAction.resetPassword;
    final isButtonDisabled = isResetPasswordLoading || remainingSeconds > 0;

    ref.listen(authControllerProvider, (previous, next) {
      if (next is AuthError) {
        showSnackBar(context, next.failure.userMessage);
      } else if (next is AuthSuccess) {
        if (previous is AuthLoading &&
            previous.action == AuthAction.resetPassword) {
          ref.read(resetCooldownProvider.notifier).start(30);
          showSnackBar(context, "Password reset email sent!");
        } else {
          showSnackBar(context, "Signed in successfully!");
        }
      }
    });

    return Center(
      child: SizedBox(
        width: 300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 15,
          children: [
            Text(
              "Reset Password",
              style: theme.textTheme.headlineMedium!.copyWith(
                fontWeight: FontWeight.bold,
                height: 1.2,
              ),
            ),

            CustomTextfield(
              hintText: "Email",
              width: 300,
              controller: emailController,
            ),

            CustomOutlinedButton(
              text: remainingSeconds > 0
                  ? "Resend in ${remainingSeconds}s"
                  : "Send Reset Password Mail",
              textColor: theme.colorScheme.onPrimary,
              width: 300,
              backgroundColor: isButtonDisabled
                  ? theme.colorScheme.primary.withValues(alpha: 0.5)
                  : theme.colorScheme.primary,
              hoverBackgroundColor: isButtonDisabled
                  ? theme.colorScheme.primary.withValues(alpha: 0.5)
                  : theme.colorScheme.primary.withValues(alpha: 0.8),
              hoverBorderColor: isButtonDisabled
                  ? theme.colorScheme.primary.withValues(alpha: 0.5)
                  : theme.colorScheme.primary.withValues(alpha: 0.8),
              borderColor: isButtonDisabled
                  ? theme.colorScheme.primary.withValues(alpha: 0.5)
                  : theme.colorScheme.primary,
              isLoading: isResetPasswordLoading,
              onPressed: isButtonDisabled ? () {} : resetPassword,
            ),
            CustomOutlinedButton(
              text: "Back to Sign In",
              width: 300,
              onPressed: toggleToSignIn,
            ),
          ],
        ),
      ),
    );
  }
}
