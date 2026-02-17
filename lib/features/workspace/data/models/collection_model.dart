import 'package:optopus/features/workspace/subfeatures/collections/domain/entities/collection_entity.dart';

class CollectionModel extends CollectionEntity {
  const CollectionModel({
    required super.id,
    required super.workspaceId,
    required super.name,
    super.description,
    super.parentId,
    required super.createdAt,
    required super.updatedAt,
  });

  factory CollectionModel.fromJson(Map<String, dynamic> json) {
    return CollectionModel(
      id: json['id'] as String,
      workspaceId: json['workspace_id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      parentId: json['parent_id'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  Map<String, dynamic> toInsertJson() {
    return {
      'workspace_id': workspaceId,
      'name': name,
      if (description != null) 'description': description,
      if (parentId != null) 'parent_id': parentId,
    };
  }
}
