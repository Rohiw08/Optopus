class FlowEntity {
  final String id;
  final String collectionId;
  final String name;
  final Map<String, dynamic> data;
  final DateTime createdAt;
  final DateTime updatedAt;

  const FlowEntity({
    required this.id,
    required this.collectionId,
    required this.name,
    this.data = const {},
    required this.createdAt,
    required this.updatedAt,
  });
}
