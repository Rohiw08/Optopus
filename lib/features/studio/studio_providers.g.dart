// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'studio_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(studioService)
final studioServiceProvider = StudioServiceProvider._();

final class StudioServiceProvider
    extends $FunctionalProvider<StudioService, StudioService, StudioService>
    with $Provider<StudioService> {
  StudioServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'studioServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$studioServiceHash();

  @$internal
  @override
  $ProviderElement<StudioService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  StudioService create(Ref ref) {
    return studioService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(StudioService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<StudioService>(value),
    );
  }
}

String _$studioServiceHash() => r'96284beb86fbbdd875e3b8d851217665429795c8';
