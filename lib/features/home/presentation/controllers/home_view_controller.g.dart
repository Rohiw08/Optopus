// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_view_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(HomeViewController)
final homeViewControllerProvider = HomeViewControllerProvider._();

final class HomeViewControllerProvider
    extends $NotifierProvider<HomeViewController, HomeViewState> {
  HomeViewControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'homeViewControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$homeViewControllerHash();

  @$internal
  @override
  HomeViewController create() => HomeViewController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(HomeViewState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<HomeViewState>(value),
    );
  }
}

String _$homeViewControllerHash() =>
    r'd1fc99915e0b8831e6387b986c66fcb6e432c959';

abstract class _$HomeViewController extends $Notifier<HomeViewState> {
  HomeViewState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<HomeViewState, HomeViewState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<HomeViewState, HomeViewState>,
              HomeViewState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
