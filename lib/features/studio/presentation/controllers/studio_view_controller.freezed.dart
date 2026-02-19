// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'studio_view_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$StudioViewState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StudioViewState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'StudioViewState()';
}


}

/// @nodoc
class $StudioViewStateCopyWith<$Res>  {
$StudioViewStateCopyWith(StudioViewState _, $Res Function(StudioViewState) __);
}


/// Adds pattern-matching-related methods to [StudioViewState].
extension StudioViewStatePatterns on StudioViewState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( StudioViewEmpty value)?  empty,TResult Function( StudioViewDashboard value)?  dashboard,TResult Function( StudioViewEditor value)?  editor,required TResult orElse(),}){
final _that = this;
switch (_that) {
case StudioViewEmpty() when empty != null:
return empty(_that);case StudioViewDashboard() when dashboard != null:
return dashboard(_that);case StudioViewEditor() when editor != null:
return editor(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( StudioViewEmpty value)  empty,required TResult Function( StudioViewDashboard value)  dashboard,required TResult Function( StudioViewEditor value)  editor,}){
final _that = this;
switch (_that) {
case StudioViewEmpty():
return empty(_that);case StudioViewDashboard():
return dashboard(_that);case StudioViewEditor():
return editor(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( StudioViewEmpty value)?  empty,TResult? Function( StudioViewDashboard value)?  dashboard,TResult? Function( StudioViewEditor value)?  editor,}){
final _that = this;
switch (_that) {
case StudioViewEmpty() when empty != null:
return empty(_that);case StudioViewDashboard() when dashboard != null:
return dashboard(_that);case StudioViewEditor() when editor != null:
return editor(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  empty,TResult Function( String workspaceId)?  dashboard,TResult Function( String flowId)?  editor,required TResult orElse(),}) {final _that = this;
switch (_that) {
case StudioViewEmpty() when empty != null:
return empty();case StudioViewDashboard() when dashboard != null:
return dashboard(_that.workspaceId);case StudioViewEditor() when editor != null:
return editor(_that.flowId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  empty,required TResult Function( String workspaceId)  dashboard,required TResult Function( String flowId)  editor,}) {final _that = this;
switch (_that) {
case StudioViewEmpty():
return empty();case StudioViewDashboard():
return dashboard(_that.workspaceId);case StudioViewEditor():
return editor(_that.flowId);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  empty,TResult? Function( String workspaceId)?  dashboard,TResult? Function( String flowId)?  editor,}) {final _that = this;
switch (_that) {
case StudioViewEmpty() when empty != null:
return empty();case StudioViewDashboard() when dashboard != null:
return dashboard(_that.workspaceId);case StudioViewEditor() when editor != null:
return editor(_that.flowId);case _:
  return null;

}
}

}

/// @nodoc


class StudioViewEmpty implements StudioViewState {
  const StudioViewEmpty();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StudioViewEmpty);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'StudioViewState.empty()';
}


}




/// @nodoc


class StudioViewDashboard implements StudioViewState {
  const StudioViewDashboard(this.workspaceId);
  

 final  String workspaceId;

/// Create a copy of StudioViewState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StudioViewDashboardCopyWith<StudioViewDashboard> get copyWith => _$StudioViewDashboardCopyWithImpl<StudioViewDashboard>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StudioViewDashboard&&(identical(other.workspaceId, workspaceId) || other.workspaceId == workspaceId));
}


@override
int get hashCode => Object.hash(runtimeType,workspaceId);

@override
String toString() {
  return 'StudioViewState.dashboard(workspaceId: $workspaceId)';
}


}

/// @nodoc
abstract mixin class $StudioViewDashboardCopyWith<$Res> implements $StudioViewStateCopyWith<$Res> {
  factory $StudioViewDashboardCopyWith(StudioViewDashboard value, $Res Function(StudioViewDashboard) _then) = _$StudioViewDashboardCopyWithImpl;
@useResult
$Res call({
 String workspaceId
});




}
/// @nodoc
class _$StudioViewDashboardCopyWithImpl<$Res>
    implements $StudioViewDashboardCopyWith<$Res> {
  _$StudioViewDashboardCopyWithImpl(this._self, this._then);

  final StudioViewDashboard _self;
  final $Res Function(StudioViewDashboard) _then;

/// Create a copy of StudioViewState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? workspaceId = null,}) {
  return _then(StudioViewDashboard(
null == workspaceId ? _self.workspaceId : workspaceId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class StudioViewEditor implements StudioViewState {
  const StudioViewEditor(this.flowId);
  

 final  String flowId;

/// Create a copy of StudioViewState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StudioViewEditorCopyWith<StudioViewEditor> get copyWith => _$StudioViewEditorCopyWithImpl<StudioViewEditor>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StudioViewEditor&&(identical(other.flowId, flowId) || other.flowId == flowId));
}


@override
int get hashCode => Object.hash(runtimeType,flowId);

@override
String toString() {
  return 'StudioViewState.editor(flowId: $flowId)';
}


}

/// @nodoc
abstract mixin class $StudioViewEditorCopyWith<$Res> implements $StudioViewStateCopyWith<$Res> {
  factory $StudioViewEditorCopyWith(StudioViewEditor value, $Res Function(StudioViewEditor) _then) = _$StudioViewEditorCopyWithImpl;
@useResult
$Res call({
 String flowId
});




}
/// @nodoc
class _$StudioViewEditorCopyWithImpl<$Res>
    implements $StudioViewEditorCopyWith<$Res> {
  _$StudioViewEditorCopyWithImpl(this._self, this._then);

  final StudioViewEditor _self;
  final $Res Function(StudioViewEditor) _then;

/// Create a copy of StudioViewState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? flowId = null,}) {
  return _then(StudioViewEditor(
null == flowId ? _self.flowId : flowId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
