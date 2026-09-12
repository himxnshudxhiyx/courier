// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'api_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$KeyValuePair {

 String get id; String get key; String get value; bool get enabled;
/// Create a copy of KeyValuePair
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$KeyValuePairCopyWith<KeyValuePair> get copyWith => _$KeyValuePairCopyWithImpl<KeyValuePair>(this as KeyValuePair, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as KeyValuePair;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is KeyValuePair&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.key, _this.key) || other.key == _this.key)&&(identical(other.value, _this.value) || other.value == _this.value)&&(identical(other.enabled, _this.enabled) || other.enabled == _this.enabled));
}


@override
int get hashCode {
  final _this = this as KeyValuePair;
  return Object.hash(runtimeType,_this.id,_this.key,_this.value,_this.enabled);
}

@override
String toString() {
  final _this = this as KeyValuePair;
  return 'KeyValuePair(id: ${_this.id}, key: ${_this.key}, value: ${_this.value}, enabled: ${_this.enabled})';
}


}

/// @nodoc
abstract mixin class $KeyValuePairCopyWith<$Res>  {
  factory $KeyValuePairCopyWith(KeyValuePair value, $Res Function(KeyValuePair) _then) = _$KeyValuePairCopyWithImpl;
@useResult
$Res call({
 String id, String key, String value, bool enabled
});




}
/// @nodoc
class _$KeyValuePairCopyWithImpl<$Res>
    implements $KeyValuePairCopyWith<$Res> {
  _$KeyValuePairCopyWithImpl(this._self, this._then);

  final KeyValuePair _self;
  final $Res Function(KeyValuePair) _then;

/// Create a copy of KeyValuePair
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? key = null,Object? value = null,Object? enabled = null,}) {
  return _then(KeyValuePair(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [KeyValuePair].
extension KeyValuePairPatterns on KeyValuePair {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _KeyValuePair value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _KeyValuePair() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _KeyValuePair value)  $default,){
final _that = this;
switch (_that) {
case _KeyValuePair():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _KeyValuePair value)?  $default,){
final _that = this;
switch (_that) {
case _KeyValuePair() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String key,  String value,  bool enabled)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _KeyValuePair() when $default != null:
return $default(_that.id,_that.key,_that.value,_that.enabled);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String key,  String value,  bool enabled)  $default,) {final _that = this;
switch (_that) {
case _KeyValuePair():
return $default(_that.id,_that.key,_that.value,_that.enabled);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String key,  String value,  bool enabled)?  $default,) {final _that = this;
switch (_that) {
case _KeyValuePair() when $default != null:
return $default(_that.id,_that.key,_that.value,_that.enabled);case _:
  return null;

}
}

}

/// @nodoc


class _KeyValuePair extends KeyValuePair {
  const _KeyValuePair({required this.id, this.key = '', this.value = '', this.enabled = true}): super._();
  

@override final  String id;
@override@JsonKey() final  String key;
@override@JsonKey() final  String value;
@override@JsonKey() final  bool enabled;

/// Create a copy of KeyValuePair
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$KeyValuePairCopyWith<_KeyValuePair> get copyWith => __$KeyValuePairCopyWithImpl<_KeyValuePair>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _KeyValuePair&&(identical(other.id, id) || other.id == id)&&(identical(other.key, key) || other.key == key)&&(identical(other.value, value) || other.value == value)&&(identical(other.enabled, enabled) || other.enabled == enabled));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,key,value,enabled);
}

@override
String toString() {
    return 'KeyValuePair(id: $id, key: $key, value: $value, enabled: $enabled)';
}


}

/// @nodoc
abstract mixin class _$KeyValuePairCopyWith<$Res> implements $KeyValuePairCopyWith<$Res> {
  factory _$KeyValuePairCopyWith(_KeyValuePair value, $Res Function(_KeyValuePair) _then) = __$KeyValuePairCopyWithImpl;
@override @useResult
$Res call({
 String id, String key, String value, bool enabled
});




}
/// @nodoc
class __$KeyValuePairCopyWithImpl<$Res>
    implements _$KeyValuePairCopyWith<$Res> {
  __$KeyValuePairCopyWithImpl(this._self, this._then);

  final _KeyValuePair _self;
  final $Res Function(_KeyValuePair) _then;

/// Create a copy of KeyValuePair
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? key = null,Object? value = null,Object? enabled = null,}) {
  return _then(_KeyValuePair(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc
mixin _$AuthConfig {

 AuthType get type; String get token; String get username; String get password; String get apiKey; String get apiValue; bool get apiKeyInQuery;
/// Create a copy of AuthConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthConfigCopyWith<AuthConfig> get copyWith => _$AuthConfigCopyWithImpl<AuthConfig>(this as AuthConfig, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as AuthConfig;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthConfig&&(identical(other.type, _this.type) || other.type == _this.type)&&(identical(other.token, _this.token) || other.token == _this.token)&&(identical(other.username, _this.username) || other.username == _this.username)&&(identical(other.password, _this.password) || other.password == _this.password)&&(identical(other.apiKey, _this.apiKey) || other.apiKey == _this.apiKey)&&(identical(other.apiValue, _this.apiValue) || other.apiValue == _this.apiValue)&&(identical(other.apiKeyInQuery, _this.apiKeyInQuery) || other.apiKeyInQuery == _this.apiKeyInQuery));
}


@override
int get hashCode {
  final _this = this as AuthConfig;
  return Object.hash(runtimeType,_this.type,_this.token,_this.username,_this.password,_this.apiKey,_this.apiValue,_this.apiKeyInQuery);
}

@override
String toString() {
  final _this = this as AuthConfig;
  return 'AuthConfig(type: ${_this.type}, token: ${_this.token}, username: ${_this.username}, password: ${_this.password}, apiKey: ${_this.apiKey}, apiValue: ${_this.apiValue}, apiKeyInQuery: ${_this.apiKeyInQuery})';
}


}

/// @nodoc
abstract mixin class $AuthConfigCopyWith<$Res>  {
  factory $AuthConfigCopyWith(AuthConfig value, $Res Function(AuthConfig) _then) = _$AuthConfigCopyWithImpl;
@useResult
$Res call({
 AuthType type, String token, String username, String password, String apiKey, String apiValue, bool apiKeyInQuery
});




}
/// @nodoc
class _$AuthConfigCopyWithImpl<$Res>
    implements $AuthConfigCopyWith<$Res> {
  _$AuthConfigCopyWithImpl(this._self, this._then);

  final AuthConfig _self;
  final $Res Function(AuthConfig) _then;

/// Create a copy of AuthConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? token = null,Object? username = null,Object? password = null,Object? apiKey = null,Object? apiValue = null,Object? apiKeyInQuery = null,}) {
  return _then(AuthConfig(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as AuthType,token: null == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,apiKey: null == apiKey ? _self.apiKey : apiKey // ignore: cast_nullable_to_non_nullable
as String,apiValue: null == apiValue ? _self.apiValue : apiValue // ignore: cast_nullable_to_non_nullable
as String,apiKeyInQuery: null == apiKeyInQuery ? _self.apiKeyInQuery : apiKeyInQuery // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [AuthConfig].
extension AuthConfigPatterns on AuthConfig {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AuthConfig value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AuthConfig() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AuthConfig value)  $default,){
final _that = this;
switch (_that) {
case _AuthConfig():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AuthConfig value)?  $default,){
final _that = this;
switch (_that) {
case _AuthConfig() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( AuthType type,  String token,  String username,  String password,  String apiKey,  String apiValue,  bool apiKeyInQuery)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AuthConfig() when $default != null:
return $default(_that.type,_that.token,_that.username,_that.password,_that.apiKey,_that.apiValue,_that.apiKeyInQuery);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( AuthType type,  String token,  String username,  String password,  String apiKey,  String apiValue,  bool apiKeyInQuery)  $default,) {final _that = this;
switch (_that) {
case _AuthConfig():
return $default(_that.type,_that.token,_that.username,_that.password,_that.apiKey,_that.apiValue,_that.apiKeyInQuery);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( AuthType type,  String token,  String username,  String password,  String apiKey,  String apiValue,  bool apiKeyInQuery)?  $default,) {final _that = this;
switch (_that) {
case _AuthConfig() when $default != null:
return $default(_that.type,_that.token,_that.username,_that.password,_that.apiKey,_that.apiValue,_that.apiKeyInQuery);case _:
  return null;

}
}

}

/// @nodoc


class _AuthConfig implements AuthConfig {
  const _AuthConfig({this.type = AuthType.none, this.token = '', this.username = '', this.password = '', this.apiKey = '', this.apiValue = '', this.apiKeyInQuery = false});
  

@override@JsonKey() final  AuthType type;
@override@JsonKey() final  String token;
@override@JsonKey() final  String username;
@override@JsonKey() final  String password;
@override@JsonKey() final  String apiKey;
@override@JsonKey() final  String apiValue;
@override@JsonKey() final  bool apiKeyInQuery;

/// Create a copy of AuthConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AuthConfigCopyWith<_AuthConfig> get copyWith => __$AuthConfigCopyWithImpl<_AuthConfig>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AuthConfig&&(identical(other.type, type) || other.type == type)&&(identical(other.token, token) || other.token == token)&&(identical(other.username, username) || other.username == username)&&(identical(other.password, password) || other.password == password)&&(identical(other.apiKey, apiKey) || other.apiKey == apiKey)&&(identical(other.apiValue, apiValue) || other.apiValue == apiValue)&&(identical(other.apiKeyInQuery, apiKeyInQuery) || other.apiKeyInQuery == apiKeyInQuery));
}


@override
int get hashCode {
    return Object.hash(runtimeType,type,token,username,password,apiKey,apiValue,apiKeyInQuery);
}

@override
String toString() {
    return 'AuthConfig(type: $type, token: $token, username: $username, password: $password, apiKey: $apiKey, apiValue: $apiValue, apiKeyInQuery: $apiKeyInQuery)';
}


}

/// @nodoc
abstract mixin class _$AuthConfigCopyWith<$Res> implements $AuthConfigCopyWith<$Res> {
  factory _$AuthConfigCopyWith(_AuthConfig value, $Res Function(_AuthConfig) _then) = __$AuthConfigCopyWithImpl;
@override @useResult
$Res call({
 AuthType type, String token, String username, String password, String apiKey, String apiValue, bool apiKeyInQuery
});




}
/// @nodoc
class __$AuthConfigCopyWithImpl<$Res>
    implements _$AuthConfigCopyWith<$Res> {
  __$AuthConfigCopyWithImpl(this._self, this._then);

  final _AuthConfig _self;
  final $Res Function(_AuthConfig) _then;

/// Create a copy of AuthConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? token = null,Object? username = null,Object? password = null,Object? apiKey = null,Object? apiValue = null,Object? apiKeyInQuery = null,}) {
  return _then(_AuthConfig(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as AuthType,token: null == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,apiKey: null == apiKey ? _self.apiKey : apiKey // ignore: cast_nullable_to_non_nullable
as String,apiValue: null == apiValue ? _self.apiValue : apiValue // ignore: cast_nullable_to_non_nullable
as String,apiKeyInQuery: null == apiKeyInQuery ? _self.apiKeyInQuery : apiKeyInQuery // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc
mixin _$ApiRequest {

 String get method;/// Full URL as typed, including the query built from enabled params.
 String get url; List<KeyValuePair> get params; List<KeyValuePair> get headers; BodyType get bodyType; String get body; List<KeyValuePair> get formFields; AuthConfig get auth;
/// Create a copy of ApiRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ApiRequestCopyWith<ApiRequest> get copyWith => _$ApiRequestCopyWithImpl<ApiRequest>(this as ApiRequest, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ApiRequest;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ApiRequest&&(identical(other.method, _this.method) || other.method == _this.method)&&(identical(other.url, _this.url) || other.url == _this.url)&&const DeepCollectionEquality().equals(other.params, _this.params)&&const DeepCollectionEquality().equals(other.headers, _this.headers)&&(identical(other.bodyType, _this.bodyType) || other.bodyType == _this.bodyType)&&(identical(other.body, _this.body) || other.body == _this.body)&&const DeepCollectionEquality().equals(other.formFields, _this.formFields)&&(identical(other.auth, _this.auth) || other.auth == _this.auth));
}


@override
int get hashCode {
  final _this = this as ApiRequest;
  return Object.hash(runtimeType,_this.method,_this.url,const DeepCollectionEquality().hash(_this.params),const DeepCollectionEquality().hash(_this.headers),_this.bodyType,_this.body,const DeepCollectionEquality().hash(_this.formFields),_this.auth);
}

@override
String toString() {
  final _this = this as ApiRequest;
  return 'ApiRequest(method: ${_this.method}, url: ${_this.url}, params: ${_this.params}, headers: ${_this.headers}, bodyType: ${_this.bodyType}, body: ${_this.body}, formFields: ${_this.formFields}, auth: ${_this.auth})';
}


}

/// @nodoc
abstract mixin class $ApiRequestCopyWith<$Res>  {
  factory $ApiRequestCopyWith(ApiRequest value, $Res Function(ApiRequest) _then) = _$ApiRequestCopyWithImpl;
@useResult
$Res call({
 String method, String url, List<KeyValuePair> params, List<KeyValuePair> headers, BodyType bodyType, String body, List<KeyValuePair> formFields, AuthConfig auth
});


$AuthConfigCopyWith<$Res> get auth;

}
/// @nodoc
class _$ApiRequestCopyWithImpl<$Res>
    implements $ApiRequestCopyWith<$Res> {
  _$ApiRequestCopyWithImpl(this._self, this._then);

  final ApiRequest _self;
  final $Res Function(ApiRequest) _then;

/// Create a copy of ApiRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? method = null,Object? url = null,Object? params = null,Object? headers = null,Object? bodyType = null,Object? body = null,Object? formFields = null,Object? auth = null,}) {
  return _then(ApiRequest(
method: null == method ? _self.method : method // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,params: null == params ? _self.params : params // ignore: cast_nullable_to_non_nullable
as List<KeyValuePair>,headers: null == headers ? _self.headers : headers // ignore: cast_nullable_to_non_nullable
as List<KeyValuePair>,bodyType: null == bodyType ? _self.bodyType : bodyType // ignore: cast_nullable_to_non_nullable
as BodyType,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,formFields: null == formFields ? _self.formFields : formFields // ignore: cast_nullable_to_non_nullable
as List<KeyValuePair>,auth: null == auth ? _self.auth : auth // ignore: cast_nullable_to_non_nullable
as AuthConfig,
  ));
}
/// Create a copy of ApiRequest
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AuthConfigCopyWith<$Res> get auth {
  
  return $AuthConfigCopyWith<$Res>(_self.auth, (value) {
    return _then(_self.copyWith(auth: value));
  });
}
}


/// Adds pattern-matching-related methods to [ApiRequest].
extension ApiRequestPatterns on ApiRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ApiRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ApiRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ApiRequest value)  $default,){
final _that = this;
switch (_that) {
case _ApiRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ApiRequest value)?  $default,){
final _that = this;
switch (_that) {
case _ApiRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String method,  String url,  List<KeyValuePair> params,  List<KeyValuePair> headers,  BodyType bodyType,  String body,  List<KeyValuePair> formFields,  AuthConfig auth)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ApiRequest() when $default != null:
return $default(_that.method,_that.url,_that.params,_that.headers,_that.bodyType,_that.body,_that.formFields,_that.auth);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String method,  String url,  List<KeyValuePair> params,  List<KeyValuePair> headers,  BodyType bodyType,  String body,  List<KeyValuePair> formFields,  AuthConfig auth)  $default,) {final _that = this;
switch (_that) {
case _ApiRequest():
return $default(_that.method,_that.url,_that.params,_that.headers,_that.bodyType,_that.body,_that.formFields,_that.auth);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String method,  String url,  List<KeyValuePair> params,  List<KeyValuePair> headers,  BodyType bodyType,  String body,  List<KeyValuePair> formFields,  AuthConfig auth)?  $default,) {final _that = this;
switch (_that) {
case _ApiRequest() when $default != null:
return $default(_that.method,_that.url,_that.params,_that.headers,_that.bodyType,_that.body,_that.formFields,_that.auth);case _:
  return null;

}
}

}

/// @nodoc


class _ApiRequest extends ApiRequest {
  const _ApiRequest({this.method = 'GET', this.url = '',  List<KeyValuePair> params = const [],  List<KeyValuePair> headers = const [], this.bodyType = BodyType.none, this.body = '',  List<KeyValuePair> formFields = const [], this.auth = const AuthConfig()}): _params = params,_headers = headers,_formFields = formFields,super._();
  

@override@JsonKey() final  String method;
/// Full URL as typed, including the query built from enabled params.
@override@JsonKey() final  String url;
 final  List<KeyValuePair> _params;
@override@JsonKey() List<KeyValuePair> get params {
  if (_params is EqualUnmodifiableListView) return _params;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_params);
}

 final  List<KeyValuePair> _headers;
@override@JsonKey() List<KeyValuePair> get headers {
  if (_headers is EqualUnmodifiableListView) return _headers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_headers);
}

@override@JsonKey() final  BodyType bodyType;
@override@JsonKey() final  String body;
 final  List<KeyValuePair> _formFields;
@override@JsonKey() List<KeyValuePair> get formFields {
  if (_formFields is EqualUnmodifiableListView) return _formFields;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_formFields);
}

@override@JsonKey() final  AuthConfig auth;

/// Create a copy of ApiRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ApiRequestCopyWith<_ApiRequest> get copyWith => __$ApiRequestCopyWithImpl<_ApiRequest>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ApiRequest&&(identical(other.method, method) || other.method == method)&&(identical(other.url, url) || other.url == url)&&const DeepCollectionEquality().equals(other.params, _params)&&const DeepCollectionEquality().equals(other.headers, _headers)&&(identical(other.bodyType, bodyType) || other.bodyType == bodyType)&&(identical(other.body, body) || other.body == body)&&const DeepCollectionEquality().equals(other.formFields, _formFields)&&(identical(other.auth, auth) || other.auth == auth));
}


@override
int get hashCode {
    return Object.hash(runtimeType,method,url,const DeepCollectionEquality().hash(_params),const DeepCollectionEquality().hash(_headers),bodyType,body,const DeepCollectionEquality().hash(_formFields),auth);
}

@override
String toString() {
    return 'ApiRequest(method: $method, url: $url, params: $params, headers: $headers, bodyType: $bodyType, body: $body, formFields: $formFields, auth: $auth)';
}


}

/// @nodoc
abstract mixin class _$ApiRequestCopyWith<$Res> implements $ApiRequestCopyWith<$Res> {
  factory _$ApiRequestCopyWith(_ApiRequest value, $Res Function(_ApiRequest) _then) = __$ApiRequestCopyWithImpl;
@override @useResult
$Res call({
 String method, String url, List<KeyValuePair> params, List<KeyValuePair> headers, BodyType bodyType, String body, List<KeyValuePair> formFields, AuthConfig auth
});


@override $AuthConfigCopyWith<$Res> get auth;

}
/// @nodoc
class __$ApiRequestCopyWithImpl<$Res>
    implements _$ApiRequestCopyWith<$Res> {
  __$ApiRequestCopyWithImpl(this._self, this._then);

  final _ApiRequest _self;
  final $Res Function(_ApiRequest) _then;

/// Create a copy of ApiRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? method = null,Object? url = null,Object? params = null,Object? headers = null,Object? bodyType = null,Object? body = null,Object? formFields = null,Object? auth = null,}) {
  return _then(_ApiRequest(
method: null == method ? _self.method : method // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,params: null == params ? _self._params : params // ignore: cast_nullable_to_non_nullable
as List<KeyValuePair>,headers: null == headers ? _self._headers : headers // ignore: cast_nullable_to_non_nullable
as List<KeyValuePair>,bodyType: null == bodyType ? _self.bodyType : bodyType // ignore: cast_nullable_to_non_nullable
as BodyType,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,formFields: null == formFields ? _self._formFields : formFields // ignore: cast_nullable_to_non_nullable
as List<KeyValuePair>,auth: null == auth ? _self.auth : auth // ignore: cast_nullable_to_non_nullable
as AuthConfig,
  ));
}

/// Create a copy of ApiRequest
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AuthConfigCopyWith<$Res> get auth {
  
  return $AuthConfigCopyWith<$Res>(_self.auth, (value) {
    return _then(_self.copyWith(auth: value));
  });
}
}

// dart format on
