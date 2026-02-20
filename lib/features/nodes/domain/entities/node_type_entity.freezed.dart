// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'node_type_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$NodeTypeEntity {

 String get type; String get description; String get domain;@JsonKey(name: 'can_connect') bool get canConnect;
/// Create a copy of NodeTypeEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NodeTypeEntityCopyWith<NodeTypeEntity> get copyWith => _$NodeTypeEntityCopyWithImpl<NodeTypeEntity>(this as NodeTypeEntity, _$identity);

  /// Serializes this NodeTypeEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NodeTypeEntity&&(identical(other.type, type) || other.type == type)&&(identical(other.description, description) || other.description == description)&&(identical(other.domain, domain) || other.domain == domain)&&(identical(other.canConnect, canConnect) || other.canConnect == canConnect));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,description,domain,canConnect);

@override
String toString() {
  return 'NodeTypeEntity(type: $type, description: $description, domain: $domain, canConnect: $canConnect)';
}


}

/// @nodoc
abstract mixin class $NodeTypeEntityCopyWith<$Res>  {
  factory $NodeTypeEntityCopyWith(NodeTypeEntity value, $Res Function(NodeTypeEntity) _then) = _$NodeTypeEntityCopyWithImpl;
@useResult
$Res call({
 String type, String description, String domain,@JsonKey(name: 'can_connect') bool canConnect
});




}
/// @nodoc
class _$NodeTypeEntityCopyWithImpl<$Res>
    implements $NodeTypeEntityCopyWith<$Res> {
  _$NodeTypeEntityCopyWithImpl(this._self, this._then);

  final NodeTypeEntity _self;
  final $Res Function(NodeTypeEntity) _then;

/// Create a copy of NodeTypeEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? description = null,Object? domain = null,Object? canConnect = null,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,domain: null == domain ? _self.domain : domain // ignore: cast_nullable_to_non_nullable
as String,canConnect: null == canConnect ? _self.canConnect : canConnect // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [NodeTypeEntity].
extension NodeTypeEntityPatterns on NodeTypeEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NodeTypeEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NodeTypeEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NodeTypeEntity value)  $default,){
final _that = this;
switch (_that) {
case _NodeTypeEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NodeTypeEntity value)?  $default,){
final _that = this;
switch (_that) {
case _NodeTypeEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String type,  String description,  String domain, @JsonKey(name: 'can_connect')  bool canConnect)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NodeTypeEntity() when $default != null:
return $default(_that.type,_that.description,_that.domain,_that.canConnect);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String type,  String description,  String domain, @JsonKey(name: 'can_connect')  bool canConnect)  $default,) {final _that = this;
switch (_that) {
case _NodeTypeEntity():
return $default(_that.type,_that.description,_that.domain,_that.canConnect);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String type,  String description,  String domain, @JsonKey(name: 'can_connect')  bool canConnect)?  $default,) {final _that = this;
switch (_that) {
case _NodeTypeEntity() when $default != null:
return $default(_that.type,_that.description,_that.domain,_that.canConnect);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NodeTypeEntity implements NodeTypeEntity {
  const _NodeTypeEntity({required this.type, required this.description, required this.domain, @JsonKey(name: 'can_connect') required this.canConnect});
  factory _NodeTypeEntity.fromJson(Map<String, dynamic> json) => _$NodeTypeEntityFromJson(json);

@override final  String type;
@override final  String description;
@override final  String domain;
@override@JsonKey(name: 'can_connect') final  bool canConnect;

/// Create a copy of NodeTypeEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NodeTypeEntityCopyWith<_NodeTypeEntity> get copyWith => __$NodeTypeEntityCopyWithImpl<_NodeTypeEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NodeTypeEntityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NodeTypeEntity&&(identical(other.type, type) || other.type == type)&&(identical(other.description, description) || other.description == description)&&(identical(other.domain, domain) || other.domain == domain)&&(identical(other.canConnect, canConnect) || other.canConnect == canConnect));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,description,domain,canConnect);

@override
String toString() {
  return 'NodeTypeEntity(type: $type, description: $description, domain: $domain, canConnect: $canConnect)';
}


}

/// @nodoc
abstract mixin class _$NodeTypeEntityCopyWith<$Res> implements $NodeTypeEntityCopyWith<$Res> {
  factory _$NodeTypeEntityCopyWith(_NodeTypeEntity value, $Res Function(_NodeTypeEntity) _then) = __$NodeTypeEntityCopyWithImpl;
@override @useResult
$Res call({
 String type, String description, String domain,@JsonKey(name: 'can_connect') bool canConnect
});




}
/// @nodoc
class __$NodeTypeEntityCopyWithImpl<$Res>
    implements _$NodeTypeEntityCopyWith<$Res> {
  __$NodeTypeEntityCopyWithImpl(this._self, this._then);

  final _NodeTypeEntity _self;
  final $Res Function(_NodeTypeEntity) _then;

/// Create a copy of NodeTypeEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? description = null,Object? domain = null,Object? canConnect = null,}) {
  return _then(_NodeTypeEntity(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,domain: null == domain ? _self.domain : domain // ignore: cast_nullable_to_non_nullable
as String,canConnect: null == canConnect ? _self.canConnect : canConnect // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
