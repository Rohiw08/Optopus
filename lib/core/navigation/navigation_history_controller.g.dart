// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'navigation_history_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(NavigationHistoryController)
final navigationHistoryControllerProvider =
    NavigationHistoryControllerProvider._();

final class NavigationHistoryControllerProvider
    extends $NotifierProvider<NavigationHistoryController, NavigationHistory> {
  NavigationHistoryControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'navigationHistoryControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$navigationHistoryControllerHash();

  @$internal
  @override
  NavigationHistoryController create() => NavigationHistoryController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(NavigationHistory value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<NavigationHistory>(value),
    );
  }
}

String _$navigationHistoryControllerHash() =>
    r'eb63c42cabe7d4d67ff0be3bfe77a02a7b0fde4b';

abstract class _$NavigationHistoryController
    extends $Notifier<NavigationHistory> {
  NavigationHistory build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<NavigationHistory, NavigationHistory>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<NavigationHistory, NavigationHistory>,
              NavigationHistory,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
