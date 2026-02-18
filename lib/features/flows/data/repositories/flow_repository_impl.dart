import 'package:fpdart/fpdart.dart';
import 'package:optopus/core/domain/failures/failure.dart';
import 'package:optopus/features/flows/data/datasources/flow_remote_data_source.dart';
import 'package:optopus/features/flows/data/models/flow_model.dart';
import 'package:optopus/features/flows/domain/entities/flow_entity.dart';
import 'package:optopus/features/flows/domain/repositories/flow_repository.dart';

class FlowRepositoryImpl implements FlowRepository {
  final FlowRemoteDataSource remoteDataSource;

  FlowRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<FlowEntity>>> getFlows(
    String collectionId,
  ) async {
    try {
      final flowsData = await remoteDataSource.getFlows(collectionId);
      final flows = flowsData.map((data) => FlowModel.fromJson(data)).toList();
      return right(flows);
    } catch (e) {
      return left(UnknownWorkspaceFailure(e.toString()));
    }
  }

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
  Future<Either<Failure, void>> deleteFlow(String flowId) async {
    try {
      await remoteDataSource.deleteFlow(flowId);
      return right(null);
    } catch (e) {
      return left(UnknownWorkspaceFailure(e.toString()));
    }
  }
}
