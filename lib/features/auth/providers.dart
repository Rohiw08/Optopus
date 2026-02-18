import 'package:optopus/core/services/supabase_service.dart';
import 'package:optopus/features/auth/application/auth_service.dart';
import 'package:optopus/features/auth/data/data_sources/email_auth_data_source.dart';
import 'package:optopus/features/auth/data/data_sources/google_auth_data_source.dart';
import 'package:optopus/features/auth/data/repository/auth_repository_impl.dart';
import 'package:optopus/features/auth/domain/repositories/auth_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'providers.g.dart';

@riverpod
EmailAuthDataSource _emailAuthDataSource(Ref ref) {
  return EmailAuthDataSource(ref.read(supabaseClientProvider));
}

@riverpod
GoogleAuthDataSource _googleAuthDataSource(Ref ref) {
  return GoogleAuthDataSource(ref.read(supabaseClientProvider));
}

@riverpod
AuthRepository _authRepository(Ref ref) {
  return AuthRepositoryImpl(
    email: ref.read(_emailAuthDataSourceProvider),
    google: ref.read(_googleAuthDataSourceProvider),
  );
}

@riverpod
AuthService authService(Ref ref) {
  return AuthService(ref.read(_authRepositoryProvider));
}
