sealed class Failure implements Exception {
  final String? message;
  const Failure([this.message]);
}

/// Shared System Failures
class NetworkFailure extends Failure {
  const NetworkFailure([super.message]);
}

class ServerFailure extends Failure {
  const ServerFailure([super.message]);
}

class UnknownFailure extends Failure {
  const UnknownFailure([super.message]);
}

/// Session/Profile Failures
class AccountUpdateFailure extends Failure {
  const AccountUpdateFailure([super.message]);
}

sealed class AuthFailure extends Failure {
  const AuthFailure([super.message]);
}

sealed class AuthInputFailure extends AuthFailure {
  const AuthInputFailure([super.message]);
}

class InvalidEmailFailure extends AuthInputFailure {
  const InvalidEmailFailure([super.message]);
}

class WeakPasswordFailure extends AuthInputFailure {
  const WeakPasswordFailure([super.message]);
}

class InvalidNameFailure extends AuthInputFailure {
  const InvalidNameFailure([super.message]);
}

sealed class AuthBackendFailure extends AuthFailure {
  const AuthBackendFailure([super.message]);
}

class InvalidCredentialsFailure extends AuthBackendFailure {
  const InvalidCredentialsFailure([super.message]);
}

class UserNotFoundFailure extends AuthBackendFailure {
  const UserNotFoundFailure([super.message]);
}

class EmailAlreadyInUseFailure extends AuthBackendFailure {
  const EmailAlreadyInUseFailure([super.message]);
}

sealed class AuthSystemFailure extends AuthFailure {
  const AuthSystemFailure([super.message]);
}

class RateLimitFailure extends AuthSystemFailure {
  const RateLimitFailure([super.message]);
}

class UnsupportedAuthOperationFailure extends AuthSystemFailure {
  const UnsupportedAuthOperationFailure([super.message]);
}

class UnknownAuthFailure extends AuthSystemFailure {
  const UnknownAuthFailure([super.message]);
}

/// Workspace Failures
sealed class WorkspaceFailure extends Failure {
  const WorkspaceFailure([super.message]);
}

class WorkspaceNotFoundFailure extends WorkspaceFailure {
  const WorkspaceNotFoundFailure([super.message]);
}

class WorkspacePermissionDeniedFailure extends WorkspaceFailure {
  const WorkspacePermissionDeniedFailure([super.message]);
}

class CollectionNotFoundFailure extends WorkspaceFailure {
  const CollectionNotFoundFailure([super.message]);
}

class FlowNotFoundFailure extends WorkspaceFailure {
  const FlowNotFoundFailure([super.message]);
}

class MemberAlreadyExistsFailure extends WorkspaceFailure {
  const MemberAlreadyExistsFailure([super.message]);
}

class MemberNotFoundFailure extends WorkspaceFailure {
  const MemberNotFoundFailure([super.message]);
}

class UnknownWorkspaceFailure extends WorkspaceFailure {
  const UnknownWorkspaceFailure([super.message]);
}

/// Editor Failures
sealed class EditorFailure extends Failure {
  const EditorFailure([super.message]);
}

class ExecutionFailure extends EditorFailure {
  const ExecutionFailure([super.message]);
}

class SaveFailure extends EditorFailure {
  const SaveFailure([super.message]);
}

class EditorNetworkFailure extends EditorFailure {
  const EditorNetworkFailure([super.message]);
}

class UnknownEditorFailure extends EditorFailure {
  const UnknownEditorFailure([super.message]);
}
