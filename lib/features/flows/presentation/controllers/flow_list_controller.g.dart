// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flow_list_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(FlowListController)
final flowListControllerProvider = FlowListControllerFamily._();

final class FlowListControllerProvider
    extends $AsyncNotifierProvider<FlowListController, List<FlowEntity>> {
  FlowListControllerProvider._({
    required FlowListControllerFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'flowListControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$flowListControllerHash();

  @override
  String toString() {
    return r'flowListControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  FlowListController create() => FlowListController();

  @override
  bool operator ==(Object other) {
    return other is FlowListControllerProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$flowListControllerHash() =>
    r'd01f9ba46501c2ca97c3abc8265ce73d6b9fe259';

final class FlowListControllerFamily extends $Family
    with
        $ClassFamilyOverride<
          FlowListController,
          AsyncValue<List<FlowEntity>>,
          List<FlowEntity>,
          FutureOr<List<FlowEntity>>,
          String
        > {
  FlowListControllerFamily._()
    : super(
        retry: null,
        name: r'flowListControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  FlowListControllerProvider call(String collectionId) =>
      FlowListControllerProvider._(argument: collectionId, from: this);

  @override
  String toString() => r'flowListControllerProvider';
}

abstract class _$FlowListController extends $AsyncNotifier<List<FlowEntity>> {
  late final _$args = ref.$arg as String;
  String get collectionId => _$args;

  FutureOr<List<FlowEntity>> build(String collectionId);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<FlowEntity>>, List<FlowEntity>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<FlowEntity>>, List<FlowEntity>>,
              AsyncValue<List<FlowEntity>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}
