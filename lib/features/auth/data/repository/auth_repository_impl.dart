import 'dart:io';

import 'package:optopus/core/domain/failures/failure.dart';
import 'package:optopus/features/auth/data/data_sources/email_auth_data_source.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:optopus/features/auth/data/data_sources/google_auth_data_source.dart';
import 'package:optopus/features/auth/domain/enums/auth_mode_enum.dart';
import 'package:optopus/features/auth/domain/repositories/auth_repository.dart';
import 'package:optopus/features/auth/domain/inputs/auth_method.dart';

class AuthRepositoryImpl implements AuthRepository {
  final EmailAuthDataSource email;
  final GoogleAuthDataSource google;

  AuthRepositoryImpl({required this.email, required this.google});

  @override
  Future<void> perform(AuthAction action, {AuthMethod? method}) async {
    try {
      await switch ((action, method)) {
        (
          AuthAction.signInEmail,
          EmailAuth(
            email: final emailAddress,
            password: final password,
            name: null,
          ),
        ) =>
          email.signIn(emailAddress, password),

        (
          AuthAction.signUpEmail,
          EmailAuth(
            email: final emailAddress,
            password: final password,
            name: final name,
          ),
        ) =>
          email.signUp(emailAddress, password, name!),
        (AuthAction.resetPassword, EmailAuth(email: final emailAddress)) =>
          email.sendPasswordResetEmail(emailAddress),
        (AuthAction.signInGoogle, GoogleAuth()) => google.signIn(),
        (AuthAction.signOut, _) => _signOutGlobal(),
        _ => throw const UnsupportedAuthOperationFailure(),
      };
    } on AuthException catch (e) {
      if (e.statusCode == '429') {
        throw const RateLimitFailure();
      }
      if (e.statusCode != null &&
          int.tryParse(e.statusCode!) != null &&
          int.parse(e.statusCode!) >= 500) {
        throw const ServerFailure();
      }

      throw switch (e.code) {
        'email_exists' ||
        'user_already_exists' => const EmailAlreadyInUseFailure(),
        'invalid_credentials' ||
        'invalid_grant' => const InvalidCredentialsFailure(),
        'user_not_found' => const UserNotFoundFailure(),
        'weak_password' => const WeakPasswordFailure(),
        _ => const UnknownAuthFailure(),
      };
    } on SocketException {
      throw const NetworkFailure();
    } catch (_) {
      throw const UnknownAuthFailure();
    }
  }

  Future<void> _signOutGlobal() async {
    await email.signOut();
  }
}
