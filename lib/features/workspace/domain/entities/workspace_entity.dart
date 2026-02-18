abstract class WorkspaceEntity {
  const WorkspaceEntity();

  String get id;
  String get name;
  String? get description;
  String get ownerId;
  DateTime get createdAt;
  DateTime get updatedAt;
  int get memberCount;
  int get collectionCount;
  String get memberRole;

  bool get isOwner;
  bool get canEdit;
  bool get isViewer;
}
