// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'right_panel_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Controls which panel (if any) is shown in the right sidebar.

@ProviderFor(RightPanelController)
final rightPanelControllerProvider = RightPanelControllerProvider._();

/// Controls which panel (if any) is shown in the right sidebar.
final class RightPanelControllerProvider
    extends $NotifierProvider<RightPanelController, RightPanelType?> {
  /// Controls which panel (if any) is shown in the right sidebar.
  RightPanelControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'rightPanelControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$rightPanelControllerHash();

  @$internal
  @override
  RightPanelController create() => RightPanelController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RightPanelType? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RightPanelType?>(value),
    );
  }
}

String _$rightPanelControllerHash() =>
    r'4dc93b222f484bec6d3f42c8db1b5a6606cd4279';

/// Controls which panel (if any) is shown in the right sidebar.

abstract class _$RightPanelController extends $Notifier<RightPanelType?> {
  RightPanelType? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<RightPanelType?, RightPanelType?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<RightPanelType?, RightPanelType?>,
              RightPanelType?,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
