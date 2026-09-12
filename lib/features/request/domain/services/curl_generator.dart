import 'package:courier/shared/domain/entities/api_request.dart';
import 'package:courier/features/request/domain/services/request_preparer.dart';

/// Builds a multi-line bash cURL command from a request.
class CurlGenerator {
  const CurlGenerator();

  String generate(
    ApiRequest request, {
    List<KeyValuePair> variables = const [],
    bool resolveVariables = true,
  }) {
    final prepared = prepareRequest(request, variables: variables, resolveVariables: resolveVariables);
    final parts = <String>['curl'];
    if (prepared.method != 'GET' || prepared.bodyType != BodyType.none) {
      parts.add('--request ${prepared.method}');
    }
    parts.add('--url ${_quote(prepared.url)}');
    for (final h in prepared.headers) {
      parts.add('--header ${_quote('${h.key}: ${h.value}')}');
    }
    if (prepared.bodyType == BodyType.multipart) {
      for (final f in prepared.formFields) {
        parts.add('--form ${_quote('${f.key}=${f.value}')}');
      }
    } else if (prepared.body != null && prepared.body!.isNotEmpty) {
      parts.add('--data ${_quote(prepared.body!)}');
    }
    return parts.join(' \\\n  ');
  }

  static String _quote(String s) => "'${s.replaceAll("'", r"'\''")}'";
}
