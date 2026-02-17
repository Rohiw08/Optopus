// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(homeService)
final homeServiceProvider = HomeServiceProvider._();

final class HomeServiceProvider
    extends $FunctionalProvider<HomeService, HomeService, HomeService>
    with $Provider<HomeService> {
  HomeServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'homeServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$homeServiceHash();

  @$internal
  @override
  $ProviderElement<HomeService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  HomeService create(Ref ref) {
    return homeService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(HomeService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<HomeService>(value),
    );
  }
}

String _$homeServiceHash() => r'89fd69332db3f3f89c0d5c3a38ee67d651daff8c';
