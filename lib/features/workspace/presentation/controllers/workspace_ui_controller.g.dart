// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workspace_ui_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(WorkspaceSearchQuery)
final workspaceSearchQueryProvider = WorkspaceSearchQueryProvider._();

final class WorkspaceSearchQueryProvider
    extends $NotifierProvider<WorkspaceSearchQuery, String> {
  WorkspaceSearchQueryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'workspaceSearchQueryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$workspaceSearchQueryHash();

  @$internal
  @override
  WorkspaceSearchQuery create() => WorkspaceSearchQuery();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$workspaceSearchQueryHash() =>
    r'55f678356363ea242b7bff4895e9fce95d5f8274';

abstract class _$WorkspaceSearchQuery extends $Notifier<String> {
  String build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<String, String>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<String, String>,
              String,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(WorkspaceSort)
final workspaceSortProvider = WorkspaceSortProvider._();

final class WorkspaceSortProvider
    extends $NotifierProvider<WorkspaceSort, WorkspaceSortStrategy> {
  WorkspaceSortProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'workspaceSortProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$workspaceSortHash();

  @$internal
  @override
  WorkspaceSort create() => WorkspaceSort();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(WorkspaceSortStrategy value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<WorkspaceSortStrategy>(value),
    );
  }
}

String _$workspaceSortHash() => r'496713da10abd1a1f7595f8c84f5e38696b3f77d';

abstract class _$WorkspaceSort extends $Notifier<WorkspaceSortStrategy> {
  WorkspaceSortStrategy build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<WorkspaceSortStrategy, WorkspaceSortStrategy>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<WorkspaceSortStrategy, WorkspaceSortStrategy>,
              WorkspaceSortStrategy,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
