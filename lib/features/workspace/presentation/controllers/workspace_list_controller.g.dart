// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workspace_list_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(WorkspaceListController)
final workspaceListControllerProvider = WorkspaceListControllerProvider._();

final class WorkspaceListControllerProvider
    extends
        $AsyncNotifierProvider<WorkspaceListController, List<WorkspaceEntity>> {
  WorkspaceListControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'workspaceListControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$workspaceListControllerHash();

  @$internal
  @override
  WorkspaceListController create() => WorkspaceListController();
}

String _$workspaceListControllerHash() =>
    r'119bb561ab7e171243ad0d4f4a214a41c82589d3';

abstract class _$WorkspaceListController
    extends $AsyncNotifier<List<WorkspaceEntity>> {
  FutureOr<List<WorkspaceEntity>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<AsyncValue<List<WorkspaceEntity>>, List<WorkspaceEntity>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<WorkspaceEntity>>,
                List<WorkspaceEntity>
              >,
              AsyncValue<List<WorkspaceEntity>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
