// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workspace_detail_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(WorkspaceDetailController)
final workspaceDetailControllerProvider = WorkspaceDetailControllerFamily._();

final class WorkspaceDetailControllerProvider
    extends $AsyncNotifierProvider<WorkspaceDetailController, WorkspaceEntity> {
  WorkspaceDetailControllerProvider._({
    required WorkspaceDetailControllerFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'workspaceDetailControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$workspaceDetailControllerHash();

  @override
  String toString() {
    return r'workspaceDetailControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  WorkspaceDetailController create() => WorkspaceDetailController();

  @override
  bool operator ==(Object other) {
    return other is WorkspaceDetailControllerProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$workspaceDetailControllerHash() =>
    r'fd3f79e912a98aecac8f54dea4596ecadd038530';

final class WorkspaceDetailControllerFamily extends $Family
    with
        $ClassFamilyOverride<
          WorkspaceDetailController,
          AsyncValue<WorkspaceEntity>,
          WorkspaceEntity,
          FutureOr<WorkspaceEntity>,
          String
        > {
  WorkspaceDetailControllerFamily._()
    : super(
        retry: null,
        name: r'workspaceDetailControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  WorkspaceDetailControllerProvider call(String workspaceId) =>
      WorkspaceDetailControllerProvider._(argument: workspaceId, from: this);

  @override
  String toString() => r'workspaceDetailControllerProvider';
}

abstract class _$WorkspaceDetailController
    extends $AsyncNotifier<WorkspaceEntity> {
  late final _$args = ref.$arg as String;
  String get workspaceId => _$args;

  FutureOr<WorkspaceEntity> build(String workspaceId);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<WorkspaceEntity>, WorkspaceEntity>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<WorkspaceEntity>, WorkspaceEntity>,
              AsyncValue<WorkspaceEntity>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}
