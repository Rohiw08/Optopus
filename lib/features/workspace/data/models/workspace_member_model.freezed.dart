// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'workspace_member_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WorkspaceMemberModel {

 String get id;@JsonKey(name: 'workspace_id') String get workspaceId;@JsonKey(name: 'user_id') String get userId; WorkspaceRole get role;@JsonKey(name: 'joined_at') DateTime get joinedAt; AccountEntity? get profile;
/// Create a copy of WorkspaceMemberModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WorkspaceMemberModelCopyWith<WorkspaceMemberModel> get copyWith => _$WorkspaceMemberModelCopyWithImpl<WorkspaceMemberModel>(this as WorkspaceMemberModel, _$identity);

  /// Serializes this WorkspaceMemberModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WorkspaceMemberModel&&(identical(other.id, id) || other.id == id)&&(identical(other.workspaceId, workspaceId) || other.workspaceId == workspaceId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.role, role) || other.role == role)&&(identical(other.joinedAt, joinedAt) || other.joinedAt == joinedAt)&&(identical(other.profile, profile) || other.profile == profile));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,workspaceId,userId,role,joinedAt,profile);

@override
String toString() {
  return 'WorkspaceMemberModel(id: $id, workspaceId: $workspaceId, userId: $userId, role: $role, joinedAt: $joinedAt, profile: $profile)';
}


}

/// @nodoc
abstract mixin class $WorkspaceMemberModelCopyWith<$Res>  {
  factory $WorkspaceMemberModelCopyWith(WorkspaceMemberModel value, $Res Function(WorkspaceMemberModel) _then) = _$WorkspaceMemberModelCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'workspace_id') String workspaceId,@JsonKey(name: 'user_id') String userId, WorkspaceRole role,@JsonKey(name: 'joined_at') DateTime joinedAt, AccountEntity? profile
});


$AccountEntityCopyWith<$Res>? get profile;

}
/// @nodoc
class _$WorkspaceMemberModelCopyWithImpl<$Res>
    implements $WorkspaceMemberModelCopyWith<$Res> {
  _$WorkspaceMemberModelCopyWithImpl(this._self, this._then);

  final WorkspaceMemberModel _self;
  final $Res Function(WorkspaceMemberModel) _then;

/// Create a copy of WorkspaceMemberModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? workspaceId = null,Object? userId = null,Object? role = null,Object? joinedAt = null,Object? profile = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,workspaceId: null == workspaceId ? _self.workspaceId : workspaceId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as WorkspaceRole,joinedAt: null == joinedAt ? _self.joinedAt : joinedAt // ignore: cast_nullable_to_non_nullable
as DateTime,profile: freezed == profile ? _self.profile : profile // ignore: cast_nullable_to_non_nullable
as AccountEntity?,
  ));
}
/// Create a copy of WorkspaceMemberModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AccountEntityCopyWith<$Res>? get profile {
    if (_self.profile == null) {
    return null;
  }

  return $AccountEntityCopyWith<$Res>(_self.profile!, (value) {
    return _then(_self.copyWith(profile: value));
  });
}
}


/// Adds pattern-matching-related methods to [WorkspaceMemberModel].
extension WorkspaceMemberModelPatterns on WorkspaceMemberModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WorkspaceMemberModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WorkspaceMemberModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WorkspaceMemberModel value)  $default,){
final _that = this;
switch (_that) {
case _WorkspaceMemberModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WorkspaceMemberModel value)?  $default,){
final _that = this;
switch (_that) {
case _WorkspaceMemberModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'workspace_id')  String workspaceId, @JsonKey(name: 'user_id')  String userId,  WorkspaceRole role, @JsonKey(name: 'joined_at')  DateTime joinedAt,  AccountEntity? profile)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WorkspaceMemberModel() when $default != null:
return $default(_that.id,_that.workspaceId,_that.userId,_that.role,_that.joinedAt,_that.profile);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'workspace_id')  String workspaceId, @JsonKey(name: 'user_id')  String userId,  WorkspaceRole role, @JsonKey(name: 'joined_at')  DateTime joinedAt,  AccountEntity? profile)  $default,) {final _that = this;
switch (_that) {
case _WorkspaceMemberModel():
return $default(_that.id,_that.workspaceId,_that.userId,_that.role,_that.joinedAt,_that.profile);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'workspace_id')  String workspaceId, @JsonKey(name: 'user_id')  String userId,  WorkspaceRole role, @JsonKey(name: 'joined_at')  DateTime joinedAt,  AccountEntity? profile)?  $default,) {final _that = this;
switch (_that) {
case _WorkspaceMemberModel() when $default != null:
return $default(_that.id,_that.workspaceId,_that.userId,_that.role,_that.joinedAt,_that.profile);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WorkspaceMemberModel extends WorkspaceMemberModel {
  const _WorkspaceMemberModel({required this.id, @JsonKey(name: 'workspace_id') required this.workspaceId, @JsonKey(name: 'user_id') required this.userId, required this.role, @JsonKey(name: 'joined_at') required this.joinedAt, this.profile}): super._();
  factory _WorkspaceMemberModel.fromJson(Map<String, dynamic> json) => _$WorkspaceMemberModelFromJson(json);

@override final  String id;
@override@JsonKey(name: 'workspace_id') final  String workspaceId;
@override@JsonKey(name: 'user_id') final  String userId;
@override final  WorkspaceRole role;
@override@JsonKey(name: 'joined_at') final  DateTime joinedAt;
@override final  AccountEntity? profile;

/// Create a copy of WorkspaceMemberModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WorkspaceMemberModelCopyWith<_WorkspaceMemberModel> get copyWith => __$WorkspaceMemberModelCopyWithImpl<_WorkspaceMemberModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WorkspaceMemberModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WorkspaceMemberModel&&(identical(other.id, id) || other.id == id)&&(identical(other.workspaceId, workspaceId) || other.workspaceId == workspaceId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.role, role) || other.role == role)&&(identical(other.joinedAt, joinedAt) || other.joinedAt == joinedAt)&&(identical(other.profile, profile) || other.profile == profile));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,workspaceId,userId,role,joinedAt,profile);

@override
String toString() {
  return 'WorkspaceMemberModel(id: $id, workspaceId: $workspaceId, userId: $userId, role: $role, joinedAt: $joinedAt, profile: $profile)';
}


}

/// @nodoc
abstract mixin class _$WorkspaceMemberModelCopyWith<$Res> implements $WorkspaceMemberModelCopyWith<$Res> {
  factory _$WorkspaceMemberModelCopyWith(_WorkspaceMemberModel value, $Res Function(_WorkspaceMemberModel) _then) = __$WorkspaceMemberModelCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'workspace_id') String workspaceId,@JsonKey(name: 'user_id') String userId, WorkspaceRole role,@JsonKey(name: 'joined_at') DateTime joinedAt, AccountEntity? profile
});


@override $AccountEntityCopyWith<$Res>? get profile;

}
/// @nodoc
class __$WorkspaceMemberModelCopyWithImpl<$Res>
    implements _$WorkspaceMemberModelCopyWith<$Res> {
  __$WorkspaceMemberModelCopyWithImpl(this._self, this._then);

  final _WorkspaceMemberModel _self;
  final $Res Function(_WorkspaceMemberModel) _then;

/// Create a copy of WorkspaceMemberModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? workspaceId = null,Object? userId = null,Object? role = null,Object? joinedAt = null,Object? profile = freezed,}) {
  return _then(_WorkspaceMemberModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,workspaceId: null == workspaceId ? _self.workspaceId : workspaceId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as WorkspaceRole,joinedAt: null == joinedAt ? _self.joinedAt : joinedAt // ignore: cast_nullable_to_non_nullable
as DateTime,profile: freezed == profile ? _self.profile : profile // ignore: cast_nullable_to_non_nullable
as AccountEntity?,
  ));
}

/// Create a copy of WorkspaceMemberModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AccountEntityCopyWith<$Res>? get profile {
    if (_self.profile == null) {
    return null;
  }

  return $AccountEntityCopyWith<$Res>(_self.profile!, (value) {
    return _then(_self.copyWith(profile: value));
  });
}
}

// dart format on
