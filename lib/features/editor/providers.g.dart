// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(editorDataSource)
final editorDataSourceProvider = EditorDataSourceProvider._();

final class EditorDataSourceProvider
    extends
        $FunctionalProvider<
          EditorDataSource,
          EditorDataSource,
          EditorDataSource
        >
    with $Provider<EditorDataSource> {
  EditorDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'editorDataSourceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$editorDataSourceHash();

  @$internal
  @override
  $ProviderElement<EditorDataSource> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  EditorDataSource create(Ref ref) {
    return editorDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(EditorDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<EditorDataSource>(value),
    );
  }
}

String _$editorDataSourceHash() => r'45ea7f2da20a753ec5451229e1332a97c755ccae';

@ProviderFor(editorRepository)
final editorRepositoryProvider = EditorRepositoryProvider._();

final class EditorRepositoryProvider
    extends
        $FunctionalProvider<
          EditorRepository,
          EditorRepository,
          EditorRepository
        >
    with $Provider<EditorRepository> {
  EditorRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'editorRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$editorRepositoryHash();

  @$internal
  @override
  $ProviderElement<EditorRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  EditorRepository create(Ref ref) {
    return editorRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(EditorRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<EditorRepository>(value),
    );
  }
}

String _$editorRepositoryHash() => r'd6fabd2ea94e505d0ff2ca4f46420e5fe28e0c08';

@ProviderFor(editorService)
final editorServiceProvider = EditorServiceProvider._();

final class EditorServiceProvider
    extends $FunctionalProvider<EditorService, EditorService, EditorService>
    with $Provider<EditorService> {
  EditorServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'editorServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$editorServiceHash();

  @$internal
  @override
  $ProviderElement<EditorService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  EditorService create(Ref ref) {
    return editorService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(EditorService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<EditorService>(value),
    );
  }
}

String _$editorServiceHash() => r'39788806ab699dbd396f24a0b49df296c50d399a';
