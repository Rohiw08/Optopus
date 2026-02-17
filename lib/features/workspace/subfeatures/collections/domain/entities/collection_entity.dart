class CollectionEntity {
  final String id;
  final String workspaceId;
  final String name;
  final String? description;
  final String? parentId;
  final DateTime createdAt;
  final DateTime updatedAt;

  const CollectionEntity({
    required this.id,
    required this.workspaceId,
    required this.name,
    this.description,
    this.parentId,
    required this.createdAt,
    required this.updatedAt,
  });
}
