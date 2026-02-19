import 'package:fpdart/fpdart.dart';
import 'package:optopus/core/domain/failures/failure.dart';
import 'package:optopus/features/flows/data/datasources/flow_remote_data_source.dart';
import 'package:optopus/features/flows/data/models/flow_model.dart';
import 'package:optopus/features/flows/domain/entities/flow_entity.dart';
import 'package:optopus/features/flows/domain/repositories/flow_repository.dart';

class FlowRepositoryImpl implements FlowRepository {
  final FlowRemoteDataSource remoteDataSource;

  FlowRepositoryImpl(this.remoteDataSource);

  Future<Either<Failure, T>> _guard<T>(Future<T> Function() body) async {
    try {
      return right(await body());
    } catch (e) {
      return left(UnknownWorkspaceFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<FlowEntity>>> getFlows(String collectionId) =>
      _guard(() async {
        final list = await remoteDataSource.getFlows(collectionId);
        return list.map(FlowModel.fromJson).toList();
      });

  @override
  Future<Either<Failure, List<FlowEntity>>> getFlowsByWorkspace(
    String workspaceId,
  ) => _guard(() async {
    final list = await remoteDataSource.getFlowsByWorkspace(workspaceId);
    return list.map(FlowModel.fromJson).toList();
  });

  @override
  Future<Either<Failure, FlowEntity>> createFlow({
    required String name,
    required String collectionId,
    Map<String, dynamic>? data,
  }) async {
    try {
      final flowData = await remoteDataSource.createFlow(
        name: name,
        collectionId: collectionId,
        data: data,
      );
      return right(FlowModel.fromJson(flowData));
    } catch (e) {
      return left(UnknownWorkspaceFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateFlow({
    required String flowId,
    String? name,
    Map<String, dynamic>? data,
  }) async {
    try {
      await remoteDataSource.updateFlow(flowId: flowId, name: name, data: data);
      return right(null);
    } catch (e) {
      return left(UnknownWorkspaceFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteFlow(String flowId) => _guard(() async {
    await remoteDataSource.deleteFlow(flowId);
  });

  @override
  Future<Either<Failure, FlowEntity>> getFlowById(String flowId) =>
      _guard(() async {
        final data = await remoteDataSource.getFlowById(flowId);
        return FlowModel.fromJson(data);
      });
}
