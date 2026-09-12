import 'dart:convert';

import 'package:courier/shared/domain/entities/api_request.dart';
import 'package:courier/features/request/domain/services/url_params.dart';

class CurlParseException implements Exception {
  const CurlParseException(this.message);

  final String message;

  @override
  String toString() => message;
}

/// Parses a cURL command (bash style, including Chrome/Postman "Copy as cURL"
/// output) into an [ApiRequest].
class CurlParser {
  const CurlParser();

  static const _flagsWithValue = {
    '-X', '--request', '-H', '--header', '-d', '--data', '--data-raw', '--data-binary',
    '--data-ascii', '--data-urlencode', '--json', '-u', '--user', '-F', '--form',
    '--form-string', '--url', '-A', '--user-agent', '-b', '--cookie', '-e', '--referer',
    '-o', '--output', '-m', '--max-time', '--connect-timeout', '-x', '--proxy', '-w',
    '--write-out', '--retry', '-c', '--cookie-jar', '-T', '--upload-file', '--cacert',
    '--cert', '--key', '-r', '--range', '-z', '--time-cond', '--resolve', '--interface',
  };

  ApiRequest parse(String input) {
    final tokens = tokenize(input);
    if (tokens.isEmpty || tokens.first != 'curl') {
      throw const CurlParseException('Command must start with "curl"');
    }

    String? method;
    String? url;
    final headers = <KeyValuePair>[];
    final dataParts = <String>[];
    final formFields = <KeyValuePair>[];
    var forceGet = false;
    var head = false;
    var isJsonFlag = false;
    var auth = const AuthConfig();

    for (var i = 1; i < tokens.length; i++) {
      var token = tokens[i];
      String? inlineValue;

      // --flag=value
      if (token.startsWith('--') && token.contains('=')) {
        final eq = token.indexOf('=');
        final name = token.substring(0, eq);
        if (_flagsWithValue.contains(name)) {
          inlineValue = token.substring(eq + 1);
          token = name;
        }
      }
      // -XPOST, -HAccept:x
      if (inlineValue == null && token.length > 2 && token.startsWith('-') && !token.startsWith('--')) {
        final short = token.substring(0, 2);
        if (_flagsWithValue.contains(short)) {
          inlineValue = token.substring(2);
          token = short;
        } else {
          // Combined boolean flags like -sSLk.
          final letters = token.substring(1).split('');
          if (letters.contains('G')) forceGet = true;
          if (letters.contains('I')) head = true;
          continue;
        }
      }

      String next() {
        if (inlineValue != null) return inlineValue;
        if (i + 1 >= tokens.length) throw CurlParseException('Missing value for $token');
        return tokens[++i];
      }

      switch (token) {
        case '-X' || '--request':
          method = next().toUpperCase();
        case '-H' || '--header':
          final header = next();
          final colon = header.indexOf(':');
          if (colon <= 0) break;
          headers.add(KeyValuePair.create(
            key: header.substring(0, colon).trim(),
            value: header.substring(colon + 1).trim(),
          ));
        case '-d' || '--data' || '--data-raw' || '--data-binary' || '--data-ascii' || '--data-urlencode':
          dataParts.add(next());
        case '--json':
          dataParts.add(next());
          isJsonFlag = true;
        case '-F' || '--form' || '--form-string':
          final field = next();
          final eq = field.indexOf('=');
          formFields.add(eq < 0
              ? KeyValuePair.create(key: field)
              : KeyValuePair.create(key: field.substring(0, eq), value: _stripQuotes(field.substring(eq + 1))));
        case '-u' || '--user':
          final creds = next();
          final colon = creds.indexOf(':');
          auth = AuthConfig(
            type: AuthType.basic,
            username: colon < 0 ? creds : creds.substring(0, colon),
            password: colon < 0 ? '' : creds.substring(colon + 1),
          );
        case '-A' || '--user-agent':
          headers.add(KeyValuePair.create(key: 'User-Agent', value: next()));
        case '-b' || '--cookie':
          headers.add(KeyValuePair.create(key: 'Cookie', value: next()));
        case '-e' || '--referer':
          headers.add(KeyValuePair.create(key: 'Referer', value: next()));
        case '--url':
          url = next();
        case '-G' || '--get':
          forceGet = true;
        case '-I' || '--head':
          head = true;
        default:
          if (_flagsWithValue.contains(token)) {
            next();
          } else if (!token.startsWith('-')) {
            url ??= token;
          }
      }
    }

    if (url == null || url.isEmpty) throw const CurlParseException('No URL found in cURL command');

    // Pull Authorization headers into the Auth tab.
    headers.removeWhere((h) {
      if (h.key.toLowerCase() != 'authorization') return false;
      final value = h.value;
      if (value.toLowerCase().startsWith('bearer ')) {
        auth = AuthConfig(type: AuthType.bearer, token: value.substring(7).trim());
        return true;
      }
      if (value.toLowerCase().startsWith('basic ')) {
        try {
          final decoded = utf8.decode(base64Decode(value.substring(6).trim()));
          final colon = decoded.indexOf(':');
          auth = AuthConfig(
            type: AuthType.basic,
            username: colon < 0 ? decoded : decoded.substring(0, colon),
            password: colon < 0 ? '' : decoded.substring(colon + 1),
          );
          return true;
        } catch (_) {
          return false;
        }
      }
      return false;
    });

    if (isJsonFlag) {
      if (!_hasHeader(headers, 'content-type')) {
        headers.add(KeyValuePair.create(key: 'Content-Type', value: 'application/json'));
      }
      if (!_hasHeader(headers, 'accept')) {
        headers.add(KeyValuePair.create(key: 'Accept', value: 'application/json'));
      }
    }

    var bodyType = BodyType.none;
    var body = '';
    var formList = <KeyValuePair>[];
    final data = dataParts.join('&');

    if (forceGet && dataParts.isNotEmpty) {
      url = url.contains('?') ? '$url&$data' : '$url?$data';
    } else if (formFields.isNotEmpty) {
      bodyType = BodyType.multipart;
      formList = formFields;
      headers.removeWhere((h) => h.key.toLowerCase() == 'content-type' && h.value.contains('multipart'));
    } else if (dataParts.isNotEmpty) {
      final contentType = _headerValue(headers, 'content-type')?.toLowerCase() ?? '';
      if (contentType.contains('json') || _looksLikeJson(data)) {
        bodyType = BodyType.json;
        body = _prettyJson(data);
      } else if (contentType.contains('xml')) {
        bodyType = BodyType.xml;
        body = data;
      } else if (contentType.contains('x-www-form-urlencoded') || (contentType.isEmpty && _looksLikeForm(data))) {
        bodyType = BodyType.formUrlEncoded;
        formList = _parseForm(data);
      } else {
        bodyType = BodyType.text;
        body = data;
      }
    }

    // Content-Type is implied by the body type; keep it only if it's unusual.
    if (bodyType != BodyType.none) {
      headers.removeWhere((h) =>
          h.key.toLowerCase() == 'content-type' &&
          bodyType.contentType != null &&
          h.value.toLowerCase().split(';').first.trim() == bodyType.contentType);
    }

    final resolvedMethod = method ??
        (head
            ? 'HEAD'
            : (bodyType != BodyType.none && !forceGet)
                ? 'POST'
                : 'GET');

    return ApiRequest(
      method: resolvedMethod,
      url: url,
      params: paramsFromUrl(url, const []),
      headers: headers,
      bodyType: bodyType,
      body: body,
      formFields: formList,
      auth: auth,
    );
  }

  /// Shell-like tokenizer supporting '...', "...", $'...', backslash escapes
  /// and line continuations (\ on bash, ^ on Windows cmd).
  static List<String> tokenize(String input) {
    final src = input.replaceAll(RegExp(r'\\\r?\n'), ' ').replaceAll(RegExp(r'\^\r?\n'), ' ');
    final tokens = <String>[];
    final buf = StringBuffer();
    var inToken = false;
    var i = 0;

    while (i < src.length) {
      final c = src[i];
      if (c == ' ' || c == '\t' || c == '\n' || c == '\r') {
        if (inToken) {
          tokens.add(buf.toString());
          buf.clear();
          inToken = false;
        }
        i++;
      } else if (c == "'") {
        inToken = true;
        final end = src.indexOf("'", i + 1);
        if (end < 0) throw const CurlParseException('Unterminated single quote');
        buf.write(src.substring(i + 1, end));
        i = end + 1;
      } else if (c == r'$' && i + 1 < src.length && src[i + 1] == "'") {
        inToken = true;
        i += 2;
        while (i < src.length && src[i] != "'") {
          if (src[i] == r'\' && i + 1 < src.length) {
            final e = src[i + 1];
            switch (e) {
              case 'n':
                buf.write('\n');
              case 't':
                buf.write('\t');
              case 'r':
                buf.write('\r');
              case 'u' when i + 5 < src.length:
                buf.writeCharCode(int.tryParse(src.substring(i + 2, i + 6), radix: 16) ?? 63);
                i += 4;
              case 'x' when i + 3 < src.length:
                buf.writeCharCode(int.tryParse(src.substring(i + 2, i + 4), radix: 16) ?? 63);
                i += 2;
              default:
                buf.write(e);
            }
            i += 2;
          } else {
            buf.write(src[i++]);
          }
        }
        if (i >= src.length) throw const CurlParseException('Unterminated quote');
        i++;
      } else if (c == '"') {
        inToken = true;
        i++;
        while (i < src.length && src[i] != '"') {
          if (src[i] == r'\' && i + 1 < src.length && r'"\$`'.contains(src[i + 1])) {
            buf.write(src[i + 1]);
            i += 2;
          } else {
            buf.write(src[i++]);
          }
        }
        if (i >= src.length) throw const CurlParseException('Unterminated double quote');
        i++;
      } else if (c == r'\' && i + 1 < src.length) {
        inToken = true;
        buf.write(src[i + 1]);
        i += 2;
      } else {
        inToken = true;
        buf.write(c);
        i++;
      }
    }
    if (inToken) tokens.add(buf.toString());
    return tokens;
  }

  static bool _hasHeader(List<KeyValuePair> headers, String name) =>
      headers.any((h) => h.key.toLowerCase() == name);

  static String? _headerValue(List<KeyValuePair> headers, String name) {
    for (final h in headers) {
      if (h.key.toLowerCase() == name) return h.value;
    }
    return null;
  }

  static bool _looksLikeJson(String s) {
    final t = s.trim();
    if (!(t.startsWith('{') || t.startsWith('['))) return false;
    try {
      jsonDecode(t);
      return true;
    } catch (_) {
      return false;
    }
  }

  static bool _looksLikeForm(String s) =>
      RegExp(r'^[^=&\s]+=[^&\s]*(&[^=&\s]+=[^&\s]*)*$').hasMatch(s.trim());

  static String _prettyJson(String s) {
    try {
      return const JsonEncoder.withIndent('  ').convert(jsonDecode(s));
    } catch (_) {
      return s;
    }
  }

  static List<KeyValuePair> _parseForm(String s) => [
        for (final part in s.split('&').where((p) => p.isNotEmpty))
          () {
            final eq = part.indexOf('=');
            String decode(String v) {
              try {
                return Uri.decodeQueryComponent(v);
              } catch (_) {
                return v;
              }
            }

            return KeyValuePair.create(
              key: decode(eq < 0 ? part : part.substring(0, eq)),
              value: eq < 0 ? '' : decode(part.substring(eq + 1)),
            );
          }(),
      ];

  static String _stripQuotes(String v) =>
      v.length >= 2 && v.startsWith('"') && v.endsWith('"') ? v.substring(1, v.length - 1) : v;
}
