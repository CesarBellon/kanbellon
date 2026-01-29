// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'kanban_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$KanbanState {

 AppData get data; String? get selectedWorkspaceId; String? get selectedBoardId; bool get isLoading; bool get isConfigured;// Assume configured until checked
 String? get error;
/// Create a copy of KanbanState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$KanbanStateCopyWith<KanbanState> get copyWith => _$KanbanStateCopyWithImpl<KanbanState>(this as KanbanState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is KanbanState&&(identical(other.data, data) || other.data == data)&&(identical(other.selectedWorkspaceId, selectedWorkspaceId) || other.selectedWorkspaceId == selectedWorkspaceId)&&(identical(other.selectedBoardId, selectedBoardId) || other.selectedBoardId == selectedBoardId)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isConfigured, isConfigured) || other.isConfigured == isConfigured)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,data,selectedWorkspaceId,selectedBoardId,isLoading,isConfigured,error);

@override
String toString() {
  return 'KanbanState(data: $data, selectedWorkspaceId: $selectedWorkspaceId, selectedBoardId: $selectedBoardId, isLoading: $isLoading, isConfigured: $isConfigured, error: $error)';
}


}

/// @nodoc
abstract mixin class $KanbanStateCopyWith<$Res>  {
  factory $KanbanStateCopyWith(KanbanState value, $Res Function(KanbanState) _then) = _$KanbanStateCopyWithImpl;
@useResult
$Res call({
 AppData data, String? selectedWorkspaceId, String? selectedBoardId, bool isLoading, bool isConfigured, String? error
});


$AppDataCopyWith<$Res> get data;

}
/// @nodoc
class _$KanbanStateCopyWithImpl<$Res>
    implements $KanbanStateCopyWith<$Res> {
  _$KanbanStateCopyWithImpl(this._self, this._then);

  final KanbanState _self;
  final $Res Function(KanbanState) _then;

/// Create a copy of KanbanState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? data = null,Object? selectedWorkspaceId = freezed,Object? selectedBoardId = freezed,Object? isLoading = null,Object? isConfigured = null,Object? error = freezed,}) {
  return _then(_self.copyWith(
data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as AppData,selectedWorkspaceId: freezed == selectedWorkspaceId ? _self.selectedWorkspaceId : selectedWorkspaceId // ignore: cast_nullable_to_non_nullable
as String?,selectedBoardId: freezed == selectedBoardId ? _self.selectedBoardId : selectedBoardId // ignore: cast_nullable_to_non_nullable
as String?,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isConfigured: null == isConfigured ? _self.isConfigured : isConfigured // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of KanbanState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AppDataCopyWith<$Res> get data {
  
  return $AppDataCopyWith<$Res>(_self.data, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// Adds pattern-matching-related methods to [KanbanState].
extension KanbanStatePatterns on KanbanState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _KanbanState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _KanbanState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _KanbanState value)  $default,){
final _that = this;
switch (_that) {
case _KanbanState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _KanbanState value)?  $default,){
final _that = this;
switch (_that) {
case _KanbanState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( AppData data,  String? selectedWorkspaceId,  String? selectedBoardId,  bool isLoading,  bool isConfigured,  String? error)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _KanbanState() when $default != null:
return $default(_that.data,_that.selectedWorkspaceId,_that.selectedBoardId,_that.isLoading,_that.isConfigured,_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( AppData data,  String? selectedWorkspaceId,  String? selectedBoardId,  bool isLoading,  bool isConfigured,  String? error)  $default,) {final _that = this;
switch (_that) {
case _KanbanState():
return $default(_that.data,_that.selectedWorkspaceId,_that.selectedBoardId,_that.isLoading,_that.isConfigured,_that.error);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( AppData data,  String? selectedWorkspaceId,  String? selectedBoardId,  bool isLoading,  bool isConfigured,  String? error)?  $default,) {final _that = this;
switch (_that) {
case _KanbanState() when $default != null:
return $default(_that.data,_that.selectedWorkspaceId,_that.selectedBoardId,_that.isLoading,_that.isConfigured,_that.error);case _:
  return null;

}
}

}

/// @nodoc


class _KanbanState implements KanbanState {
  const _KanbanState({this.data = const AppData(), this.selectedWorkspaceId, this.selectedBoardId, this.isLoading = false, this.isConfigured = true, this.error});
  

@override@JsonKey() final  AppData data;
@override final  String? selectedWorkspaceId;
@override final  String? selectedBoardId;
@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool isConfigured;
// Assume configured until checked
@override final  String? error;

/// Create a copy of KanbanState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$KanbanStateCopyWith<_KanbanState> get copyWith => __$KanbanStateCopyWithImpl<_KanbanState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _KanbanState&&(identical(other.data, data) || other.data == data)&&(identical(other.selectedWorkspaceId, selectedWorkspaceId) || other.selectedWorkspaceId == selectedWorkspaceId)&&(identical(other.selectedBoardId, selectedBoardId) || other.selectedBoardId == selectedBoardId)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isConfigured, isConfigured) || other.isConfigured == isConfigured)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,data,selectedWorkspaceId,selectedBoardId,isLoading,isConfigured,error);

@override
String toString() {
  return 'KanbanState(data: $data, selectedWorkspaceId: $selectedWorkspaceId, selectedBoardId: $selectedBoardId, isLoading: $isLoading, isConfigured: $isConfigured, error: $error)';
}


}

/// @nodoc
abstract mixin class _$KanbanStateCopyWith<$Res> implements $KanbanStateCopyWith<$Res> {
  factory _$KanbanStateCopyWith(_KanbanState value, $Res Function(_KanbanState) _then) = __$KanbanStateCopyWithImpl;
@override @useResult
$Res call({
 AppData data, String? selectedWorkspaceId, String? selectedBoardId, bool isLoading, bool isConfigured, String? error
});


@override $AppDataCopyWith<$Res> get data;

}
/// @nodoc
class __$KanbanStateCopyWithImpl<$Res>
    implements _$KanbanStateCopyWith<$Res> {
  __$KanbanStateCopyWithImpl(this._self, this._then);

  final _KanbanState _self;
  final $Res Function(_KanbanState) _then;

/// Create a copy of KanbanState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? data = null,Object? selectedWorkspaceId = freezed,Object? selectedBoardId = freezed,Object? isLoading = null,Object? isConfigured = null,Object? error = freezed,}) {
  return _then(_KanbanState(
data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as AppData,selectedWorkspaceId: freezed == selectedWorkspaceId ? _self.selectedWorkspaceId : selectedWorkspaceId // ignore: cast_nullable_to_non_nullable
as String?,selectedBoardId: freezed == selectedBoardId ? _self.selectedBoardId : selectedBoardId // ignore: cast_nullable_to_non_nullable
as String?,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isConfigured: null == isConfigured ? _self.isConfigured : isConfigured // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of KanbanState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AppDataCopyWith<$Res> get data {
  
  return $AppDataCopyWith<$Res>(_self.data, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}

// dart format on
