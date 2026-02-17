import 'package:optopus/core/domain/failures/failure.dart';

extension FailureX on Failure {
  String get userMessage {
    return switch (this) {
      // Shared System Failures
      NetworkFailure() => "No internet connection.",
      ServerFailure() => "Server is currently down. Try again later.",

      // Auth Specific Failures
      InvalidEmailFailure() => "Please enter a valid email address.",
      WeakPasswordFailure() => "Password must be at least 6 characters.",
      InvalidNameFailure() => "Please enter a valid name.",
      UserNotFoundFailure() => "No user found with this email.",
      InvalidCredentialsFailure() => "Invalid email or password.",
      EmailAlreadyInUseFailure() => "Email is already in use.",
      RateLimitFailure() => "Too many requests. Please try again later.",

      // Session/Profile Specific Failures
      AccountUpdateFailure() => "Failed to update your preferences.",

      _ => "An unexpected error occurred.",
    };
  }
}
