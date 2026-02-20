import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:optopus/core/network/api_client.dart';
import 'package:optopus/features/nodes/domain/entities/entity_schema.dart';

part 'entity_schema_provider.g.dart';

/// Fetches the full schema (including properties) for a specific entity type.
/// Uses the family modifier so it can be called per node type.
@riverpod
Future<EntitySchema> entitySchema(Ref ref, String type) async {
  final client = OptopusApiClient();
  final data = await client.getEntitySchema(type);
  return EntitySchema.fromJson(data);
}
