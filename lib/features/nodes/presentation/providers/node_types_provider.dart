import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:optopus/core/network/api_client.dart';
import 'package:optopus/features/nodes/domain/entities/node_type_entity.dart';

part 'node_types_provider.g.dart';

@riverpod
Future<List<NodeTypeEntity>> nodeTypes(Ref ref) async {
  final client = OptopusApiClient();
  final data = await client.getEntities();

  return data
      .map((json) => NodeTypeEntity.fromJson(json as Map<String, dynamic>))
      .toList();
}
