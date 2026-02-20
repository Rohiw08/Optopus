// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'editor_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Tracks only whether a save is in-flight, independently of the run state.

@ProviderFor(IsSaving)
final isSavingProvider = IsSavingProvider._();

/// Tracks only whether a save is in-flight, independently of the run state.
final class IsSavingProvider extends $NotifierProvider<IsSaving, bool> {
  /// Tracks only whether a save is in-flight, independently of the run state.
  IsSavingProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'isSavingProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$isSavingHash();

  @$internal
  @override
  IsSaving create() => IsSaving();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$isSavingHash() => r'f768b8e3382a5182d37c2f418fccef331dbf10dc';

/// Tracks only whether a save is in-flight, independently of the run state.

abstract class _$IsSaving extends $Notifier<bool> {
  bool build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<bool, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<bool, bool>,
              bool,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(EditorController)
final editorControllerProvider = EditorControllerProvider._();

final class EditorControllerProvider
    extends
        $NotifierProvider<EditorController, AsyncValue<Map<String, dynamic>?>> {
  EditorControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'editorControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$editorControllerHash();

  @$internal
  @override
  EditorController create() => EditorController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<Map<String, dynamic>?> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<Map<String, dynamic>?>>(
        value,
      ),
    );
  }
}

String _$editorControllerHash() => r'd657099087b09349e2a77b583d05c1bebcb67773';

abstract class _$EditorController
    extends $Notifier<AsyncValue<Map<String, dynamic>?>> {
  AsyncValue<Map<String, dynamic>?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<Map<String, dynamic>?>,
              AsyncValue<Map<String, dynamic>?>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<Map<String, dynamic>?>,
                AsyncValue<Map<String, dynamic>?>
              >,
              AsyncValue<Map<String, dynamic>?>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
