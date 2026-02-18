// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(collectionRemoteDataSource)
final collectionRemoteDataSourceProvider =
    CollectionRemoteDataSourceProvider._();

final class CollectionRemoteDataSourceProvider
    extends
        $FunctionalProvider<
          CollectionRemoteDataSource,
          CollectionRemoteDataSource,
          CollectionRemoteDataSource
        >
    with $Provider<CollectionRemoteDataSource> {
  CollectionRemoteDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'collectionRemoteDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$collectionRemoteDataSourceHash();

  @$internal
  @override
  $ProviderElement<CollectionRemoteDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CollectionRemoteDataSource create(Ref ref) {
    return collectionRemoteDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CollectionRemoteDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CollectionRemoteDataSource>(value),
    );
  }
}

String _$collectionRemoteDataSourceHash() =>
    r'4429a28d3f253f032c77ee4209fca0d0da2e4b96';

@ProviderFor(collectionRepository)
final collectionRepositoryProvider = CollectionRepositoryProvider._();

final class CollectionRepositoryProvider
    extends
        $FunctionalProvider<
          CollectionRepository,
          CollectionRepository,
          CollectionRepository
        >
    with $Provider<CollectionRepository> {
  CollectionRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'collectionRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$collectionRepositoryHash();

  @$internal
  @override
  $ProviderElement<CollectionRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CollectionRepository create(Ref ref) {
    return collectionRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CollectionRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CollectionRepository>(value),
    );
  }
}

String _$collectionRepositoryHash() =>
    r'4549e9a143d48ab6591e68eb789400df305ca5ce';

@ProviderFor(collectionService)
final collectionServiceProvider = CollectionServiceProvider._();

final class CollectionServiceProvider
    extends
        $FunctionalProvider<
          CollectionService,
          CollectionService,
          CollectionService
        >
    with $Provider<CollectionService> {
  CollectionServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'collectionServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$collectionServiceHash();

  @$internal
  @override
  $ProviderElement<CollectionService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CollectionService create(Ref ref) {
    return collectionService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CollectionService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CollectionService>(value),
    );
  }
}

String _$collectionServiceHash() => r'765c7c7cd528ab6c2d6c8d5871b4b706e46a8388';
