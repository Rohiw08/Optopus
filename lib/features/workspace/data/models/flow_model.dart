import 'package:optopus/features/workspace/subfeatures/flows/domain/entities/flow_entity.dart';

class FlowModel extends FlowEntity {
  const FlowModel({
    required super.id,
    required super.collectionId,
    required super.name,
    super.data = const {},
    required super.createdAt,
    required super.updatedAt,
  });

  factory FlowModel.fromJson(Map<String, dynamic> json) {
    return FlowModel(
      id: json['id'] as String,
      collectionId: json['collection_id'] as String,
      name: json['name'] as String,
      data: (json['data'] as Map<String, dynamic>?) ?? const {},
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  Map<String, dynamic> toInsertJson() {
    return {'collection_id': collectionId, 'name': name, 'data': data};
  }
}
