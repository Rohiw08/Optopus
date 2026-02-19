// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flow_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(flow)
final flowProvider = FlowFamily._();

final class FlowProvider
    extends
        $FunctionalProvider<
          AsyncValue<FlowEntity>,
          FlowEntity,
          FutureOr<FlowEntity>
        >
    with $FutureModifier<FlowEntity>, $FutureProvider<FlowEntity> {
  FlowProvider._({
    required FlowFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'flowProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$flowHash();

  @override
  String toString() {
    return r'flowProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<FlowEntity> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<FlowEntity> create(Ref ref) {
    final argument = this.argument as String;
    return flow(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is FlowProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$flowHash() => r'1a86eae3279a7d27e0201d1f8cd7655804824e5a';

final class FlowFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<FlowEntity>, String> {
  FlowFamily._()
    : super(
        retry: null,
        name: r'flowProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  FlowProvider call(String flowId) =>
      FlowProvider._(argument: flowId, from: this);

  @override
  String toString() => r'flowProvider';
}
