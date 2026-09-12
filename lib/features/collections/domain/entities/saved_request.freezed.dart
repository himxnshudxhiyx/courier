// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'saved_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SavedRequest {

 String get id; String get name; String get folder; ApiRequest get request; DateTime get updatedAt;
/// Create a copy of SavedRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SavedRequestCopyWith<SavedRequest> get copyWith => _$SavedRequestCopyWithImpl<SavedRequest>(this as SavedRequest, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as SavedRequest;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SavedRequest&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.folder, _this.folder) || other.folder == _this.folder)&&(identical(other.request, _this.request) || other.request == _this.request)&&(identical(other.updatedAt, _this.updatedAt) || other.updatedAt == _this.updatedAt));
}


@override
int get hashCode {
  final _this = this as SavedRequest;
  return Object.hash(runtimeType,_this.id,_this.name,_this.folder,_this.request,_this.updatedAt);
}

@override
String toString() {
  final _this = this as SavedRequest;
  return 'SavedRequest(id: ${_this.id}, name: ${_this.name}, folder: ${_this.folder}, request: ${_this.request}, updatedAt: ${_this.updatedAt})';
}


}

/// @nodoc
abstract mixin class $SavedRequestCopyWith<$Res>  {
  factory $SavedRequestCopyWith(SavedRequest value, $Res Function(SavedRequest) _then) = _$SavedRequestCopyWithImpl;
@useResult
$Res call({
 String id, String name, String folder, ApiRequest request, DateTime updatedAt
});


$ApiRequestCopyWith<$Res> get request;

}
/// @nodoc
class _$SavedRequestCopyWithImpl<$Res>
    implements $SavedRequestCopyWith<$Res> {
  _$SavedRequestCopyWithImpl(this._self, this._then);

  final SavedRequest _self;
  final $Res Function(SavedRequest) _then;

/// Create a copy of SavedRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? folder = null,Object? request = null,Object? updatedAt = null,}) {
  return _then(SavedRequest(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,folder: null == folder ? _self.folder : folder // ignore: cast_nullable_to_non_nullable
as String,request: null == request ? _self.request : request // ignore: cast_nullable_to_non_nullable
as ApiRequest,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}
/// Create a copy of SavedRequest
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ApiRequestCopyWith<$Res> get request {
  
  return $ApiRequestCopyWith<$Res>(_self.request, (value) {
    return _then(_self.copyWith(request: value));
  });
}
}


/// Adds pattern-matching-related methods to [SavedRequest].
extension SavedRequestPatterns on SavedRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SavedRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SavedRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SavedRequest value)  $default,){
final _that = this;
switch (_that) {
case _SavedRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SavedRequest value)?  $default,){
final _that = this;
switch (_that) {
case _SavedRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String folder,  ApiRequest request,  DateTime updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SavedRequest() when $default != null:
return $default(_that.id,_that.name,_that.folder,_that.request,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String folder,  ApiRequest request,  DateTime updatedAt)  $default,) {final _that = this;
switch (_that) {
case _SavedRequest():
return $default(_that.id,_that.name,_that.folder,_that.request,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String folder,  ApiRequest request,  DateTime updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _SavedRequest() when $default != null:
return $default(_that.id,_that.name,_that.folder,_that.request,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc


class _SavedRequest implements SavedRequest {
  const _SavedRequest({required this.id, required this.name, this.folder = '', required this.request, required this.updatedAt});
  

@override final  String id;
@override final  String name;
@override@JsonKey() final  String folder;
@override final  ApiRequest request;
@override final  DateTime updatedAt;

/// Create a copy of SavedRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SavedRequestCopyWith<_SavedRequest> get copyWith => __$SavedRequestCopyWithImpl<_SavedRequest>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SavedRequest&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.folder, folder) || other.folder == folder)&&(identical(other.request, request) || other.request == request)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,name,folder,request,updatedAt);
}

@override
String toString() {
    return 'SavedRequest(id: $id, name: $name, folder: $folder, request: $request, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$SavedRequestCopyWith<$Res> implements $SavedRequestCopyWith<$Res> {
  factory _$SavedRequestCopyWith(_SavedRequest value, $Res Function(_SavedRequest) _then) = __$SavedRequestCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String folder, ApiRequest request, DateTime updatedAt
});


@override $ApiRequestCopyWith<$Res> get request;

}
/// @nodoc
class __$SavedRequestCopyWithImpl<$Res>
    implements _$SavedRequestCopyWith<$Res> {
  __$SavedRequestCopyWithImpl(this._self, this._then);

  final _SavedRequest _self;
  final $Res Function(_SavedRequest) _then;

/// Create a copy of SavedRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? folder = null,Object? request = null,Object? updatedAt = null,}) {
  return _then(_SavedRequest(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,folder: null == folder ? _self.folder : folder // ignore: cast_nullable_to_non_nullable
as String,request: null == request ? _self.request : request // ignore: cast_nullable_to_non_nullable
as ApiRequest,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

/// Create a copy of SavedRequest
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ApiRequestCopyWith<$Res> get request {
  
  return $ApiRequestCopyWith<$Res>(_self.request, (value) {
    return _then(_self.copyWith(request: value));
  });
}
}

// dart format on
