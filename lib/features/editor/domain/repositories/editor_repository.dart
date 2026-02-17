import 'package:optopus/core/domain/failures/failure.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class EditorRepository {
  Future<Either<EditorFailure, void>> executeFlow({
    required String flowId,
    required Map<String, dynamic> data,
  });
}
