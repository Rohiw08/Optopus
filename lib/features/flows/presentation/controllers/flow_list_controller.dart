import 'package:optopus/features/collections/presentation/controllers/collection_list_controller.dart';
import 'package:optopus/features/flows/domain/entities/flow_entity.dart';
import 'package:optopus/features/flows/providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'flow_list_controller.g.dart';

@riverpod
class SelectedFlowId extends _$SelectedFlowId {
  @override
  String? build() => null;

  void set(String? id) => state = id;
}

@riverpod
class RenamingFlowId extends _$RenamingFlowId {
  @override
  String? build() => null;

  void set(String? id) => state = id;
}

@riverpod
class FlowListController extends _$FlowListController {
  @override
  Future<List<FlowEntity>> build(String collectionId) async {
    final flows = await ref.read(flowServiceProvider).getFlows(collectionId);
    final query = ref.watch(collectionSearchQueryProvider);

    if (query.isEmpty) {
      return flows;
    }

    return flows
        .where((f) => f.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  Future<void> createFlow({
    required String name,
    Map<String, dynamic>? data,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref
          .read(flowServiceProvider)
          .createFlow(collectionId: collectionId, name: name, data: data);
      return ref.read(flowServiceProvider).getFlows(collectionId);
    });
  }

  Future<void> deleteFlow(String flowId) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref.read(flowServiceProvider).deleteFlow(flowId);
      return ref.read(flowServiceProvider).getFlows(collectionId);
    });
  }

  Future<void> renameFlow({
    required String flowId,
    required String newName,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref
          .read(flowServiceProvider)
          .updateFlow(flowId: flowId, name: newName);
      return ref.read(flowServiceProvider).getFlows(collectionId);
    });
  }
}
