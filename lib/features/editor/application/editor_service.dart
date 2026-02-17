import 'package:fpdart/fpdart.dart';
import 'package:optopus/core/domain/failures/failure.dart';
import 'package:optopus/features/editor/domain/repositories/editor_repository.dart';
import 'package:optopus/features/workspace/subfeatures/flows/domain/repositories/flow_repository.dart';

class EditorService {
  final EditorRepository _editorRepository;
  final FlowRepository _flowRepository;

  EditorService(this._editorRepository, this._flowRepository);

  Future<Either<EditorFailure, void>> executeFlow({
    required String flowId,
    required Map<String, dynamic> data,
  }) async {
    return _editorRepository.executeFlow(flowId: flowId, data: data);
  }

  Future<void> saveFlow({
    required String flowId,
    required String? name,
    required Map<String, dynamic>? data,
  }) async {
    final result = await _flowRepository.updateFlow(
      flowId: flowId,
      name: name,
      data: data,
    );
    result.fold(
      (failure) => throw SaveFailure(failure.toString()),
      (_) => null,
    );
  }
}
