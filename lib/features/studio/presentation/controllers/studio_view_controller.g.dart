// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'studio_view_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(StudioViewController)
final studioViewControllerProvider = StudioViewControllerProvider._();

final class StudioViewControllerProvider
    extends $NotifierProvider<StudioViewController, StudioViewState> {
  StudioViewControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'studioViewControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$studioViewControllerHash();

  @$internal
  @override
  StudioViewController create() => StudioViewController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(StudioViewState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<StudioViewState>(value),
    );
  }
}

String _$studioViewControllerHash() =>
    r'6d696889e837ad2a88f157aff51aa0bea60ba1b4';

abstract class _$StudioViewController extends $Notifier<StudioViewState> {
  StudioViewState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<StudioViewState, StudioViewState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<StudioViewState, StudioViewState>,
              StudioViewState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
