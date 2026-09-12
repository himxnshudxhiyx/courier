import 'package:courier/features/request/domain/services/curl_generator.dart';
import 'package:courier/features/request/domain/services/curl_parser.dart';
import 'package:courier/features/request/domain/services/request_preparer.dart';
import 'package:courier/shared/domain/entities/api_request.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const parser = CurlParser();
  const generator = CurlGenerator();

  group('CurlParser', () {
    test('parses a JSON POST with line continuations', () {
      final r = parser.parse('''
curl --location 'https://devgoapi.livekeeping.com/v1/eWay/partBRecommendation' \\
--header 'Content-Type: application/json' \\
--header 'Authorization: Bearer abc.def' \\
--data '{"_userId":"6a3b","NoOfRecommendation":5}'
''');
      expect(r.method, 'POST');
      expect(r.url, 'https://devgoapi.livekeeping.com/v1/eWay/partBRecommendation');
      expect(r.bodyType, BodyType.json);
      expect(r.body, contains('"NoOfRecommendation": 5'));
      expect(r.auth.type, AuthType.bearer);
      expect(r.auth.token, 'abc.def');
      // Content-Type is implied by the JSON body type, Authorization moved to auth.
      expect(r.headers, isEmpty);
    });

    test('parses Chrome style \$\'...\' quoting, -X attached and query params', () {
      final r = parser.parse(r"curl -XPUT 'https://api.test/items?page=2&q=a%20b' -H $'X-Name: it\'s' --data-raw $'line1\nline2' --compressed");
      expect(r.method, 'PUT');
      expect(r.params.map((p) => (p.key, p.value)), [('page', '2'), ('q', 'a%20b')]);
      expect(r.headers.single.value, "it's");
      expect(r.bodyType, BodyType.text);
      expect(r.body, 'line1\nline2');
    });

    test('infers form bodies, basic auth and GET with -G', () {
      final form = parser.parse('curl https://a.test/login -d user=me -d pass=x%26y -u admin:secret');
      expect(form.method, 'POST');
      expect(form.bodyType, BodyType.formUrlEncoded);
      expect(form.formFields.map((f) => (f.key, f.value)), [('user', 'me'), ('pass', 'x&y')]);
      expect(form.auth.type, AuthType.basic);
      expect(form.auth.password, 'secret');

      final get = parser.parse('curl -G https://a.test/search -d q=dart');
      expect(get.method, 'GET');
      expect(get.url, 'https://a.test/search?q=dart');
    });

    test('parses multipart and combined short flags', () {
      final r = parser.parse('curl -sSL -F name=Courier -F "note=hi there" https://a.test/upload');
      expect(r.method, 'POST');
      expect(r.bodyType, BodyType.multipart);
      expect(r.formFields.map((f) => f.value), ['Courier', 'hi there']);
    });

    test('rejects non-curl input', () {
      expect(() => parser.parse('wget https://a.test'), throwsA(isA<CurlParseException>()));
      expect(() => parser.parse('curl -X POST'), throwsA(isA<CurlParseException>()));
    });
  });

  group('prepareRequest', () {
    test('resolves variables, auth and default content type', () {
      final request = ApiRequest(
        method: 'POST',
        url: '{{baseUrl}}/users?id={{id}}',
        params: [KeyValuePair.create(key: 'id', value: '{{id}}')],
        bodyType: BodyType.json,
        body: '{"id": "{{id}}"}',
        auth: const AuthConfig(type: AuthType.apiKey, apiKey: 'x-api-key', apiValue: '{{key}}', apiKeyInQuery: true),
      );
      final p = prepareRequest(request, variables: [
        KeyValuePair.create(key: 'baseUrl', value: 'https://api.test'),
        KeyValuePair.create(key: 'id', value: '42'),
        KeyValuePair.create(key: 'key', value: 'k1'),
      ]);
      expect(p.url, 'https://api.test/users?id=42&x-api-key=k1');
      expect(p.body, '{"id": "42"}');
      expect(p.headers.single.key, 'Content-Type');
      expect(p.unresolvedVariables, isEmpty);
    });

    test('reports unresolved variables', () {
      final p = prepareRequest(const ApiRequest(url: '{{host}}/x'));
      expect(p.unresolvedVariables, {'host'});
    });
  });

  test('generated cURL parses back to the same request', () {
    final original = parser.parse(
        "curl -X PATCH 'https://a.test/x?y=1' -H 'Accept: */*' -H 'Authorization: Bearer t' --data '{\"it'\\''s\": true}'");
    final regenerated = parser.parse(generator.generate(original));
    expect(regenerated.method, original.method);
    expect(regenerated.url, original.url);
    expect(regenerated.body, original.body);
    expect(regenerated.auth, original.auth);
    expect(regenerated.headers.map((h) => (h.key, h.value)), original.headers.map((h) => (h.key, h.value)));
  });
}
