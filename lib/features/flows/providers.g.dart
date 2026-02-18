// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(flowRemoteDataSource)
final flowRemoteDataSourceProvider = FlowRemoteDataSourceProvider._();

final class FlowRemoteDataSourceProvider
    extends
        $FunctionalProvider<
          FlowRemoteDataSource,
          FlowRemoteDataSource,
          FlowRemoteDataSource
        >
    with $Provider<FlowRemoteDataSource> {
  FlowRemoteDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'flowRemoteDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$flowRemoteDataSourceHash();

  @$internal
  @override
  $ProviderElement<FlowRemoteDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  FlowRemoteDataSource create(Ref ref) {
    return flowRemoteDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FlowRemoteDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FlowRemoteDataSource>(value),
    );
  }
}

String _$flowRemoteDataSourceHash() =>
    r'0679935cf8044fa01edaeb61773bbb81a2491cf0';

@ProviderFor(flowRepository)
final flowRepositoryProvider = FlowRepositoryProvider._();

final class FlowRepositoryProvider
    extends $FunctionalProvider<FlowRepository, FlowRepository, FlowRepository>
    with $Provider<FlowRepository> {
  FlowRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'flowRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$flowRepositoryHash();

  @$internal
  @override
  $ProviderElement<FlowRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  FlowRepository create(Ref ref) {
    return flowRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FlowRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FlowRepository>(value),
    );
  }
}

String _$flowRepositoryHash() => r'd96b409400a55c8cb339c0893689cb887dbb0555';

@ProviderFor(flowService)
final flowServiceProvider = FlowServiceProvider._();

final class FlowServiceProvider
    extends $FunctionalProvider<FlowService, FlowService, FlowService>
    with $Provider<FlowService> {
  FlowServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'flowServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$flowServiceHash();

  @$internal
  @override
  $ProviderElement<FlowService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  FlowService create(Ref ref) {
    return flowService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FlowService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FlowService>(value),
    );
  }
}

String _$flowServiceHash() => r'ebcb5f035bcf74462c21747772833975e2d12231';
