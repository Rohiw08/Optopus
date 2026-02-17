import 'package:optopus/features/editor/providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'editor_controller.g.dart';

@riverpod
class EditorController extends _$EditorController {
  @override
  AsyncValue<void> build() {
    return const AsyncValue.data(null);
  }

  /// Saves flow data to the backend
  Future<void> saveFlow({
    required String flowId,
    required Map<String, dynamic> data,
  }) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await ref
          .read(editorServiceProvider)
          .saveFlow(flowId: flowId, data: data, name: null);
    });
  }

  /// Executes a flow
  Future<void> executeFlow({
    required String flowId,
    required Map<String, dynamic> data,
  }) async {
    state = const AsyncValue.loading();

    // First save
    try {
      await ref
          .read(editorServiceProvider)
          .saveFlow(flowId: flowId, data: data, name: null);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
      return;
    }

    // Then execute
    final result = await ref
        .read(editorServiceProvider)
        .executeFlow(flowId: flowId, data: data);

    result.fold(
      (failure) => state = AsyncValue.error(failure, StackTrace.current),
      (_) => state = const AsyncValue.data(null),
    );
  }
}
