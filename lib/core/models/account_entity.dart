// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
part 'account_entity.freezed.dart';
part 'account_entity.g.dart';

@freezed
abstract class AccountEntity with _$AccountEntity {
  const factory AccountEntity({
    required String id,
    // The unique @handle
    String? username,
    @JsonKey(name: 'full_name') required String displayName,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
    // New Postman-style fields
    String? bio,
    String? website,
    String? location,
    @JsonKey(name: 'twitter_handle') String? twitterHandle,
    @JsonKey(name: 'github_handle') String? githubHandle,
    // Existing fields
    String? role,
    String? email,
    @Default({}) Map<String, dynamic> preferences,
    @JsonKey(name: 'created_at') String? createdAt,
  }) = _AccountEntity;

  factory AccountEntity.fromJson(Map<String, dynamic> json) =>
      _$AccountEntityFromJson(json);
}
