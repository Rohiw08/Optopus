// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'active_workspace_view_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(WorkspaceView)
final workspaceViewProvider = WorkspaceViewProvider._();

final class WorkspaceViewProvider
    extends $NotifierProvider<WorkspaceView, int> {
  WorkspaceViewProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'workspaceViewProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$workspaceViewHash();

  @$internal
  @override
  WorkspaceView create() => WorkspaceView();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$workspaceViewHash() => r'22a83eab30128b7cde53bbca2929e7da241eedb1';

abstract class _$WorkspaceView extends $Notifier<int> {
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
