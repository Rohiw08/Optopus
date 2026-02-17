// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(workspaceRemoteDataSource)
final workspaceRemoteDataSourceProvider = WorkspaceRemoteDataSourceProvider._();

final class WorkspaceRemoteDataSourceProvider
    extends
        $FunctionalProvider<
          WorkspaceRemoteDataSource,
          WorkspaceRemoteDataSource,
          WorkspaceRemoteDataSource
        >
    with $Provider<WorkspaceRemoteDataSource> {
  WorkspaceRemoteDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'workspaceRemoteDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$workspaceRemoteDataSourceHash();

  @$internal
  @override
  $ProviderElement<WorkspaceRemoteDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  WorkspaceRemoteDataSource create(Ref ref) {
    return workspaceRemoteDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(WorkspaceRemoteDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<WorkspaceRemoteDataSource>(value),
    );
  }
}

String _$workspaceRemoteDataSourceHash() =>
    r'2fc37a88bfc7e0daf895f0b60f332b92643f484f';

@ProviderFor(workspaceRepository)
final workspaceRepositoryProvider = WorkspaceRepositoryProvider._();

final class WorkspaceRepositoryProvider
    extends
        $FunctionalProvider<
          WorkspaceRepository,
          WorkspaceRepository,
          WorkspaceRepository
        >
    with $Provider<WorkspaceRepository> {
  WorkspaceRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'workspaceRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$workspaceRepositoryHash();

  @$internal
  @override
  $ProviderElement<WorkspaceRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  WorkspaceRepository create(Ref ref) {
    return workspaceRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(WorkspaceRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<WorkspaceRepository>(value),
    );
  }
}

String _$workspaceRepositoryHash() =>
    r'2f906d0ada23c82cf138ab94ca147290a36d3c30';

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

String _$workspaceServiceHash() => r'460068187004d7d24ecec7b111684d464fc536c1';
