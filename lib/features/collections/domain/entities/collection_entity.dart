abstract class CollectionEntity {
  const CollectionEntity();

  String get id;
  String get workspaceId;
  String get name;
  String? get description;
  String? get parentId;
  DateTime get createdAt;
  DateTime get updatedAt;
}
