// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(_workspaceRemoteDataSource)
final _workspaceRemoteDataSourceProvider =
    _WorkspaceRemoteDataSourceProvider._();

final class _WorkspaceRemoteDataSourceProvider
    extends
        $FunctionalProvider<
          WorkspaceRemoteDataSource,
          WorkspaceRemoteDataSource,
          WorkspaceRemoteDataSource
        >
    with $Provider<WorkspaceRemoteDataSource> {
  _WorkspaceRemoteDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'_workspaceRemoteDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$_workspaceRemoteDataSourceHash();

  @$internal
  @override
  $ProviderElement<WorkspaceRemoteDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  WorkspaceRemoteDataSource create(Ref ref) {
    return _workspaceRemoteDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(WorkspaceRemoteDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<WorkspaceRemoteDataSource>(value),
    );
  }
}

String _$_workspaceRemoteDataSourceHash() =>
    r'4833faa7180fcfb8f633788844d4cf3b6481c0ef';

@ProviderFor(_workspaceRepository)
final _workspaceRepositoryProvider = _WorkspaceRepositoryProvider._();

final class _WorkspaceRepositoryProvider
    extends
        $FunctionalProvider<
          WorkspaceRepository,
          WorkspaceRepository,
          WorkspaceRepository
        >
    with $Provider<WorkspaceRepository> {
  _WorkspaceRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'_workspaceRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$_workspaceRepositoryHash();

  @$internal
  @override
  $ProviderElement<WorkspaceRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  WorkspaceRepository create(Ref ref) {
    return _workspaceRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(WorkspaceRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<WorkspaceRepository>(value),
    );
  }
}

String _$_workspaceRepositoryHash() =>
    r'ffb10647410e300ce45cb4fd0063f4c963301726';

@ProviderFor(workspaceService)
final workspaceServiceProvider = WorkspaceServiceProvider._();

final class WorkspaceServiceProvider
    extends
        $FunctionalProvider<
          WorkspaceService,
          WorkspaceService,
          WorkspaceService
        >
    with $Provider<WorkspaceService> {
  WorkspaceServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'workspaceServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$workspaceServiceHash();

  @$internal
  @override
  $ProviderElement<WorkspaceService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  WorkspaceService create(Ref ref) {
    return workspaceService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(WorkspaceService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<WorkspaceService>(value),
    );
  }
}

String _$workspaceServiceHash() => r'ccdd1ef5f07852042cbd1d733f069171a405bea4';
