// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'selected_template_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SelectedTemplateController)
final selectedTemplateControllerProvider =
    SelectedTemplateControllerProvider._();

final class SelectedTemplateControllerProvider
    extends $NotifierProvider<SelectedTemplateController, int> {
  SelectedTemplateControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'selectedTemplateControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$selectedTemplateControllerHash();

  @$internal
  @override
  SelectedTemplateController create() => SelectedTemplateController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$selectedTemplateControllerHash() =>
    r'ca5e3db4a7adf97a73f303b84c049909893c8062';

abstract class _$SelectedTemplateController extends $Notifier<int> {
  int build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<int, int>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<int, int>,
              int,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
