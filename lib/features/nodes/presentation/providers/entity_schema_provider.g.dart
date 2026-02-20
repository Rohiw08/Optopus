// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entity_schema_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Fetches the full schema (including properties) for a specific entity type.
/// Uses the family modifier so it can be called per node type.

@ProviderFor(entitySchema)
final entitySchemaProvider = EntitySchemaFamily._();

/// Fetches the full schema (including properties) for a specific entity type.
/// Uses the family modifier so it can be called per node type.

final class EntitySchemaProvider
    extends
        $FunctionalProvider<
          AsyncValue<EntitySchema>,
          EntitySchema,
          FutureOr<EntitySchema>
        >
    with $FutureModifier<EntitySchema>, $FutureProvider<EntitySchema> {
  /// Fetches the full schema (including properties) for a specific entity type.
  /// Uses the family modifier so it can be called per node type.
  EntitySchemaProvider._({
    required EntitySchemaFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'entitySchemaProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$entitySchemaHash();

  @override
  String toString() {
    return r'entitySchemaProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<EntitySchema> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<EntitySchema> create(Ref ref) {
    final argument = this.argument as String;
    return entitySchema(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is EntitySchemaProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$entitySchemaHash() => r'b0cff4a52986f337a85ca636065c675ac97bfaa0';

/// Fetches the full schema (including properties) for a specific entity type.
/// Uses the family modifier so it can be called per node type.

final class EntitySchemaFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<EntitySchema>, String> {
  EntitySchemaFamily._()
    : super(
        retry: null,
        name: r'entitySchemaProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Fetches the full schema (including properties) for a specific entity type.
  /// Uses the family modifier so it can be called per node type.

  EntitySchemaProvider call(String type) =>
      EntitySchemaProvider._(argument: type, from: this);

  @override
  String toString() => r'entitySchemaProvider';
}
