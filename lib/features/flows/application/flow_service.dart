import 'package:optopus/features/flows/domain/entities/flow_entity.dart';
import 'package:optopus/features/flows/domain/repositories/flow_repository.dart';

class FlowService {
  final FlowRepository _repository;

  FlowService(this._repository);

  Future<List<FlowEntity>> getFlows(String collectionId) async {
    final result = await _repository.getFlows(collectionId);
    return result.fold((failure) => throw failure, (flows) => flows);
  }

  Future<List<FlowEntity>> getFlowsByWorkspace(String workspaceId) async {
    final result = await _repository.getFlowsByWorkspace(workspaceId);
    return result.fold((l) => throw l, (r) => r);
  }

  Future<FlowEntity> createFlow({
    required String name,
    required String collectionId,
    Map<String, dynamic>? data,
  }) async {
    final result = await _repository.createFlow(
      name: name,
      collectionId: collectionId,
      data: data,
    );
    return result.fold((failure) => throw failure, (flow) => flow);
  }

  Future<void> updateFlow({
    required String flowId,
    String? name,
    Map<String, dynamic>? data,
  }) async {
    final result = await _repository.updateFlow(
      flowId: flowId,
      name: name,
      data: data,
    );
    return result.fold((failure) => throw failure, (_) {});
  }

  Future<void> deleteFlow(String flowId) async {
    final result = await _repository.deleteFlow(flowId);
    return result.fold((failure) => throw failure, (_) {});
  }

  Future<FlowEntity> getFlowById(String flowId) async {
    final result = await _repository.getFlowById(flowId);
    return result.fold((failure) => throw failure, (flow) => flow);
  }
}
