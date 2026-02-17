// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

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

String _$_sessionServiceHash() => r'9fde21037c989433202a18e550435e5ad2cff581';

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

String _$sessionHash() => r'492249b9b3c1de4f34e1ae7c72be70043041d5da';
