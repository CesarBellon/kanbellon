// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'kanban_card.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$KanbanCard {

 String get id; String get title; String get description;// Base64 encoded image string. 
// In a real app, this would likely be a file path or URL.
@JsonKey(name: 'image_base64') String? get imageBase64;
/// Create a copy of KanbanCard
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$KanbanCardCopyWith<KanbanCard> get copyWith => _$KanbanCardCopyWithImpl<KanbanCard>(this as KanbanCard, _$identity);

  /// Serializes this KanbanCard to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is KanbanCard&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.imageBase64, imageBase64) || other.imageBase64 == imageBase64));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,description,imageBase64);

@override
String toString() {
  return 'KanbanCard(id: $id, title: $title, description: $description, imageBase64: $imageBase64)';
}


}

/// @nodoc
abstract mixin class $KanbanCardCopyWith<$Res>  {
  factory $KanbanCardCopyWith(KanbanCard value, $Res Function(KanbanCard) _then) = _$KanbanCardCopyWithImpl;
@useResult
$Res call({
 String id, String title, String description,@JsonKey(name: 'image_base64') String? imageBase64
});




}
/// @nodoc
class _$KanbanCardCopyWithImpl<$Res>
    implements $KanbanCardCopyWith<$Res> {
  _$KanbanCardCopyWithImpl(this._self, this._then);

  final KanbanCard _self;
  final $Res Function(KanbanCard) _then;

/// Create a copy of KanbanCard
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? description = null,Object? imageBase64 = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,imageBase64: freezed == imageBase64 ? _self.imageBase64 : imageBase64 // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [KanbanCard].
extension KanbanCardPatterns on KanbanCard {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _KanbanCard value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _KanbanCard() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _KanbanCard value)  $default,){
final _that = this;
switch (_that) {
case _KanbanCard():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _KanbanCard value)?  $default,){
final _that = this;
switch (_that) {
case _KanbanCard() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String description, @JsonKey(name: 'image_base64')  String? imageBase64)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _KanbanCard() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.imageBase64);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String description, @JsonKey(name: 'image_base64')  String? imageBase64)  $default,) {final _that = this;
switch (_that) {
case _KanbanCard():
return $default(_that.id,_that.title,_that.description,_that.imageBase64);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String description, @JsonKey(name: 'image_base64')  String? imageBase64)?  $default,) {final _that = this;
switch (_that) {
case _KanbanCard() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.imageBase64);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _KanbanCard implements KanbanCard {
  const _KanbanCard({required this.id, required this.title, this.description = '', @JsonKey(name: 'image_base64') this.imageBase64});
  factory _KanbanCard.fromJson(Map<String, dynamic> json) => _$KanbanCardFromJson(json);

@override final  String id;
@override final  String title;
@override@JsonKey() final  String description;
// Base64 encoded image string. 
// In a real app, this would likely be a file path or URL.
@override@JsonKey(name: 'image_base64') final  String? imageBase64;

/// Create a copy of KanbanCard
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$KanbanCardCopyWith<_KanbanCard> get copyWith => __$KanbanCardCopyWithImpl<_KanbanCard>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$KanbanCardToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _KanbanCard&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.imageBase64, imageBase64) || other.imageBase64 == imageBase64));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,description,imageBase64);

@override
String toString() {
  return 'KanbanCard(id: $id, title: $title, description: $description, imageBase64: $imageBase64)';
}


}

/// @nodoc
abstract mixin class _$KanbanCardCopyWith<$Res> implements $KanbanCardCopyWith<$Res> {
  factory _$KanbanCardCopyWith(_KanbanCard value, $Res Function(_KanbanCard) _then) = __$KanbanCardCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String description,@JsonKey(name: 'image_base64') String? imageBase64
});




}
/// @nodoc
class __$KanbanCardCopyWithImpl<$Res>
    implements _$KanbanCardCopyWith<$Res> {
  __$KanbanCardCopyWithImpl(this._self, this._then);

  final _KanbanCard _self;
  final $Res Function(_KanbanCard) _then;

/// Create a copy of KanbanCard
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? description = null,Object? imageBase64 = freezed,}) {
  return _then(_KanbanCard(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,imageBase64: freezed == imageBase64 ? _self.imageBase64 : imageBase64 // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
