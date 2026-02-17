/// Sealed class representing failures in the session feature.
sealed class SessionFailure {
  final String message;
  const SessionFailure(this.message);
}

class SessionNetworkFailure extends SessionFailure {
  const SessionNetworkFailure(super.message);
}

class SessionUnknownFailure extends SessionFailure {
  const SessionUnknownFailure(super.message);
}
