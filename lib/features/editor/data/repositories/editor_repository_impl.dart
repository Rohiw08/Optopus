import 'package:fpdart/fpdart.dart';
import 'package:optopus/features/editor/data/datasources/editor_data_source.dart';
import 'package:optopus/core/domain/failures/failure.dart';
import 'package:optopus/features/editor/domain/repositories/editor_repository.dart';

class EditorRepositoryImpl implements EditorRepository {
  final EditorDataSource _dataSource;

  EditorRepositoryImpl(this._dataSource);

  @override
  Future<Either<EditorFailure, Map<String, dynamic>>> executeFlow({
    required String flowId,
    required Map<String, dynamic> data,
  }) async {
    try {
      final result = await _dataSource.executeFlow(flowId: flowId, data: data);
      return Right(result);
    } catch (e) {
      // TODO: Map specific exceptions to specific failures
      return Left(ExecutionFailure(e.toString()));
    }
  }
}
