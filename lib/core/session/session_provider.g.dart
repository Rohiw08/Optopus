// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(_sessionRemoteDataSource)
final _sessionRemoteDataSourceProvider = _SessionRemoteDataSourceProvider._();

final class _SessionRemoteDataSourceProvider
    extends
        $FunctionalProvider<
          SessionRemoteDataSource,
          SessionRemoteDataSource,
          SessionRemoteDataSource
        >
    with $Provider<SessionRemoteDataSource> {
  _SessionRemoteDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'_sessionRemoteDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$_sessionRemoteDataSourceHash();

  @$internal
  @override
  $ProviderElement<SessionRemoteDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SessionRemoteDataSource create(Ref ref) {
    return _sessionRemoteDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SessionRemoteDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SessionRemoteDataSource>(value),
    );
  }
}

String _$_sessionRemoteDataSourceHash() =>
    r'6758c4fffc271314ef65cf47a05d6a58bdbb337b';

@ProviderFor(_sessionService)
final _sessionServiceProvider = _SessionServiceProvider._();

final class _SessionServiceProvider
    extends $FunctionalProvider<SessionService, SessionService, SessionService>
    with $Provider<SessionService> {
  _SessionServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'_sessionServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$_sessionServiceHash();

  @$internal
  @override
  $ProviderElement<SessionService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SessionService create(Ref ref) {
    return _sessionService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SessionService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SessionService>(value),
    );
  }
}

String _$_sessionServiceHash() => r'b6c8ab10a62ed98f8330cfcebdad5176b8729cb2';

@ProviderFor(session)
final sessionProvider = SessionProvider._();

final class SessionProvider
    extends
        $FunctionalProvider<
          AsyncValue<AccountEntity?>,
          AccountEntity?,
          Stream<AccountEntity?>
        >
    with $FutureModifier<AccountEntity?>, $StreamProvider<AccountEntity?> {
  SessionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sessionProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sessionHash();

  @$internal
  @override
  $StreamProviderElement<AccountEntity?> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<AccountEntity?> create(Ref ref) {
    return session(ref);
  }
}

String _$sessionHash() => r'0499aa14bf63d5ab250bc0852faae2887cf8e88f';

@ProviderFor(profile)
final profileProvider = ProfileFamily._();

final class ProfileProvider
    extends
        $FunctionalProvider<
          AsyncValue<AccountEntity?>,
          AccountEntity?,
          Stream<AccountEntity?>
        >
    with $FutureModifier<AccountEntity?>, $StreamProvider<AccountEntity?> {
  ProfileProvider._({
    required ProfileFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'profileProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$profileHash();

  @override
  String toString() {
    return r'profileProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<AccountEntity?> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<AccountEntity?> create(Ref ref) {
    final argument = this.argument as String;
    return profile(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is ProfileProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$profileHash() => r'ad4dec41f1b2fa58ec3091a0fa03c3d870943de9';

final class ProfileFamily extends $Family
    with $FunctionalFamilyOverride<Stream<AccountEntity?>, String> {
  ProfileFamily._()
    : super(
        retry: null,
        name: r'profileProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ProfileProvider call(String userId) =>
      ProfileProvider._(argument: userId, from: this);

  @override
  String toString() => r'profileProvider';
}
