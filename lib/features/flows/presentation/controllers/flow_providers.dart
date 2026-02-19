import 'package:optopus/features/flows/domain/entities/flow_entity.dart';
import 'package:optopus/features/flows/providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'flow_providers.g.dart';

@riverpod
Future<FlowEntity> flow(Ref ref, String flowId) async {
  final flowService = ref.watch(flowServiceProvider);
  return flowService.getFlowById(flowId);
}
