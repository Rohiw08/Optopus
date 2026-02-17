import 'package:optopus/features/workspace/subfeatures/flows/domain/entities/flow_entity.dart';
import 'package:optopus/features/workspace/subfeatures/flows/domain/repositories/flow_repository.dart';

class FlowService {
  final FlowRepository _repository;

  FlowService(this._repository);

  Future<List<FlowEntity>> getFlows(String collectionId) async {
    final result = await _repository.getFlows(collectionId);
    return result.fold((failure) => throw failure, (flows) => flows);
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
}
