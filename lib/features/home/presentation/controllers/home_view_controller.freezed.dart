// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_view_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$HomeViewState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeViewState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HomeViewState()';
}


}

/// @nodoc
class $HomeViewStateCopyWith<$Res>  {
$HomeViewStateCopyWith(HomeViewState _, $Res Function(HomeViewState) __);
}


/// Adds pattern-matching-related methods to [HomeViewState].
extension HomeViewStatePatterns on HomeViewState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( HomeViewEmpty value)?  empty,TResult Function( HomeViewDashboard value)?  dashboard,TResult Function( HomeViewEditor value)?  editor,required TResult orElse(),}){
final _that = this;
switch (_that) {
case HomeViewEmpty() when empty != null:
return empty(_that);case HomeViewDashboard() when dashboard != null:
return dashboard(_that);case HomeViewEditor() when editor != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( HomeViewEmpty value)  empty,required TResult Function( HomeViewDashboard value)  dashboard,required TResult Function( HomeViewEditor value)  editor,}){
final _that = this;
switch (_that) {
case HomeViewEmpty():
return empty(_that);case HomeViewDashboard():
return dashboard(_that);case HomeViewEditor():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( HomeViewEmpty value)?  empty,TResult? Function( HomeViewDashboard value)?  dashboard,TResult? Function( HomeViewEditor value)?  editor,}){
final _that = this;
switch (_that) {
case HomeViewEmpty() when empty != null:
return empty(_that);case HomeViewDashboard() when dashboard != null:
return dashboard(_that);case HomeViewEditor() when editor != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  empty,TResult Function( WorkspaceEntity workspace)?  dashboard,TResult Function( FlowEntity flow)?  editor,required TResult orElse(),}) {final _that = this;
switch (_that) {
case HomeViewEmpty() when empty != null:
return empty();case HomeViewDashboard() when dashboard != null:
return dashboard(_that.workspace);case HomeViewEditor() when editor != null:
return editor(_that.flow);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  empty,required TResult Function( WorkspaceEntity workspace)  dashboard,required TResult Function( FlowEntity flow)  editor,}) {final _that = this;
switch (_that) {
case HomeViewEmpty():
return empty();case HomeViewDashboard():
return dashboard(_that.workspace);case HomeViewEditor():
return editor(_that.flow);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  empty,TResult? Function( WorkspaceEntity workspace)?  dashboard,TResult? Function( FlowEntity flow)?  editor,}) {final _that = this;
switch (_that) {
case HomeViewEmpty() when empty != null:
return empty();case HomeViewDashboard() when dashboard != null:
return dashboard(_that.workspace);case HomeViewEditor() when editor != null:
return editor(_that.flow);case _:
  return null;

}
}

}

/// @nodoc


class HomeViewEmpty implements HomeViewState {
  const HomeViewEmpty();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeViewEmpty);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HomeViewState.empty()';
}


}




/// @nodoc


class HomeViewDashboard implements HomeViewState {
  const HomeViewDashboard(this.workspace);
  

 final  WorkspaceEntity workspace;

/// Create a copy of HomeViewState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HomeViewDashboardCopyWith<HomeViewDashboard> get copyWith => _$HomeViewDashboardCopyWithImpl<HomeViewDashboard>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeViewDashboard&&(identical(other.workspace, workspace) || other.workspace == workspace));
}


@override
int get hashCode => Object.hash(runtimeType,workspace);

@override
String toString() {
  return 'HomeViewState.dashboard(workspace: $workspace)';
}


}

/// @nodoc
abstract mixin class $HomeViewDashboardCopyWith<$Res> implements $HomeViewStateCopyWith<$Res> {
  factory $HomeViewDashboardCopyWith(HomeViewDashboard value, $Res Function(HomeViewDashboard) _then) = _$HomeViewDashboardCopyWithImpl;
@useResult
$Res call({
 WorkspaceEntity workspace
});




}
/// @nodoc
class _$HomeViewDashboardCopyWithImpl<$Res>
    implements $HomeViewDashboardCopyWith<$Res> {
  _$HomeViewDashboardCopyWithImpl(this._self, this._then);

  final HomeViewDashboard _self;
  final $Res Function(HomeViewDashboard) _then;

/// Create a copy of HomeViewState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? workspace = null,}) {
  return _then(HomeViewDashboard(
null == workspace ? _self.workspace : workspace // ignore: cast_nullable_to_non_nullable
as WorkspaceEntity,
  ));
}


}

/// @nodoc


class HomeViewEditor implements HomeViewState {
  const HomeViewEditor(this.flow);
  

 final  FlowEntity flow;

/// Create a copy of HomeViewState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HomeViewEditorCopyWith<HomeViewEditor> get copyWith => _$HomeViewEditorCopyWithImpl<HomeViewEditor>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeViewEditor&&(identical(other.flow, flow) || other.flow == flow));
}


@override
int get hashCode => Object.hash(runtimeType,flow);

@override
String toString() {
  return 'HomeViewState.editor(flow: $flow)';
}


}

/// @nodoc
abstract mixin class $HomeViewEditorCopyWith<$Res> implements $HomeViewStateCopyWith<$Res> {
  factory $HomeViewEditorCopyWith(HomeViewEditor value, $Res Function(HomeViewEditor) _then) = _$HomeViewEditorCopyWithImpl;
@useResult
$Res call({
 FlowEntity flow
});




}
/// @nodoc
class _$HomeViewEditorCopyWithImpl<$Res>
    implements $HomeViewEditorCopyWith<$Res> {
  _$HomeViewEditorCopyWithImpl(this._self, this._then);

  final HomeViewEditor _self;
  final $Res Function(HomeViewEditor) _then;

/// Create a copy of HomeViewState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? flow = null,}) {
  return _then(HomeViewEditor(
null == flow ? _self.flow : flow // ignore: cast_nullable_to_non_nullable
as FlowEntity,
  ));
}


}

// dart format on
