// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workspace_actions_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(WorkspaceActionsController)
final workspaceActionsControllerProvider =
    WorkspaceActionsControllerProvider._();

final class WorkspaceActionsControllerProvider
    extends $NotifierProvider<WorkspaceActionsController, AsyncValue<void>> {
  WorkspaceActionsControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'workspaceActionsControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$workspaceActionsControllerHash();

  @$internal
  @override
  WorkspaceActionsController create() => WorkspaceActionsController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<void> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<void>>(value),
    );
  }
}

String _$workspaceActionsControllerHash() =>
    r'cb96766aead307d001287d2971c1e3747860ea7a';

abstract class _$WorkspaceActionsController
    extends $Notifier<AsyncValue<void>> {
  AsyncValue<void> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<void>, AsyncValue<void>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, AsyncValue<void>>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
