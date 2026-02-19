// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(_collectionRemoteDataSource)
final _collectionRemoteDataSourceProvider =
    _CollectionRemoteDataSourceProvider._();

final class _CollectionRemoteDataSourceProvider
    extends
        $FunctionalProvider<
          CollectionRemoteDataSource,
          CollectionRemoteDataSource,
          CollectionRemoteDataSource
        >
    with $Provider<CollectionRemoteDataSource> {
  _CollectionRemoteDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'_collectionRemoteDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$_collectionRemoteDataSourceHash();

  @$internal
  @override
  $ProviderElement<CollectionRemoteDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CollectionRemoteDataSource create(Ref ref) {
    return _collectionRemoteDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CollectionRemoteDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CollectionRemoteDataSource>(value),
    );
  }
}

String _$_collectionRemoteDataSourceHash() =>
    r'4837fce81dd7a9a214725fd75e989f31148b67f6';

@ProviderFor(_collectionRepository)
final _collectionRepositoryProvider = _CollectionRepositoryProvider._();

final class _CollectionRepositoryProvider
    extends
        $FunctionalProvider<
          CollectionRepository,
          CollectionRepository,
          CollectionRepository
        >
    with $Provider<CollectionRepository> {
  _CollectionRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'_collectionRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$_collectionRepositoryHash();

  @$internal
  @override
  $ProviderElement<CollectionRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CollectionRepository create(Ref ref) {
    return _collectionRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CollectionRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CollectionRepository>(value),
    );
  }
}

String _$_collectionRepositoryHash() =>
    r'a62c4c5b9138c518ae1bca6e2d6b560cbeb44fec';

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

String _$collectionServiceHash() => r'd4f2465cfa359bf62116718bc2c2eb5469dab566';
