import 'dart:convert';
import 'dart:math';

import 'package:courier/shared/domain/entities/api_request.dart';
import 'package:courier/features/request/domain/services/url_params.dart';

final _varPattern = RegExp(r'\{\{\s*([^{}\s]+)\s*\}\}');
final _schemePattern = RegExp(r'^[a-zA-Z][a-zA-Z0-9+.-]*://');

const kDynamicVariables = [r'$timestamp', r'$timestampMs', r'$isoTimestamp', r'$randomInt', r'$guid'];

String _uuidV4() {
  final r = Random.secure();
  final b = List<int>.generate(16, (_) => r.nextInt(256));
  b[6] = (b[6] & 0x0f) | 0x40;
  b[8] = (b[8] & 0x3f) | 0x80;
  final h = b.map((e) => e.toRadixString(16).padLeft(2, '0')).join();
  return '${h.substring(0, 8)}-${h.substring(8, 12)}-${h.substring(12, 16)}-${h.substring(16, 20)}-${h.substring(20)}';
}

String? _dynamicVariable(String name) => switch (name) {
      r'$timestamp' => (DateTime.now().millisecondsSinceEpoch ~/ 1000).toString(),
      r'$timestampMs' => DateTime.now().millisecondsSinceEpoch.toString(),
      r'$isoTimestamp' => DateTime.now().toUtc().toIso8601String(),
      r'$randomInt' => Random().nextInt(1000).toString(),
      r'$guid' || r'$randomUUID' => _uuidV4(),
      _ => null,
    };

/// Substitutes `{{name}}` from environment variables and built-in dynamic
/// variables, remembering names it could not resolve.
class VariableResolver {
  VariableResolver(List<KeyValuePair> variables)
      : _values = {for (final v in variables.where((v) => v.isActive)) v.key: v.value};

  VariableResolver.disabled() : _values = null;

  final Map<String, String>? _values;
  final Set<String> unresolved = {};

  String resolve(String input) {
    final values = _values;
    if (values == null) return input;
    return input.replaceAllMapped(_varPattern, (m) {
      final name = m.group(1)!;
      final value = values[name] ?? _dynamicVariable(name);
      if (value == null) unresolved.add(name);
      return value ?? m.group(0)!;
    });
  }

  List<KeyValuePair> resolveAll(List<KeyValuePair> list) => [
        for (final e in list.where((e) => e.isActive))
          e.copyWith(key: resolve(e.key), value: resolve(e.value)),
      ];
}

/// A request ready to go on the wire: variables substituted, auth folded
/// into headers/query, default content type added and form bodies encoded.
class PreparedRequest {
  const PreparedRequest({
    required this.method,
    required this.url,
    required this.headers,
    required this.bodyType,
    this.body,
    this.formFields = const [],
    this.unresolvedVariables = const {},
  });

  final String method;
  final String url;
  final List<KeyValuePair> headers;
  final BodyType bodyType;
  final String? body;
  final List<KeyValuePair> formFields;
  final Set<String> unresolvedVariables;
}

PreparedRequest prepareRequest(
  ApiRequest request, {
  List<KeyValuePair> variables = const [],
  bool resolveVariables = true,
}) {
  final resolver = resolveVariables ? VariableResolver(variables) : VariableResolver.disabled();
  final res = resolver.resolve;

  final params = resolver.resolveAll(request.params);
  final headers = resolver.resolveAll(request.headers);
  bool hasHeader(String name) => headers.any((h) => h.key.toLowerCase() == name);

  final auth = request.auth;
  switch (auth.type) {
    case AuthType.bearer when auth.token.isNotEmpty:
      headers
        ..removeWhere((h) => h.key.toLowerCase() == 'authorization')
        ..add(KeyValuePair.create(key: 'Authorization', value: 'Bearer ${res(auth.token)}'));
    case AuthType.basic:
      final credentials = base64Encode(utf8.encode('${res(auth.username)}:${res(auth.password)}'));
      headers
        ..removeWhere((h) => h.key.toLowerCase() == 'authorization')
        ..add(KeyValuePair.create(key: 'Authorization', value: 'Basic $credentials'));
    case AuthType.apiKey when auth.apiKey.isNotEmpty:
      final pair = KeyValuePair.create(key: res(auth.apiKey), value: res(auth.apiValue));
      (auth.apiKeyInQuery ? params : headers).add(pair);
    default:
      break;
  }

  var url = buildUrl(res(splitUrl(request.url).base.trim()), params);
  if (resolveVariables && url.isNotEmpty && !_schemePattern.hasMatch(url) && !url.startsWith('{{')) {
    url = 'https://$url';
  }

  final type = request.bodyType;
  final contentType = type.contentType;
  if (contentType != null && type != BodyType.multipart && !hasHeader('content-type')) {
    headers.add(KeyValuePair.create(key: 'Content-Type', value: contentType));
  }

  String? body;
  var formFields = <KeyValuePair>[];
  if (type.isRaw) {
    body = res(request.body);
  } else if (type.isForm) {
    formFields = resolver.resolveAll(request.formFields);
    if (type == BodyType.formUrlEncoded) {
      body = formFields
          .map((f) => '${Uri.encodeQueryComponent(f.key)}=${Uri.encodeQueryComponent(f.value)}')
          .join('&');
    }
  }

  return PreparedRequest(
    method: request.method,
    url: url,
    headers: headers,
    bodyType: type,
    body: body,
    formFields: formFields,
    unresolvedVariables: resolver.unresolved,
  );
}
