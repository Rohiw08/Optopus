import 'package:freezed_annotation/freezed_annotation.dart';

part 'account_entity.freezed.dart';
part 'account_entity.g.dart';

@freezed
abstract class AccountEntity with _$AccountEntity {
  const factory AccountEntity({
    required String id,
    required String email,
    required String displayName,
    String? avatarUrl,
    @Default({}) Map<String, dynamic> preferences,
    @Default('free') String planType,
  }) = _AccountEntity;

  factory AccountEntity.fromJson(Map<String, dynamic> json) =>
      _$AccountEntityFromJson(json);
}
