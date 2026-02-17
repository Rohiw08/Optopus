import 'package:optopus/features/workspace/subfeatures/flows/domain/entities/flow_entity.dart';
import 'package:optopus/features/workspace/subfeatures/flows/providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'flow_list_controller.g.dart';

@riverpod
class FlowListController extends _$FlowListController {
  @override
  Future<List<FlowEntity>> build(String collectionId) {
    return ref.read(flowServiceProvider).getFlows(collectionId);
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
}
