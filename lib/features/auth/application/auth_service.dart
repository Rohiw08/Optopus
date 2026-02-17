import 'package:optopus/core/domain/failures/failure.dart';
import 'package:optopus/features/auth/domain/enums/auth_mode_enum.dart';
import 'package:optopus/features/auth/domain/inputs/auth_method.dart';
import 'package:optopus/features/auth/domain/repositories/auth_repository.dart';

class AuthService {
  final AuthRepository _repository;

  AuthService(this._repository);

  Future<void> perform(AuthAction action, {AuthMethod? method}) async {
    final validatedMethod = _validate(action, method);

    try {
      await _repository.perform(action, method: validatedMethod);
    } on AuthFailure {
      rethrow;
    } catch (e) {
      throw const UnknownAuthFailure();
    }
  }

  AuthMethod? _validate(AuthAction action, AuthMethod? method) {
    if (action != AuthAction.signOut && method == null) {
      throw const UnsupportedAuthOperationFailure();
    }

    switch ((action, method)) {
      case (AuthAction.signInEmail, EmailAuth(:final email, :final password)):
        _validateEmail(email);
        _validatePassword(password);
        return method;

      case (
        AuthAction.signUpEmail,
        EmailAuth(:final email, :final password, :final name),
      ):
        _validateEmail(email);
        _validatePassword(password);

        final validName = name == null || name.trim().isEmpty
            ? email.split('@').first
            : name;

        _validateName(validName);

        if (name != validName) {
          return EmailAuth.signUp(email, password, validName);
        }
        return method;

      case (AuthAction.signInGoogle, GoogleAuth()):
        return method;

      case (AuthAction.resetPassword, EmailAuth(:final email)):
        _validateEmail(email);
        return method;

      case (AuthAction.signOut, _):
        return method;

      default:
        throw const UnsupportedAuthOperationFailure();
    }
  }

  void _validateEmail(String email) {
    final trimmed = email.trim();
    if (!trimmed.contains('@')) {
      throw const InvalidEmailFailure();
    }
  }

  void _validatePassword(String password) {
    if (password.length < 6) {
      throw const WeakPasswordFailure();
    }
  }

  void _validateName(String? name) {
    if (name == null || name.trim().isEmpty) {
      throw const InvalidNameFailure();
    }
  }
}
