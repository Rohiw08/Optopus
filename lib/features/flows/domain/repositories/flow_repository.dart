import 'package:fpdart/fpdart.dart';
import 'package:optopus/core/domain/failures/failure.dart';
import 'package:optopus/features/flows/domain/entities/flow_entity.dart';

abstract class FlowRepository {
  Future<Either<Failure, List<FlowEntity>>> getFlows(String collectionId);
  Future<Either<Failure, FlowEntity>> createFlow({
    required String name,
    required String collectionId,
    Map<String, dynamic>? data,
  });
  Future<Either<Failure, void>> updateFlow({
    required String flowId,
    String? name,
    Map<String, dynamic>? data,
  });
  Future<Either<Failure, void>> deleteFlow(String flowId);
}
