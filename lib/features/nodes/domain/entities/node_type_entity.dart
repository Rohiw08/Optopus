import 'package:freezed_annotation/freezed_annotation.dart';

part 'node_type_entity.freezed.dart';
part 'node_type_entity.g.dart';

@freezed
abstract class NodeTypeEntity with _$NodeTypeEntity {
  const factory NodeTypeEntity({
    required String type,
    required String description,
    required String domain,
    @JsonKey(name: 'can_connect') required bool canConnect,
  }) = _NodeTypeEntity;

  factory NodeTypeEntity.fromJson(Map<String, dynamic> json) =>
      _$NodeTypeEntityFromJson(json);
}
