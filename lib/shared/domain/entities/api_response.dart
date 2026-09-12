import 'dart:convert';
import 'dart:typed_data';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_response.freezed.dart';

@freezed
abstract class ApiResponse with _$ApiResponse {
  const ApiResponse._();

  const factory ApiResponse({
    required int statusCode,
    @Default('') String reasonPhrase,
    @Default({}) Map<String, String> headers,
    @Default('') String body,
    required int durationMs,
    int? ttfbMs,
    required int sizeBytes,

    /// Raw bytes, kept in memory only (used to preview images).
    Uint8List? bytes,
    @Default(false) bool bodyTruncated,

    // What was actually sent after variables and auth were applied.
    required String requestUrl,
    required String requestMethod,
    @Default({}) Map<String, String> requestHeaders,
    String? requestBody,
    @Default([]) List<String> redirects,
  }) = _ApiResponse;

  String get contentType {
    for (final e in headers.entries) {
      if (e.key.toLowerCase() == 'content-type') return e.value.toLowerCase();
    }
    return '';
  }

  bool get isSuccess => statusCode >= 200 && statusCode < 300;
  bool get isImage => contentType.startsWith('image/') && bytes != null;

  bool get isJson {
    if (contentType.contains('json')) return true;
    final t = body.trimLeft();
    if (!(t.startsWith('{') || t.startsWith('['))) return false;
    try {
      jsonDecode(body);
      return true;
    } catch (_) {
      return false;
    }
  }

  ApiResponse truncated(int maxChars) => body.length <= maxChars
      ? copyWith(bytes: null)
      : copyWith(body: body.substring(0, maxChars), bodyTruncated: true, bytes: null);
}
