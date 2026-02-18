import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:optopus/features/workspace/domain/entities/workspace_entity.dart';

part 'workspace_model.freezed.dart';
part 'workspace_model.g.dart';

@freezed
abstract class WorkspaceModel extends WorkspaceEntity with _$WorkspaceModel {
  const factory WorkspaceModel({
    required String id,
    required String name,
    String? description,
    @JsonKey(name: 'owner_id') required String ownerId,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'updated_at') required DateTime updatedAt,

    // From workspaces_with_stats view
    @JsonKey(name: 'member_count') @Default(0) int memberCount,
    @JsonKey(name: 'collection_count') @Default(0) int collectionCount,

    // From get_user_workspaces() function
    // 'owner', 'admin', 'editor', 'viewer'
    @JsonKey(name: 'member_role') @Default('owner') String memberRole,
  }) = _WorkspaceModel;

  const WorkspaceModel._();

  factory WorkspaceModel.fromJson(Map<String, dynamic> json) =>
      _$WorkspaceModelFromJson(json);

  // Convenience getters
  @override
  bool get isOwner => memberRole == 'owner';
  @override
  bool get canEdit =>
      memberRole == 'owner' || memberRole == 'admin' || memberRole == 'editor';
  @override
  bool get isViewer => memberRole == 'viewer';

  Map<String, dynamic> toInsertJson() {
    return {'name': name, if (description != null) 'description': description};
  }
}
