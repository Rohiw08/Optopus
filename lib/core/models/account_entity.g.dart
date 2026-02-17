// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AccountEntity _$AccountEntityFromJson(Map<String, dynamic> json) =>
    _AccountEntity(
      id: json['id'] as String,
      email: json['email'] as String,
      displayName: json['displayName'] as String,
      avatarUrl: json['avatarUrl'] as String?,
      preferences: json['preferences'] as Map<String, dynamic>? ?? const {},
      planType: json['planType'] as String? ?? 'free',
    );

Map<String, dynamic> _$AccountEntityToJson(_AccountEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'displayName': instance.displayName,
      'avatarUrl': instance.avatarUrl,
      'preferences': instance.preferences,
      'planType': instance.planType,
    };
