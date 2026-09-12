import 'package:courier/shared/domain/entities/api_request.dart';
import 'package:courier/shared/domain/entities/api_response.dart';

// Hive storage models. Enums are stored by name so reordering them never
// corrupts stored data. Adapters are generated from core/storage/hive_adapters.dart.

class KeyValueHiveModel {
  const KeyValueHiveModel({required this.id, required this.key, required this.value, required this.enabled});

  final String id;
  final String key;
  final String value;
  final bool enabled;

  factory KeyValueHiveModel.fromEntity(KeyValuePair e) =>
      KeyValueHiveModel(id: e.id, key: e.key, value: e.value, enabled: e.enabled);

  KeyValuePair toEntity() => KeyValuePair(id: id, key: key, value: value, enabled: enabled);
}

class AuthHiveModel {
  const AuthHiveModel({
    required this.type,
    required this.token,
    required this.username,
    required this.password,
    required this.apiKey,
    required this.apiValue,
    required this.apiKeyInQuery,
  });

  final String type;
  final String token;
  final String username;
  final String password;
  final String apiKey;
  final String apiValue;
  final bool apiKeyInQuery;

  factory AuthHiveModel.fromEntity(AuthConfig e) => AuthHiveModel(
        type: e.type.name,
        token: e.token,
        username: e.username,
        password: e.password,
        apiKey: e.apiKey,
        apiValue: e.apiValue,
        apiKeyInQuery: e.apiKeyInQuery,
      );

  AuthConfig toEntity() => AuthConfig(
        type: AuthType.values.asNameMap()[type] ?? AuthType.none,
        token: token,
        username: username,
        password: password,
        apiKey: apiKey,
        apiValue: apiValue,
        apiKeyInQuery: apiKeyInQuery,
      );
}

class RequestHiveModel {
  const RequestHiveModel({
    required this.method,
    required this.url,
    required this.params,
    required this.headers,
    required this.bodyType,
    required this.body,
    required this.formFields,
    required this.auth,
  });

  final String method;
  final String url;
  final List<KeyValueHiveModel> params;
  final List<KeyValueHiveModel> headers;
  final String bodyType;
  final String body;
  final List<KeyValueHiveModel> formFields;
  final AuthHiveModel auth;

  factory RequestHiveModel.fromEntity(ApiRequest e) => RequestHiveModel(
        method: e.method,
        url: e.url,
        params: e.params.map(KeyValueHiveModel.fromEntity).toList(),
        headers: e.headers.map(KeyValueHiveModel.fromEntity).toList(),
        bodyType: e.bodyType.name,
        body: e.body,
        formFields: e.formFields.map(KeyValueHiveModel.fromEntity).toList(),
        auth: AuthHiveModel.fromEntity(e.auth),
      );

  ApiRequest toEntity() => ApiRequest(
        method: method,
        url: url,
        params: params.map((p) => p.toEntity()).toList(),
        headers: headers.map((h) => h.toEntity()).toList(),
        bodyType: BodyType.values.asNameMap()[bodyType] ?? BodyType.none,
        body: body,
        formFields: formFields.map((f) => f.toEntity()).toList(),
        auth: auth.toEntity(),
      );
}

class ResponseHiveModel {
  const ResponseHiveModel({
    required this.statusCode,
    required this.reasonPhrase,
    required this.headers,
    required this.body,
    required this.durationMs,
    required this.ttfbMs,
    required this.sizeBytes,
    required this.bodyTruncated,
    required this.requestUrl,
    required this.requestMethod,
    required this.requestHeaders,
    required this.requestBody,
    required this.redirects,
  });

  final int statusCode;
  final String reasonPhrase;
  final Map<String, String> headers;
  final String body;
  final int durationMs;
  final int? ttfbMs;
  final int sizeBytes;
  final bool bodyTruncated;
  final String requestUrl;
  final String requestMethod;
  final Map<String, String> requestHeaders;
  final String? requestBody;
  final List<String> redirects;

  factory ResponseHiveModel.fromEntity(ApiResponse e) => ResponseHiveModel(
        statusCode: e.statusCode,
        reasonPhrase: e.reasonPhrase,
        headers: e.headers,
        body: e.body,
        durationMs: e.durationMs,
        ttfbMs: e.ttfbMs,
        sizeBytes: e.sizeBytes,
        bodyTruncated: e.bodyTruncated,
        requestUrl: e.requestUrl,
        requestMethod: e.requestMethod,
        requestHeaders: e.requestHeaders,
        requestBody: e.requestBody,
        redirects: e.redirects,
      );

  ApiResponse toEntity() => ApiResponse(
        statusCode: statusCode,
        reasonPhrase: reasonPhrase,
        headers: headers,
        body: body,
        durationMs: durationMs,
        ttfbMs: ttfbMs,
        sizeBytes: sizeBytes,
        bodyTruncated: bodyTruncated,
        requestUrl: requestUrl,
        requestMethod: requestMethod,
        requestHeaders: requestHeaders,
        requestBody: requestBody,
        redirects: redirects,
      );
}
