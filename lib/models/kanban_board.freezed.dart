// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'kanban_board.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$KanbanBoard {

 String get id; String get title; List<KanbanList> get lists;
/// Create a copy of KanbanBoard
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$KanbanBoardCopyWith<KanbanBoard> get copyWith => _$KanbanBoardCopyWithImpl<KanbanBoard>(this as KanbanBoard, _$identity);

  /// Serializes this KanbanBoard to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is KanbanBoard&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&const DeepCollectionEquality().equals(other.lists, lists));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,const DeepCollectionEquality().hash(lists));

@override
String toString() {
  return 'KanbanBoard(id: $id, title: $title, lists: $lists)';
}


}

/// @nodoc
abstract mixin class $KanbanBoardCopyWith<$Res>  {
  factory $KanbanBoardCopyWith(KanbanBoard value, $Res Function(KanbanBoard) _then) = _$KanbanBoardCopyWithImpl;
@useResult
$Res call({
 String id, String title, List<KanbanList> lists
});




}
/// @nodoc
class _$KanbanBoardCopyWithImpl<$Res>
    implements $KanbanBoardCopyWith<$Res> {
  _$KanbanBoardCopyWithImpl(this._self, this._then);

  final KanbanBoard _self;
  final $Res Function(KanbanBoard) _then;

/// Create a copy of KanbanBoard
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? lists = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,lists: null == lists ? _self.lists : lists // ignore: cast_nullable_to_non_nullable
as List<KanbanList>,
  ));
}

}


/// Adds pattern-matching-related methods to [KanbanBoard].
extension KanbanBoardPatterns on KanbanBoard {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _KanbanBoard value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _KanbanBoard() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _KanbanBoard value)  $default,){
final _that = this;
switch (_that) {
case _KanbanBoard():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _KanbanBoard value)?  $default,){
final _that = this;
switch (_that) {
case _KanbanBoard() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  List<KanbanList> lists)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _KanbanBoard() when $default != null:
return $default(_that.id,_that.title,_that.lists);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  List<KanbanList> lists)  $default,) {final _that = this;
switch (_that) {
case _KanbanBoard():
return $default(_that.id,_that.title,_that.lists);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  List<KanbanList> lists)?  $default,) {final _that = this;
switch (_that) {
case _KanbanBoard() when $default != null:
return $default(_that.id,_that.title,_that.lists);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _KanbanBoard implements KanbanBoard {
  const _KanbanBoard({required this.id, required this.title, final  List<KanbanList> lists = const []}): _lists = lists;
  factory _KanbanBoard.fromJson(Map<String, dynamic> json) => _$KanbanBoardFromJson(json);

@override final  String id;
@override final  String title;
 final  List<KanbanList> _lists;
@override@JsonKey() List<KanbanList> get lists {
  if (_lists is EqualUnmodifiableListView) return _lists;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_lists);
}


/// Create a copy of KanbanBoard
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$KanbanBoardCopyWith<_KanbanBoard> get copyWith => __$KanbanBoardCopyWithImpl<_KanbanBoard>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$KanbanBoardToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _KanbanBoard&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&const DeepCollectionEquality().equals(other._lists, _lists));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,const DeepCollectionEquality().hash(_lists));

@override
String toString() {
  return 'KanbanBoard(id: $id, title: $title, lists: $lists)';
}


}

/// @nodoc
abstract mixin class _$KanbanBoardCopyWith<$Res> implements $KanbanBoardCopyWith<$Res> {
  factory _$KanbanBoardCopyWith(_KanbanBoard value, $Res Function(_KanbanBoard) _then) = __$KanbanBoardCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, List<KanbanList> lists
});




}
/// @nodoc
class __$KanbanBoardCopyWithImpl<$Res>
    implements _$KanbanBoardCopyWith<$Res> {
  __$KanbanBoardCopyWithImpl(this._self, this._then);

  final _KanbanBoard _self;
  final $Res Function(_KanbanBoard) _then;

/// Create a copy of KanbanBoard
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? lists = null,}) {
  return _then(_KanbanBoard(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,lists: null == lists ? _self._lists : lists // ignore: cast_nullable_to_non_nullable
as List<KanbanList>,
  ));
}


}

// dart format on
