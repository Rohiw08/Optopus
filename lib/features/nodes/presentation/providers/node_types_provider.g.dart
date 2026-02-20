// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'node_types_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(nodeTypes)
final nodeTypesProvider = NodeTypesProvider._();

final class NodeTypesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<NodeTypeEntity>>,
          List<NodeTypeEntity>,
          FutureOr<List<NodeTypeEntity>>
        >
    with
        $FutureModifier<List<NodeTypeEntity>>,
        $FutureProvider<List<NodeTypeEntity>> {
  NodeTypesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'nodeTypesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$nodeTypesHash();

  @$internal
  @override
  $FutureProviderElement<List<NodeTypeEntity>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<NodeTypeEntity>> create(Ref ref) {
    return nodeTypes(ref);
  }
}

String _$nodeTypesHash() => r'76d390b813ec4b3c81b1e5702bfda459c95ccf21';
