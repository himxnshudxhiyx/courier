// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'request_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RequestEditorState {

 ApiRequest get request;/// Set when the request was opened from (or saved to) a collection.
 String? get savedRequestId; String? get savedRequestName;
/// Create a copy of RequestEditorState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RequestEditorStateCopyWith<RequestEditorState> get copyWith => _$RequestEditorStateCopyWithImpl<RequestEditorState>(this as RequestEditorState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as RequestEditorState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RequestEditorState&&(identical(other.request, _this.request) || other.request == _this.request)&&(identical(other.savedRequestId, _this.savedRequestId) || other.savedRequestId == _this.savedRequestId)&&(identical(other.savedRequestName, _this.savedRequestName) || other.savedRequestName == _this.savedRequestName));
}


@override
int get hashCode {
  final _this = this as RequestEditorState;
  return Object.hash(runtimeType,_this.request,_this.savedRequestId,_this.savedRequestName);
}

@override
String toString() {
  final _this = this as RequestEditorState;
  return 'RequestEditorState(request: ${_this.request}, savedRequestId: ${_this.savedRequestId}, savedRequestName: ${_this.savedRequestName})';
}


}

/// @nodoc
abstract mixin class $RequestEditorStateCopyWith<$Res>  {
  factory $RequestEditorStateCopyWith(RequestEditorState value, $Res Function(RequestEditorState) _then) = _$RequestEditorStateCopyWithImpl;
@useResult
$Res call({
 ApiRequest request, String? savedRequestId, String? savedRequestName
});


$ApiRequestCopyWith<$Res> get request;

}
/// @nodoc
class _$RequestEditorStateCopyWithImpl<$Res>
    implements $RequestEditorStateCopyWith<$Res> {
  _$RequestEditorStateCopyWithImpl(this._self, this._then);

  final RequestEditorState _self;
  final $Res Function(RequestEditorState) _then;

/// Create a copy of RequestEditorState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? request = null,Object? savedRequestId = freezed,Object? savedRequestName = freezed,}) {
  return _then(RequestEditorState(
request: null == request ? _self.request : request // ignore: cast_nullable_to_non_nullable
as ApiRequest,savedRequestId: freezed == savedRequestId ? _self.savedRequestId : savedRequestId // ignore: cast_nullable_to_non_nullable
as String?,savedRequestName: freezed == savedRequestName ? _self.savedRequestName : savedRequestName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of RequestEditorState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ApiRequestCopyWith<$Res> get request {
  
  return $ApiRequestCopyWith<$Res>(_self.request, (value) {
    return _then(_self.copyWith(request: value));
  });
}
}


/// Adds pattern-matching-related methods to [RequestEditorState].
extension RequestEditorStatePatterns on RequestEditorState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RequestEditorState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RequestEditorState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RequestEditorState value)  $default,){
final _that = this;
switch (_that) {
case _RequestEditorState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RequestEditorState value)?  $default,){
final _that = this;
switch (_that) {
case _RequestEditorState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ApiRequest request,  String? savedRequestId,  String? savedRequestName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RequestEditorState() when $default != null:
return $default(_that.request,_that.savedRequestId,_that.savedRequestName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ApiRequest request,  String? savedRequestId,  String? savedRequestName)  $default,) {final _that = this;
switch (_that) {
case _RequestEditorState():
return $default(_that.request,_that.savedRequestId,_that.savedRequestName);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ApiRequest request,  String? savedRequestId,  String? savedRequestName)?  $default,) {final _that = this;
switch (_that) {
case _RequestEditorState() when $default != null:
return $default(_that.request,_that.savedRequestId,_that.savedRequestName);case _:
  return null;

}
}

}

/// @nodoc


class _RequestEditorState implements RequestEditorState {
  const _RequestEditorState({this.request = const ApiRequest(), this.savedRequestId, this.savedRequestName});
  

@override@JsonKey() final  ApiRequest request;
/// Set when the request was opened from (or saved to) a collection.
@override final  String? savedRequestId;
@override final  String? savedRequestName;

/// Create a copy of RequestEditorState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RequestEditorStateCopyWith<_RequestEditorState> get copyWith => __$RequestEditorStateCopyWithImpl<_RequestEditorState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _RequestEditorState&&(identical(other.request, request) || other.request == request)&&(identical(other.savedRequestId, savedRequestId) || other.savedRequestId == savedRequestId)&&(identical(other.savedRequestName, savedRequestName) || other.savedRequestName == savedRequestName));
}


@override
int get hashCode {
    return Object.hash(runtimeType,request,savedRequestId,savedRequestName);
}

@override
String toString() {
    return 'RequestEditorState(request: $request, savedRequestId: $savedRequestId, savedRequestName: $savedRequestName)';
}


}

/// @nodoc
abstract mixin class _$RequestEditorStateCopyWith<$Res> implements $RequestEditorStateCopyWith<$Res> {
  factory _$RequestEditorStateCopyWith(_RequestEditorState value, $Res Function(_RequestEditorState) _then) = __$RequestEditorStateCopyWithImpl;
@override @useResult
$Res call({
 ApiRequest request, String? savedRequestId, String? savedRequestName
});


@override $ApiRequestCopyWith<$Res> get request;

}
/// @nodoc
class __$RequestEditorStateCopyWithImpl<$Res>
    implements _$RequestEditorStateCopyWith<$Res> {
  __$RequestEditorStateCopyWithImpl(this._self, this._then);

  final _RequestEditorState _self;
  final $Res Function(_RequestEditorState) _then;

/// Create a copy of RequestEditorState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? request = null,Object? savedRequestId = freezed,Object? savedRequestName = freezed,}) {
  return _then(_RequestEditorState(
request: null == request ? _self.request : request // ignore: cast_nullable_to_non_nullable
as ApiRequest,savedRequestId: freezed == savedRequestId ? _self.savedRequestId : savedRequestId // ignore: cast_nullable_to_non_nullable
as String?,savedRequestName: freezed == savedRequestName ? _self.savedRequestName : savedRequestName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of RequestEditorState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ApiRequestCopyWith<$Res> get request {
  
  return $ApiRequestCopyWith<$Res>(_self.request, (value) {
    return _then(_self.copyWith(request: value));
  });
}
}

/// @nodoc
mixin _$SendState {

 bool get isSending; ApiResponse? get response;/// The request that produced [response].
 ApiRequest? get request; Failure? get failure;
/// Create a copy of SendState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SendStateCopyWith<SendState> get copyWith => _$SendStateCopyWithImpl<SendState>(this as SendState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as SendState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SendState&&(identical(other.isSending, _this.isSending) || other.isSending == _this.isSending)&&(identical(other.response, _this.response) || other.response == _this.response)&&(identical(other.request, _this.request) || other.request == _this.request)&&(identical(other.failure, _this.failure) || other.failure == _this.failure));
}


@override
int get hashCode {
  final _this = this as SendState;
  return Object.hash(runtimeType,_this.isSending,_this.response,_this.request,_this.failure);
}

@override
String toString() {
  final _this = this as SendState;
  return 'SendState(isSending: ${_this.isSending}, response: ${_this.response}, request: ${_this.request}, failure: ${_this.failure})';
}


}

/// @nodoc
abstract mixin class $SendStateCopyWith<$Res>  {
  factory $SendStateCopyWith(SendState value, $Res Function(SendState) _then) = _$SendStateCopyWithImpl;
@useResult
$Res call({
 bool isSending, ApiResponse? response, ApiRequest? request, Failure? failure
});


$ApiResponseCopyWith<$Res>? get response;$ApiRequestCopyWith<$Res>? get request;

}
/// @nodoc
class _$SendStateCopyWithImpl<$Res>
    implements $SendStateCopyWith<$Res> {
  _$SendStateCopyWithImpl(this._self, this._then);

  final SendState _self;
  final $Res Function(SendState) _then;

/// Create a copy of SendState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isSending = null,Object? response = freezed,Object? request = freezed,Object? failure = freezed,}) {
  return _then(SendState(
isSending: null == isSending ? _self.isSending : isSending // ignore: cast_nullable_to_non_nullable
as bool,response: freezed == response ? _self.response : response // ignore: cast_nullable_to_non_nullable
as ApiResponse?,request: freezed == request ? _self.request : request // ignore: cast_nullable_to_non_nullable
as ApiRequest?,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}
/// Create a copy of SendState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ApiResponseCopyWith<$Res>? get response {
    if (_self.response == null) {
    return null;
  }

  return $ApiResponseCopyWith<$Res>(_self.response!, (value) {
    return _then(_self.copyWith(response: value));
  });
}/// Create a copy of SendState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ApiRequestCopyWith<$Res>? get request {
    if (_self.request == null) {
    return null;
  }

  return $ApiRequestCopyWith<$Res>(_self.request!, (value) {
    return _then(_self.copyWith(request: value));
  });
}
}


/// Adds pattern-matching-related methods to [SendState].
extension SendStatePatterns on SendState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SendState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SendState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SendState value)  $default,){
final _that = this;
switch (_that) {
case _SendState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SendState value)?  $default,){
final _that = this;
switch (_that) {
case _SendState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isSending,  ApiResponse? response,  ApiRequest? request,  Failure? failure)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SendState() when $default != null:
return $default(_that.isSending,_that.response,_that.request,_that.failure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isSending,  ApiResponse? response,  ApiRequest? request,  Failure? failure)  $default,) {final _that = this;
switch (_that) {
case _SendState():
return $default(_that.isSending,_that.response,_that.request,_that.failure);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isSending,  ApiResponse? response,  ApiRequest? request,  Failure? failure)?  $default,) {final _that = this;
switch (_that) {
case _SendState() when $default != null:
return $default(_that.isSending,_that.response,_that.request,_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class _SendState implements SendState {
  const _SendState({this.isSending = false, this.response, this.request, this.failure});
  

@override@JsonKey() final  bool isSending;
@override final  ApiResponse? response;
/// The request that produced [response].
@override final  ApiRequest? request;
@override final  Failure? failure;

/// Create a copy of SendState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SendStateCopyWith<_SendState> get copyWith => __$SendStateCopyWithImpl<_SendState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SendState&&(identical(other.isSending, isSending) || other.isSending == isSending)&&(identical(other.response, response) || other.response == response)&&(identical(other.request, request) || other.request == request)&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode {
    return Object.hash(runtimeType,isSending,response,request,failure);
}

@override
String toString() {
    return 'SendState(isSending: $isSending, response: $response, request: $request, failure: $failure)';
}


}

/// @nodoc
abstract mixin class _$SendStateCopyWith<$Res> implements $SendStateCopyWith<$Res> {
  factory _$SendStateCopyWith(_SendState value, $Res Function(_SendState) _then) = __$SendStateCopyWithImpl;
@override @useResult
$Res call({
 bool isSending, ApiResponse? response, ApiRequest? request, Failure? failure
});


@override $ApiResponseCopyWith<$Res>? get response;@override $ApiRequestCopyWith<$Res>? get request;

}
/// @nodoc
class __$SendStateCopyWithImpl<$Res>
    implements _$SendStateCopyWith<$Res> {
  __$SendStateCopyWithImpl(this._self, this._then);

  final _SendState _self;
  final $Res Function(_SendState) _then;

/// Create a copy of SendState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isSending = null,Object? response = freezed,Object? request = freezed,Object? failure = freezed,}) {
  return _then(_SendState(
isSending: null == isSending ? _self.isSending : isSending // ignore: cast_nullable_to_non_nullable
as bool,response: freezed == response ? _self.response : response // ignore: cast_nullable_to_non_nullable
as ApiResponse?,request: freezed == request ? _self.request : request // ignore: cast_nullable_to_non_nullable
as ApiRequest?,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}

/// Create a copy of SendState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ApiResponseCopyWith<$Res>? get response {
    if (_self.response == null) {
    return null;
  }

  return $ApiResponseCopyWith<$Res>(_self.response!, (value) {
    return _then(_self.copyWith(response: value));
  });
}/// Create a copy of SendState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ApiRequestCopyWith<$Res>? get request {
    if (_self.request == null) {
    return null;
  }

  return $ApiRequestCopyWith<$Res>(_self.request!, (value) {
    return _then(_self.copyWith(request: value));
  });
}
}

// dart format on
