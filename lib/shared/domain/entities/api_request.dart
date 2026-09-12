import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:courier/core/utils/id_generator.dart';

part 'api_request.freezed.dart';

const kHttpMethods = ['GET', 'POST', 'PUT', 'PATCH', 'DELETE', 'HEAD', 'OPTIONS'];

@freezed
abstract class KeyValuePair with _$KeyValuePair {
  const KeyValuePair._();

  const factory KeyValuePair({
    required String id,
    @Default('') String key,
    @Default('') String value,
    @Default(true) bool enabled,
  }) = _KeyValuePair;

  factory KeyValuePair.create({String key = '', String value = '', bool enabled = true}) =>
      KeyValuePair(id: generateId(), key: key, value: value, enabled: enabled);

  bool get isEmpty => key.isEmpty && value.isEmpty;
  bool get isActive => enabled && key.isNotEmpty;
}

enum BodyType {
  none('None', null),
  json('JSON', 'application/json'),
  text('Text', 'text/plain'),
  xml('XML', 'application/xml'),
  formUrlEncoded('Form URL Encoded', 'application/x-www-form-urlencoded'),
  multipart('Multipart Form', 'multipart/form-data');

  const BodyType(this.label, this.contentType);

  final String label;
  final String? contentType;

  bool get isRaw => this == json || this == text || this == xml;
  bool get isForm => this == formUrlEncoded || this == multipart;
}

enum AuthType {
  none('No Auth'),
  bearer('Bearer Token'),
  basic('Basic Auth'),
  apiKey('API Key');

  const AuthType(this.label);

  final String label;
}

@freezed
abstract class AuthConfig with _$AuthConfig {
  const factory AuthConfig({
    @Default(AuthType.none) AuthType type,
    @Default('') String token,
    @Default('') String username,
    @Default('') String password,
    @Default('') String apiKey,
    @Default('') String apiValue,
    @Default(false) bool apiKeyInQuery,
  }) = _AuthConfig;
}

@freezed
abstract class ApiRequest with _$ApiRequest {
  const ApiRequest._();

  const factory ApiRequest({
    @Default('GET') String method,

    /// Full URL as typed, including the query built from enabled params.
    @Default('') String url,
    @Default([]) List<KeyValuePair> params,
    @Default([]) List<KeyValuePair> headers,
    @Default(BodyType.none) BodyType bodyType,
    @Default('') String body,
    @Default([]) List<KeyValuePair> formFields,
    @Default(AuthConfig()) AuthConfig auth,
  }) = _ApiRequest;

  bool get isEmpty => url.trim().isEmpty;
}
