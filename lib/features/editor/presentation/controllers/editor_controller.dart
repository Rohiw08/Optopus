import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:optopus/features/editor/application/optimization_mapper.dart';
import 'package:optopus/features/editor/providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'editor_controller.g.dart';

/// Tracks only whether a save is in-flight, independently of the run state.
@riverpod
class IsSaving extends _$IsSaving {
  @override
  bool build() => false;

  void setSaving(bool value) => state = value;
}

@riverpod
class EditorController extends _$EditorController {
  @override
  AsyncValue<Map<String, dynamic>?> build() {
    return const AsyncValue.data(null);
  }

  /// Saves flow data to the backend without touching the execution state.
  Future<void> saveFlow({
    required String flowId,
    required Map<String, dynamic> data,
  }) async {
    ref.read(isSavingProvider.notifier).setSaving(true);
    try {
      await ref
          .read(editorServiceProvider)
          .saveFlow(flowId: flowId, data: data, name: null);
    } catch (e, st) {
      // Surface the error via execution state so the UI can react.
      state = AsyncValue.error(e, st);
    } finally {
      ref.read(isSavingProvider.notifier).setSaving(false);
    }
  }

  /// Executes a flow
  Future<void> executeFlow({
    required String flowId,
    required String flowName,
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

    // Map payload
    final optimizationPayload = OptimizationMapper.mapToOptimizationRequest(
      flowId: flowId,
      flowName: flowName,
      canvasStateJson: data,
    );

    // ---- DEBUG LOGGING ----
    debugPrint('=== RAW CANVAS STATE JSON ===');
    debugPrint(const JsonEncoder.withIndent('  ').convert(data));
    debugPrint('=== OPTIMIZATION PAYLOAD SENT TO API ===');
    debugPrint(const JsonEncoder.withIndent('  ').convert(optimizationPayload));
    // -----------------------

    // Then execute
    final result = await ref
        .read(editorServiceProvider)
        .executeFlow(flowId: flowId, data: optimizationPayload);

    result.fold(
      (failure) {
        state = AsyncValue.error(failure, StackTrace.current);
      },
      (data) {
        state = AsyncValue.data(data);
      },
    );
  }
}
