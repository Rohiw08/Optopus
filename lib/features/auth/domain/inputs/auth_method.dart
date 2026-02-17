sealed class AuthMethod {
  const AuthMethod();
}

class EmailAuth extends AuthMethod {
  final String email;
  final String password;
  final String? name; // only for signUp
  const EmailAuth.signIn(this.email, this.password) : name = null;
  const EmailAuth.signUp(this.email, this.password, this.name);
  const EmailAuth.resetPassword(this.email) : password = '', name = null;
}

class GoogleAuth extends AuthMethod {
  const GoogleAuth();
}
