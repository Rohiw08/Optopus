// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'active_workspace_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ActiveWorkspace)
final activeWorkspaceProvider = ActiveWorkspaceProvider._();

final class ActiveWorkspaceProvider
    extends $NotifierProvider<ActiveWorkspace, WorkspaceEntity?> {
  ActiveWorkspaceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'activeWorkspaceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$activeWorkspaceHash();

  @$internal
  @override
  ActiveWorkspace create() => ActiveWorkspace();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(WorkspaceEntity? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<WorkspaceEntity?>(value),
    );
  }
}

String _$activeWorkspaceHash() => r'4c3ce9b02cedc791421daddbef93c8dea58c3c23';

abstract class _$ActiveWorkspace extends $Notifier<WorkspaceEntity?> {
  WorkspaceEntity? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<WorkspaceEntity?, WorkspaceEntity?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<WorkspaceEntity?, WorkspaceEntity?>,
              WorkspaceEntity?,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
