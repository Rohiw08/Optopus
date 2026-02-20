/// A property definition inside an entity schema.
class EntityPropertySchema {
  final String name;
  final String type; // float, int, string, bool
  final bool required;
  final String description;
  final dynamic defaultValue;
  final num? min;
  final num? max;

  const EntityPropertySchema({
    required this.name,
    required this.type,
    required this.required,
    required this.description,
    this.defaultValue,
    this.min,
    this.max,
  });

  factory EntityPropertySchema.fromEntry(
    String name,
    Map<String, dynamic> json,
  ) {
    return EntityPropertySchema(
      name: name,
      type: json['type'] as String? ?? 'string',
      required: json['required'] as bool? ?? false,
      description: json['description'] as String? ?? '',
      defaultValue: json['default'],
      min: json['min'] as num?,
      max: json['max'] as num?,
    );
  }
}

/// Full schema returned by GET /entities/{type}.
class EntitySchema {
  final String type;
  final String description;
  final String domain;
  final bool canConnect;
  final List<EntityPropertySchema> properties;

  const EntitySchema({
    required this.type,
    required this.description,
    required this.domain,
    required this.canConnect,
    required this.properties,
  });

  factory EntitySchema.fromJson(Map<String, dynamic> json) {
    final rawProps = json['properties'] as Map<String, dynamic>? ?? {};
    final props = rawProps.entries
        .map(
          (e) => EntityPropertySchema.fromEntry(
            e.key,
            e.value as Map<String, dynamic>,
          ),
        )
        .toList();

    return EntitySchema(
      type: json['type'] as String,
      description: json['description'] as String? ?? '',
      domain: json['domain'] as String? ?? 'all',
      canConnect: json['can_connect'] as bool? ?? true,
      properties: props,
    );
  }
}
