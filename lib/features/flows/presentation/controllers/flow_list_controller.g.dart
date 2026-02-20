// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flow_list_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SelectedFlowId)
final selectedFlowIdProvider = SelectedFlowIdProvider._();

final class SelectedFlowIdProvider
    extends $NotifierProvider<SelectedFlowId, String?> {
  SelectedFlowIdProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'selectedFlowIdProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$selectedFlowIdHash();

  @$internal
  @override
  SelectedFlowId create() => SelectedFlowId();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String?>(value),
    );
  }
}

String _$selectedFlowIdHash() => r'4be4623d90c6ad0b07aff253effebfc0f57f3b02';

abstract class _$SelectedFlowId extends $Notifier<String?> {
  String? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<String?, String?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<String?, String?>,
              String?,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(RenamingFlowId)
final renamingFlowIdProvider = RenamingFlowIdProvider._();

final class RenamingFlowIdProvider
    extends $NotifierProvider<RenamingFlowId, String?> {
  RenamingFlowIdProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'renamingFlowIdProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$renamingFlowIdHash();

  @$internal
  @override
  RenamingFlowId create() => RenamingFlowId();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String?>(value),
    );
  }
}

String _$renamingFlowIdHash() => r'6e9ddf0ace6b1124514ec92826b038d875803854';

abstract class _$RenamingFlowId extends $Notifier<String?> {
  String? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<String?, String?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<String?, String?>,
              String?,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

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
    r'cf64353e22ffe6b8e8357a5f1a15907656873eb8';

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
