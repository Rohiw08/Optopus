import 'dart:async';
import 'package:optopus/core/domain/failures/failure.dart';
import 'package:optopus/features/auth/domain/enums/auth_mode_enum.dart';
import 'package:optopus/features/auth/domain/inputs/auth_method.dart';
import 'package:optopus/features/auth/domain/state/auth_state.dart';
import 'package:optopus/features/auth/providers.dart';
import 'package:optopus/features/workspace/presentation/controllers/workspace_list_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_controller.g.dart';

@riverpod
class AuthController extends _$AuthController {
  @override
  AuthState build() => const AuthIdle();

  Future<void> signInWithEmail({
    required String email,
    required String password,
  }) async {
    state = const AuthLoading(AuthAction.signInEmail);
    try {
      await ref
          .read(authServiceProvider)
          .perform(
            AuthAction.signInEmail,
            method: EmailAuth.signIn(email, password),
          );
      state = const AuthSuccess();
    } on AuthFailure catch (e) {
      state = AuthError(e);
    }
  }

  Future<void> signUpWithEmail({
    required String email,
    required String password,
    String? name,
  }) async {
    state = const AuthLoading(AuthAction.signUpEmail);
    try {
      await ref
          .read(authServiceProvider)
          .perform(
            AuthAction.signUpEmail,
            method: EmailAuth.signUp(email, password, name),
          );
      state = const AuthSuccess();
    } on AuthFailure catch (e) {
      state = AuthError(e);
    }
  }

  Future<void> sendPasswordResetEmail({required String email}) async {
    state = const AuthLoading(AuthAction.resetPassword);
    try {
      await ref
          .read(authServiceProvider)
          .perform(
            AuthAction.resetPassword,
            method: EmailAuth.resetPassword(email),
          );
      state = const AuthSuccess();
    } on AuthFailure catch (e) {
      state = AuthError(e);
    }
  }

  Future<void> signInWithGoogle() async {
    state = const AuthLoading(AuthAction.signInGoogle);
    try {
      await ref
          .read(authServiceProvider)
          .perform(AuthAction.signInGoogle, method: const GoogleAuth());
      // For OAuth, the flow continues in the browser.
      // We set state to Idle to stop the spinner, but we don't show success yet.
      // Success will be handled by the session state change listener in the app.
      state = const AuthIdle();
    } on AuthFailure catch (e) {
      state = AuthError(e);
    }
  }

  Future<void> signOut() async {
    state = const AuthLoading(AuthAction.signOut);
    try {
      await ref.read(authServiceProvider).perform(AuthAction.signOut);

      // Invalidate workspace list and other session-dependent providers
      ref.invalidate(workspaceListControllerProvider);

      state = const AuthSuccess();
    } on AuthFailure catch (e) {
      state = AuthError(e);
    }
  }
}
