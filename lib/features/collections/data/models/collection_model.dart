import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:optopus/features/collections/domain/entities/collection_entity.dart';

part 'collection_model.freezed.dart';
part 'collection_model.g.dart';

@freezed
abstract class CollectionModel extends CollectionEntity with _$CollectionModel {
  const factory CollectionModel({
    required String id,
    @JsonKey(name: 'workspace_id') required String workspaceId,
    required String name,
    String? description,
    @JsonKey(name: 'parent_id') String? parentId,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'updated_at') required DateTime updatedAt,
  }) = _CollectionModel;

  // Added a private constructor to allow adding custom methods to the class
  const CollectionModel._();

  factory CollectionModel.fromJson(Map<String, dynamic> json) =>
      _$CollectionModelFromJson(json);

  Map<String, dynamic> toInsertJson() {
    return {
      'workspace_id': workspaceId,
      'name': name,
      if (description != null) 'description': description,
      if (parentId != null) 'parent_id': parentId,
    };
  }
}
