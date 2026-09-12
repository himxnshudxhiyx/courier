// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'api_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ApiResponse {

 int get statusCode; String get reasonPhrase; Map<String, String> get headers; String get body; int get durationMs; int? get ttfbMs; int get sizeBytes;/// Raw bytes, kept in memory only (used to preview images).
 Uint8List? get bytes; bool get bodyTruncated; String get requestUrl; String get requestMethod; Map<String, String> get requestHeaders; String? get requestBody; List<String> get redirects;
/// Create a copy of ApiResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ApiResponseCopyWith<ApiResponse> get copyWith => _$ApiResponseCopyWithImpl<ApiResponse>(this as ApiResponse, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ApiResponse;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ApiResponse&&(identical(other.statusCode, _this.statusCode) || other.statusCode == _this.statusCode)&&(identical(other.reasonPhrase, _this.reasonPhrase) || other.reasonPhrase == _this.reasonPhrase)&&const DeepCollectionEquality().equals(other.headers, _this.headers)&&(identical(other.body, _this.body) || other.body == _this.body)&&(identical(other.durationMs, _this.durationMs) || other.durationMs == _this.durationMs)&&(identical(other.ttfbMs, _this.ttfbMs) || other.ttfbMs == _this.ttfbMs)&&(identical(other.sizeBytes, _this.sizeBytes) || other.sizeBytes == _this.sizeBytes)&&const DeepCollectionEquality().equals(other.bytes, _this.bytes)&&(identical(other.bodyTruncated, _this.bodyTruncated) || other.bodyTruncated == _this.bodyTruncated)&&(identical(other.requestUrl, _this.requestUrl) || other.requestUrl == _this.requestUrl)&&(identical(other.requestMethod, _this.requestMethod) || other.requestMethod == _this.requestMethod)&&const DeepCollectionEquality().equals(other.requestHeaders, _this.requestHeaders)&&(identical(other.requestBody, _this.requestBody) || other.requestBody == _this.requestBody)&&const DeepCollectionEquality().equals(other.redirects, _this.redirects));
}


@override
int get hashCode {
  final _this = this as ApiResponse;
  return Object.hash(runtimeType,_this.statusCode,_this.reasonPhrase,const DeepCollectionEquality().hash(_this.headers),_this.body,_this.durationMs,_this.ttfbMs,_this.sizeBytes,const DeepCollectionEquality().hash(_this.bytes),_this.bodyTruncated,_this.requestUrl,_this.requestMethod,const DeepCollectionEquality().hash(_this.requestHeaders),_this.requestBody,const DeepCollectionEquality().hash(_this.redirects));
}

@override
String toString() {
  final _this = this as ApiResponse;
  return 'ApiResponse(statusCode: ${_this.statusCode}, reasonPhrase: ${_this.reasonPhrase}, headers: ${_this.headers}, body: ${_this.body}, durationMs: ${_this.durationMs}, ttfbMs: ${_this.ttfbMs}, sizeBytes: ${_this.sizeBytes}, bytes: ${_this.bytes}, bodyTruncated: ${_this.bodyTruncated}, requestUrl: ${_this.requestUrl}, requestMethod: ${_this.requestMethod}, requestHeaders: ${_this.requestHeaders}, requestBody: ${_this.requestBody}, redirects: ${_this.redirects})';
}


}

/// @nodoc
abstract mixin class $ApiResponseCopyWith<$Res>  {
  factory $ApiResponseCopyWith(ApiResponse value, $Res Function(ApiResponse) _then) = _$ApiResponseCopyWithImpl;
@useResult
$Res call({
 int statusCode, String reasonPhrase, Map<String, String> headers, String body, int durationMs, int? ttfbMs, int sizeBytes, Uint8List? bytes, bool bodyTruncated, String requestUrl, String requestMethod, Map<String, String> requestHeaders, String? requestBody, List<String> redirects
});




}
/// @nodoc
class _$ApiResponseCopyWithImpl<$Res>
    implements $ApiResponseCopyWith<$Res> {
  _$ApiResponseCopyWithImpl(this._self, this._then);

  final ApiResponse _self;
  final $Res Function(ApiResponse) _then;

/// Create a copy of ApiResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? statusCode = null,Object? reasonPhrase = null,Object? headers = null,Object? body = null,Object? durationMs = null,Object? ttfbMs = freezed,Object? sizeBytes = null,Object? bytes = freezed,Object? bodyTruncated = null,Object? requestUrl = null,Object? requestMethod = null,Object? requestHeaders = null,Object? requestBody = freezed,Object? redirects = null,}) {
  return _then(ApiResponse(
statusCode: null == statusCode ? _self.statusCode : statusCode // ignore: cast_nullable_to_non_nullable
as int,reasonPhrase: null == reasonPhrase ? _self.reasonPhrase : reasonPhrase // ignore: cast_nullable_to_non_nullable
as String,headers: null == headers ? _self.headers : headers // ignore: cast_nullable_to_non_nullable
as Map<String, String>,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,durationMs: null == durationMs ? _self.durationMs : durationMs // ignore: cast_nullable_to_non_nullable
as int,ttfbMs: freezed == ttfbMs ? _self.ttfbMs : ttfbMs // ignore: cast_nullable_to_non_nullable
as int?,sizeBytes: null == sizeBytes ? _self.sizeBytes : sizeBytes // ignore: cast_nullable_to_non_nullable
as int,bytes: freezed == bytes ? _self.bytes : bytes // ignore: cast_nullable_to_non_nullable
as Uint8List?,bodyTruncated: null == bodyTruncated ? _self.bodyTruncated : bodyTruncated // ignore: cast_nullable_to_non_nullable
as bool,requestUrl: null == requestUrl ? _self.requestUrl : requestUrl // ignore: cast_nullable_to_non_nullable
as String,requestMethod: null == requestMethod ? _self.requestMethod : requestMethod // ignore: cast_nullable_to_non_nullable
as String,requestHeaders: null == requestHeaders ? _self.requestHeaders : requestHeaders // ignore: cast_nullable_to_non_nullable
as Map<String, String>,requestBody: freezed == requestBody ? _self.requestBody : requestBody // ignore: cast_nullable_to_non_nullable
as String?,redirects: null == redirects ? _self.redirects : redirects // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [ApiResponse].
extension ApiResponsePatterns on ApiResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ApiResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ApiResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ApiResponse value)  $default,){
final _that = this;
switch (_that) {
case _ApiResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ApiResponse value)?  $default,){
final _that = this;
switch (_that) {
case _ApiResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int statusCode,  String reasonPhrase,  Map<String, String> headers,  String body,  int durationMs,  int? ttfbMs,  int sizeBytes,  Uint8List? bytes,  bool bodyTruncated,  String requestUrl,  String requestMethod,  Map<String, String> requestHeaders,  String? requestBody,  List<String> redirects)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ApiResponse() when $default != null:
return $default(_that.statusCode,_that.reasonPhrase,_that.headers,_that.body,_that.durationMs,_that.ttfbMs,_that.sizeBytes,_that.bytes,_that.bodyTruncated,_that.requestUrl,_that.requestMethod,_that.requestHeaders,_that.requestBody,_that.redirects);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int statusCode,  String reasonPhrase,  Map<String, String> headers,  String body,  int durationMs,  int? ttfbMs,  int sizeBytes,  Uint8List? bytes,  bool bodyTruncated,  String requestUrl,  String requestMethod,  Map<String, String> requestHeaders,  String? requestBody,  List<String> redirects)  $default,) {final _that = this;
switch (_that) {
case _ApiResponse():
return $default(_that.statusCode,_that.reasonPhrase,_that.headers,_that.body,_that.durationMs,_that.ttfbMs,_that.sizeBytes,_that.bytes,_that.bodyTruncated,_that.requestUrl,_that.requestMethod,_that.requestHeaders,_that.requestBody,_that.redirects);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int statusCode,  String reasonPhrase,  Map<String, String> headers,  String body,  int durationMs,  int? ttfbMs,  int sizeBytes,  Uint8List? bytes,  bool bodyTruncated,  String requestUrl,  String requestMethod,  Map<String, String> requestHeaders,  String? requestBody,  List<String> redirects)?  $default,) {final _that = this;
switch (_that) {
case _ApiResponse() when $default != null:
return $default(_that.statusCode,_that.reasonPhrase,_that.headers,_that.body,_that.durationMs,_that.ttfbMs,_that.sizeBytes,_that.bytes,_that.bodyTruncated,_that.requestUrl,_that.requestMethod,_that.requestHeaders,_that.requestBody,_that.redirects);case _:
  return null;

}
}

}

/// @nodoc


class _ApiResponse extends ApiResponse {
  const _ApiResponse({required this.statusCode, this.reasonPhrase = '',  Map<String, String> headers = const {}, this.body = '', required this.durationMs, this.ttfbMs, required this.sizeBytes, this.bytes, this.bodyTruncated = false, required this.requestUrl, required this.requestMethod,  Map<String, String> requestHeaders = const {}, this.requestBody,  List<String> redirects = const []}): _headers = headers,_requestHeaders = requestHeaders,_redirects = redirects,super._();
  

@override final  int statusCode;
@override@JsonKey() final  String reasonPhrase;
 final  Map<String, String> _headers;
@override@JsonKey() Map<String, String> get headers {
  if (_headers is EqualUnmodifiableMapView) return _headers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_headers);
}

@override@JsonKey() final  String body;
@override final  int durationMs;
@override final  int? ttfbMs;
@override final  int sizeBytes;
/// Raw bytes, kept in memory only (used to preview images).
@override final  Uint8List? bytes;
@override@JsonKey() final  bool bodyTruncated;
@override final  String requestUrl;
@override final  String requestMethod;
 final  Map<String, String> _requestHeaders;
@override@JsonKey() Map<String, String> get requestHeaders {
  if (_requestHeaders is EqualUnmodifiableMapView) return _requestHeaders;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_requestHeaders);
}

@override final  String? requestBody;
 final  List<String> _redirects;
@override@JsonKey() List<String> get redirects {
  if (_redirects is EqualUnmodifiableListView) return _redirects;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_redirects);
}


/// Create a copy of ApiResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ApiResponseCopyWith<_ApiResponse> get copyWith => __$ApiResponseCopyWithImpl<_ApiResponse>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ApiResponse&&(identical(other.statusCode, statusCode) || other.statusCode == statusCode)&&(identical(other.reasonPhrase, reasonPhrase) || other.reasonPhrase == reasonPhrase)&&const DeepCollectionEquality().equals(other.headers, _headers)&&(identical(other.body, body) || other.body == body)&&(identical(other.durationMs, durationMs) || other.durationMs == durationMs)&&(identical(other.ttfbMs, ttfbMs) || other.ttfbMs == ttfbMs)&&(identical(other.sizeBytes, sizeBytes) || other.sizeBytes == sizeBytes)&&const DeepCollectionEquality().equals(other.bytes, bytes)&&(identical(other.bodyTruncated, bodyTruncated) || other.bodyTruncated == bodyTruncated)&&(identical(other.requestUrl, requestUrl) || other.requestUrl == requestUrl)&&(identical(other.requestMethod, requestMethod) || other.requestMethod == requestMethod)&&const DeepCollectionEquality().equals(other.requestHeaders, _requestHeaders)&&(identical(other.requestBody, requestBody) || other.requestBody == requestBody)&&const DeepCollectionEquality().equals(other.redirects, _redirects));
}


@override
int get hashCode {
    return Object.hash(runtimeType,statusCode,reasonPhrase,const DeepCollectionEquality().hash(_headers),body,durationMs,ttfbMs,sizeBytes,const DeepCollectionEquality().hash(bytes),bodyTruncated,requestUrl,requestMethod,const DeepCollectionEquality().hash(_requestHeaders),requestBody,const DeepCollectionEquality().hash(_redirects));
}

@override
String toString() {
    return 'ApiResponse(statusCode: $statusCode, reasonPhrase: $reasonPhrase, headers: $headers, body: $body, durationMs: $durationMs, ttfbMs: $ttfbMs, sizeBytes: $sizeBytes, bytes: $bytes, bodyTruncated: $bodyTruncated, requestUrl: $requestUrl, requestMethod: $requestMethod, requestHeaders: $requestHeaders, requestBody: $requestBody, redirects: $redirects)';
}


}

/// @nodoc
abstract mixin class _$ApiResponseCopyWith<$Res> implements $ApiResponseCopyWith<$Res> {
  factory _$ApiResponseCopyWith(_ApiResponse value, $Res Function(_ApiResponse) _then) = __$ApiResponseCopyWithImpl;
@override @useResult
$Res call({
 int statusCode, String reasonPhrase, Map<String, String> headers, String body, int durationMs, int? ttfbMs, int sizeBytes, Uint8List? bytes, bool bodyTruncated, String requestUrl, String requestMethod, Map<String, String> requestHeaders, String? requestBody, List<String> redirects
});




}
/// @nodoc
class __$ApiResponseCopyWithImpl<$Res>
    implements _$ApiResponseCopyWith<$Res> {
  __$ApiResponseCopyWithImpl(this._self, this._then);

  final _ApiResponse _self;
  final $Res Function(_ApiResponse) _then;

/// Create a copy of ApiResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? statusCode = null,Object? reasonPhrase = null,Object? headers = null,Object? body = null,Object? durationMs = null,Object? ttfbMs = freezed,Object? sizeBytes = null,Object? bytes = freezed,Object? bodyTruncated = null,Object? requestUrl = null,Object? requestMethod = null,Object? requestHeaders = null,Object? requestBody = freezed,Object? redirects = null,}) {
  return _then(_ApiResponse(
statusCode: null == statusCode ? _self.statusCode : statusCode // ignore: cast_nullable_to_non_nullable
as int,reasonPhrase: null == reasonPhrase ? _self.reasonPhrase : reasonPhrase // ignore: cast_nullable_to_non_nullable
as String,headers: null == headers ? _self._headers : headers // ignore: cast_nullable_to_non_nullable
as Map<String, String>,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,durationMs: null == durationMs ? _self.durationMs : durationMs // ignore: cast_nullable_to_non_nullable
as int,ttfbMs: freezed == ttfbMs ? _self.ttfbMs : ttfbMs // ignore: cast_nullable_to_non_nullable
as int?,sizeBytes: null == sizeBytes ? _self.sizeBytes : sizeBytes // ignore: cast_nullable_to_non_nullable
as int,bytes: freezed == bytes ? _self.bytes : bytes // ignore: cast_nullable_to_non_nullable
as Uint8List?,bodyTruncated: null == bodyTruncated ? _self.bodyTruncated : bodyTruncated // ignore: cast_nullable_to_non_nullable
as bool,requestUrl: null == requestUrl ? _self.requestUrl : requestUrl // ignore: cast_nullable_to_non_nullable
as String,requestMethod: null == requestMethod ? _self.requestMethod : requestMethod // ignore: cast_nullable_to_non_nullable
as String,requestHeaders: null == requestHeaders ? _self._requestHeaders : requestHeaders // ignore: cast_nullable_to_non_nullable
as Map<String, String>,requestBody: freezed == requestBody ? _self.requestBody : requestBody // ignore: cast_nullable_to_non_nullable
as String?,redirects: null == redirects ? _self._redirects : redirects // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
