import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:optopus/features/flows/domain/entities/flow_entity.dart';

part 'flow_model.freezed.dart';
part 'flow_model.g.dart';

@freezed
abstract class FlowModel extends FlowEntity with _$FlowModel {
  const factory FlowModel({
    required String id,
    @JsonKey(name: 'collection_id') required String collectionId,
    required String name,
    @Default({}) Map<String, dynamic> data,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'updated_at') required DateTime updatedAt,
  }) = _FlowModel;

  // Private constructor required for custom methods
  const FlowModel._();

  factory FlowModel.fromJson(Map<String, dynamic> json) =>
      _$FlowModelFromJson(json);

  Map<String, dynamic> toInsertJson() {
    return {'collection_id': collectionId, 'name': name, 'data': data};
  }
}
