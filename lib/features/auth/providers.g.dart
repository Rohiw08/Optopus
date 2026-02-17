// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(emailAuthDataSource)
final emailAuthDataSourceProvider = EmailAuthDataSourceProvider._();

final class EmailAuthDataSourceProvider
    extends
        $FunctionalProvider<
          EmailAuthDataSource,
          EmailAuthDataSource,
          EmailAuthDataSource
        >
    with $Provider<EmailAuthDataSource> {
  EmailAuthDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'emailAuthDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$emailAuthDataSourceHash();

  @$internal
  @override
  $ProviderElement<EmailAuthDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  EmailAuthDataSource create(Ref ref) {
    return emailAuthDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(EmailAuthDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<EmailAuthDataSource>(value),
    );
  }
}

String _$emailAuthDataSourceHash() =>
    r'7d29380f460a15cfee6c4c170a4fde6dc80bd8db';

@ProviderFor(googleAuthDataSource)
final googleAuthDataSourceProvider = GoogleAuthDataSourceProvider._();

final class GoogleAuthDataSourceProvider
    extends
        $FunctionalProvider<
          GoogleAuthDataSource,
          GoogleAuthDataSource,
          GoogleAuthDataSource
        >
    with $Provider<GoogleAuthDataSource> {
  GoogleAuthDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'googleAuthDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$googleAuthDataSourceHash();

  @$internal
  @override
  $ProviderElement<GoogleAuthDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GoogleAuthDataSource create(Ref ref) {
    return googleAuthDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GoogleAuthDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GoogleAuthDataSource>(value),
    );
  }
}

String _$googleAuthDataSourceHash() =>
    r'1429874a5e728fb225a576382dc50c03a7259490';

@ProviderFor(authRepository)
final authRepositoryProvider = AuthRepositoryProvider._();

final class AuthRepositoryProvider
    extends $FunctionalProvider<AuthRepository, AuthRepository, AuthRepository>
    with $Provider<AuthRepository> {
  AuthRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authRepositoryHash();

  @$internal
  @override
  $ProviderElement<AuthRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AuthRepository create(Ref ref) {
    return authRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AuthRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AuthRepository>(value),
    );
  }
}

String _$authRepositoryHash() => r'ec7955b7942c079571c454c4ce1a5af8f147946f';

@ProviderFor(authService)
final authServiceProvider = AuthServiceProvider._();

final class AuthServiceProvider
    extends $FunctionalProvider<AuthService, AuthService, AuthService>
    with $Provider<AuthService> {
  AuthServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authServiceHash();

  @$internal
  @override
  $ProviderElement<AuthService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AuthService create(Ref ref) {
    return authService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AuthService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AuthService>(value),
    );
  }
}

String _$authServiceHash() => r'198a0028c77fd366d55fd82a73db80ff6f156466';
