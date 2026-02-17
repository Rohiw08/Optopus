// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'collection_list_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CollectionListController)
final collectionListControllerProvider = CollectionListControllerFamily._();

final class CollectionListControllerProvider
    extends
        $AsyncNotifierProvider<
          CollectionListController,
          List<CollectionEntity>
        > {
  CollectionListControllerProvider._({
    required CollectionListControllerFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'collectionListControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$collectionListControllerHash();

  @override
  String toString() {
    return r'collectionListControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  CollectionListController create() => CollectionListController();

  @override
  bool operator ==(Object other) {
    return other is CollectionListControllerProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$collectionListControllerHash() =>
    r'5c894e2661dc30704cd84ac0b9d30a8a07e0bcaa';

final class CollectionListControllerFamily extends $Family
    with
        $ClassFamilyOverride<
          CollectionListController,
          AsyncValue<List<CollectionEntity>>,
          List<CollectionEntity>,
          FutureOr<List<CollectionEntity>>,
          String
        > {
  CollectionListControllerFamily._()
    : super(
        retry: null,
        name: r'collectionListControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  CollectionListControllerProvider call(String workspaceId) =>
      CollectionListControllerProvider._(argument: workspaceId, from: this);

  @override
  String toString() => r'collectionListControllerProvider';
}

abstract class _$CollectionListController
    extends $AsyncNotifier<List<CollectionEntity>> {
  late final _$args = ref.$arg as String;
  String get workspaceId => _$args;

  FutureOr<List<CollectionEntity>> build(String workspaceId);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<AsyncValue<List<CollectionEntity>>, List<CollectionEntity>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<CollectionEntity>>,
                List<CollectionEntity>
              >,
              AsyncValue<List<CollectionEntity>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}
