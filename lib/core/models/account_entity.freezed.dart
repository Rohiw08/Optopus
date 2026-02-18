// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'account_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AccountEntity {

 String get id;// The unique @handle
 String? get username;@JsonKey(name: 'full_name') String get displayName;@JsonKey(name: 'avatar_url') String? get avatarUrl;// New Postman-style fields
 String? get bio; String? get website; String? get location;@JsonKey(name: 'twitter_handle') String? get twitterHandle;@JsonKey(name: 'github_handle') String? get githubHandle;// Existing fields
 String? get role; String? get email; Map<String, dynamic> get preferences;@JsonKey(name: 'created_at') String? get createdAt;
/// Create a copy of AccountEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AccountEntityCopyWith<AccountEntity> get copyWith => _$AccountEntityCopyWithImpl<AccountEntity>(this as AccountEntity, _$identity);

  /// Serializes this AccountEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AccountEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.username, username) || other.username == username)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.bio, bio) || other.bio == bio)&&(identical(other.website, website) || other.website == website)&&(identical(other.location, location) || other.location == location)&&(identical(other.twitterHandle, twitterHandle) || other.twitterHandle == twitterHandle)&&(identical(other.githubHandle, githubHandle) || other.githubHandle == githubHandle)&&(identical(other.role, role) || other.role == role)&&(identical(other.email, email) || other.email == email)&&const DeepCollectionEquality().equals(other.preferences, preferences)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,username,displayName,avatarUrl,bio,website,location,twitterHandle,githubHandle,role,email,const DeepCollectionEquality().hash(preferences),createdAt);

@override
String toString() {
  return 'AccountEntity(id: $id, username: $username, displayName: $displayName, avatarUrl: $avatarUrl, bio: $bio, website: $website, location: $location, twitterHandle: $twitterHandle, githubHandle: $githubHandle, role: $role, email: $email, preferences: $preferences, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $AccountEntityCopyWith<$Res>  {
  factory $AccountEntityCopyWith(AccountEntity value, $Res Function(AccountEntity) _then) = _$AccountEntityCopyWithImpl;
@useResult
$Res call({
 String id, String? username,@JsonKey(name: 'full_name') String displayName,@JsonKey(name: 'avatar_url') String? avatarUrl, String? bio, String? website, String? location,@JsonKey(name: 'twitter_handle') String? twitterHandle,@JsonKey(name: 'github_handle') String? githubHandle, String? role, String? email, Map<String, dynamic> preferences,@JsonKey(name: 'created_at') String? createdAt
});




}
/// @nodoc
class _$AccountEntityCopyWithImpl<$Res>
    implements $AccountEntityCopyWith<$Res> {
  _$AccountEntityCopyWithImpl(this._self, this._then);

  final AccountEntity _self;
  final $Res Function(AccountEntity) _then;

/// Create a copy of AccountEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? username = freezed,Object? displayName = null,Object? avatarUrl = freezed,Object? bio = freezed,Object? website = freezed,Object? location = freezed,Object? twitterHandle = freezed,Object? githubHandle = freezed,Object? role = freezed,Object? email = freezed,Object? preferences = null,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,username: freezed == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String?,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,bio: freezed == bio ? _self.bio : bio // ignore: cast_nullable_to_non_nullable
as String?,website: freezed == website ? _self.website : website // ignore: cast_nullable_to_non_nullable
as String?,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String?,twitterHandle: freezed == twitterHandle ? _self.twitterHandle : twitterHandle // ignore: cast_nullable_to_non_nullable
as String?,githubHandle: freezed == githubHandle ? _self.githubHandle : githubHandle // ignore: cast_nullable_to_non_nullable
as String?,role: freezed == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,preferences: null == preferences ? _self.preferences : preferences // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [AccountEntity].
extension AccountEntityPatterns on AccountEntity {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AccountEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AccountEntity() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AccountEntity value)  $default,){
final _that = this;
switch (_that) {
case _AccountEntity():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AccountEntity value)?  $default,){
final _that = this;
switch (_that) {
case _AccountEntity() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String? username, @JsonKey(name: 'full_name')  String displayName, @JsonKey(name: 'avatar_url')  String? avatarUrl,  String? bio,  String? website,  String? location, @JsonKey(name: 'twitter_handle')  String? twitterHandle, @JsonKey(name: 'github_handle')  String? githubHandle,  String? role,  String? email,  Map<String, dynamic> preferences, @JsonKey(name: 'created_at')  String? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AccountEntity() when $default != null:
return $default(_that.id,_that.username,_that.displayName,_that.avatarUrl,_that.bio,_that.website,_that.location,_that.twitterHandle,_that.githubHandle,_that.role,_that.email,_that.preferences,_that.createdAt);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String? username, @JsonKey(name: 'full_name')  String displayName, @JsonKey(name: 'avatar_url')  String? avatarUrl,  String? bio,  String? website,  String? location, @JsonKey(name: 'twitter_handle')  String? twitterHandle, @JsonKey(name: 'github_handle')  String? githubHandle,  String? role,  String? email,  Map<String, dynamic> preferences, @JsonKey(name: 'created_at')  String? createdAt)  $default,) {final _that = this;
switch (_that) {
case _AccountEntity():
return $default(_that.id,_that.username,_that.displayName,_that.avatarUrl,_that.bio,_that.website,_that.location,_that.twitterHandle,_that.githubHandle,_that.role,_that.email,_that.preferences,_that.createdAt);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String? username, @JsonKey(name: 'full_name')  String displayName, @JsonKey(name: 'avatar_url')  String? avatarUrl,  String? bio,  String? website,  String? location, @JsonKey(name: 'twitter_handle')  String? twitterHandle, @JsonKey(name: 'github_handle')  String? githubHandle,  String? role,  String? email,  Map<String, dynamic> preferences, @JsonKey(name: 'created_at')  String? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _AccountEntity() when $default != null:
return $default(_that.id,_that.username,_that.displayName,_that.avatarUrl,_that.bio,_that.website,_that.location,_that.twitterHandle,_that.githubHandle,_that.role,_that.email,_that.preferences,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AccountEntity implements AccountEntity {
  const _AccountEntity({required this.id, this.username, @JsonKey(name: 'full_name') required this.displayName, @JsonKey(name: 'avatar_url') this.avatarUrl, this.bio, this.website, this.location, @JsonKey(name: 'twitter_handle') this.twitterHandle, @JsonKey(name: 'github_handle') this.githubHandle, this.role, this.email, final  Map<String, dynamic> preferences = const {}, @JsonKey(name: 'created_at') this.createdAt}): _preferences = preferences;
  factory _AccountEntity.fromJson(Map<String, dynamic> json) => _$AccountEntityFromJson(json);

@override final  String id;
// The unique @handle
@override final  String? username;
@override@JsonKey(name: 'full_name') final  String displayName;
@override@JsonKey(name: 'avatar_url') final  String? avatarUrl;
// New Postman-style fields
@override final  String? bio;
@override final  String? website;
@override final  String? location;
@override@JsonKey(name: 'twitter_handle') final  String? twitterHandle;
@override@JsonKey(name: 'github_handle') final  String? githubHandle;
// Existing fields
@override final  String? role;
@override final  String? email;
 final  Map<String, dynamic> _preferences;
@override@JsonKey() Map<String, dynamic> get preferences {
  if (_preferences is EqualUnmodifiableMapView) return _preferences;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_preferences);
}

@override@JsonKey(name: 'created_at') final  String? createdAt;

/// Create a copy of AccountEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AccountEntityCopyWith<_AccountEntity> get copyWith => __$AccountEntityCopyWithImpl<_AccountEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AccountEntityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AccountEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.username, username) || other.username == username)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.bio, bio) || other.bio == bio)&&(identical(other.website, website) || other.website == website)&&(identical(other.location, location) || other.location == location)&&(identical(other.twitterHandle, twitterHandle) || other.twitterHandle == twitterHandle)&&(identical(other.githubHandle, githubHandle) || other.githubHandle == githubHandle)&&(identical(other.role, role) || other.role == role)&&(identical(other.email, email) || other.email == email)&&const DeepCollectionEquality().equals(other._preferences, _preferences)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,username,displayName,avatarUrl,bio,website,location,twitterHandle,githubHandle,role,email,const DeepCollectionEquality().hash(_preferences),createdAt);

@override
String toString() {
  return 'AccountEntity(id: $id, username: $username, displayName: $displayName, avatarUrl: $avatarUrl, bio: $bio, website: $website, location: $location, twitterHandle: $twitterHandle, githubHandle: $githubHandle, role: $role, email: $email, preferences: $preferences, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$AccountEntityCopyWith<$Res> implements $AccountEntityCopyWith<$Res> {
  factory _$AccountEntityCopyWith(_AccountEntity value, $Res Function(_AccountEntity) _then) = __$AccountEntityCopyWithImpl;
@override @useResult
$Res call({
 String id, String? username,@JsonKey(name: 'full_name') String displayName,@JsonKey(name: 'avatar_url') String? avatarUrl, String? bio, String? website, String? location,@JsonKey(name: 'twitter_handle') String? twitterHandle,@JsonKey(name: 'github_handle') String? githubHandle, String? role, String? email, Map<String, dynamic> preferences,@JsonKey(name: 'created_at') String? createdAt
});




}
/// @nodoc
class __$AccountEntityCopyWithImpl<$Res>
    implements _$AccountEntityCopyWith<$Res> {
  __$AccountEntityCopyWithImpl(this._self, this._then);

  final _AccountEntity _self;
  final $Res Function(_AccountEntity) _then;

/// Create a copy of AccountEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? username = freezed,Object? displayName = null,Object? avatarUrl = freezed,Object? bio = freezed,Object? website = freezed,Object? location = freezed,Object? twitterHandle = freezed,Object? githubHandle = freezed,Object? role = freezed,Object? email = freezed,Object? preferences = null,Object? createdAt = freezed,}) {
  return _then(_AccountEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,username: freezed == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String?,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,bio: freezed == bio ? _self.bio : bio // ignore: cast_nullable_to_non_nullable
as String?,website: freezed == website ? _self.website : website // ignore: cast_nullable_to_non_nullable
as String?,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String?,twitterHandle: freezed == twitterHandle ? _self.twitterHandle : twitterHandle // ignore: cast_nullable_to_non_nullable
as String?,githubHandle: freezed == githubHandle ? _self.githubHandle : githubHandle // ignore: cast_nullable_to_non_nullable
as String?,role: freezed == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,preferences: null == preferences ? _self._preferences : preferences // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
