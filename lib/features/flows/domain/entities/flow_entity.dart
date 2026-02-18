abstract class FlowEntity {
  const FlowEntity();

  String get id;
  String get collectionId;
  String get name;
  Map<String, dynamic> get data;
  DateTime get createdAt;
  DateTime get updatedAt;
}
