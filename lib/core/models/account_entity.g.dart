// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AccountEntity _$AccountEntityFromJson(Map<String, dynamic> json) =>
    _AccountEntity(
      id: json['id'] as String,
      username: json['username'] as String?,
      displayName: json['full_name'] as String,
      avatarUrl: json['avatar_url'] as String?,
      bio: json['bio'] as String?,
      website: json['website'] as String?,
      location: json['location'] as String?,
      twitterHandle: json['twitter_handle'] as String?,
      githubHandle: json['github_handle'] as String?,
      role: json['role'] as String?,
      email: json['email'] as String?,
      preferences: json['preferences'] as Map<String, dynamic>? ?? const {},
      createdAt: json['created_at'] as String?,
    );

Map<String, dynamic> _$AccountEntityToJson(_AccountEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'full_name': instance.displayName,
      'avatar_url': instance.avatarUrl,
      'bio': instance.bio,
      'website': instance.website,
      'location': instance.location,
      'twitter_handle': instance.twitterHandle,
      'github_handle': instance.githubHandle,
      'role': instance.role,
      'email': instance.email,
      'preferences': instance.preferences,
      'created_at': instance.createdAt,
    };
