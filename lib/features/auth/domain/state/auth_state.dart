import 'package:optopus/core/domain/failures/failure.dart';
import 'package:optopus/features/auth/domain/enums/auth_mode_enum.dart';

sealed class AuthState {
  const AuthState();
}

class AuthIdle extends AuthState {
  const AuthIdle();
}

class AuthLoading extends AuthState {
  final AuthAction action;
  const AuthLoading(this.action);
}

class AuthError extends AuthState {
  final AuthFailure failure;
  const AuthError(this.failure);
}

class AuthSuccess extends AuthState {
  const AuthSuccess();
}
