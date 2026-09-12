import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:courier/core/error/failure.dart';
import 'package:courier/core/network/cancel_token.dart';
import 'package:courier/features/request/domain/entities/send_options.dart';
import 'package:courier/features/request/domain/services/request_preparer.dart';
import 'package:courier/shared/domain/entities/api_request.dart';
import 'package:courier/shared/domain/entities/api_response.dart';

/// Sends requests with dart:io's HttpClient, which exposes redirects,
/// time-to-first-byte and certificate handling. Throws [Failure]s.
class HttpRemoteDataSource {
  const HttpRemoteDataSource();

  static const _userAgent = 'Courier/1.0';

  Future<ApiResponse> send(PreparedRequest prepared, SendOptions options, CancelToken? cancelToken) async {
    final uri = Uri.tryParse(prepared.url);
    if (uri == null || !uri.hasScheme || uri.host.isEmpty) {
      throw InvalidRequestFailure('Invalid URL: ${prepared.url}');
    }
    if (uri.scheme != 'http' && uri.scheme != 'https') {
      throw InvalidRequestFailure('Unsupported scheme "${uri.scheme}"');
    }

    final client = HttpClient()
      ..connectionTimeout = options.timeout
      ..userAgent = _userAgent
      ..autoUncompress = true;
    if (!options.verifySsl) client.badCertificateCallback = (_, _, _) => true;
    cancelToken?.onCancel(() => client.close(force: true));

    final stopwatch = Stopwatch()..start();
    try {
      return await _send(client, uri, prepared, options, stopwatch).timeout(options.timeout);
    } on Failure {
      rethrow;
    } catch (e) {
      if (cancelToken?.isCancelled ?? false) throw const CancelledFailure();
      throw _mapError(e, options);
    } finally {
      client.close(force: true);
    }
  }

  Future<ApiResponse> _send(
    HttpClient client,
    Uri uri,
    PreparedRequest prepared,
    SendOptions options,
    Stopwatch stopwatch,
  ) async {
    final request = await client.openUrl(prepared.method, uri);
    request
      ..followRedirects = options.followRedirects
      ..maxRedirects = 10;

    for (final h in prepared.headers) {
      final name = h.key.toLowerCase();
      if (name == 'content-length' || name == 'host') continue;
      request.headers.add(h.key, h.value, preserveHeaderCase: true);
    }

    Uint8List? bodyBytes;
    String? bodyPreview = prepared.body;
    if (prepared.bodyType == BodyType.multipart) {
      final boundary = '----CourierBoundary${Random().nextInt(1 << 32).toRadixString(16)}';
      final buffer = StringBuffer();
      for (final f in prepared.formFields) {
        buffer
          ..write('--$boundary\r\n')
          ..write('Content-Disposition: form-data; name="${f.key.replaceAll('"', '%22')}"\r\n\r\n')
          ..write('${f.value}\r\n');
      }
      buffer.write('--$boundary--\r\n');
      bodyPreview = buffer.toString();
      bodyBytes = utf8.encode(bodyPreview);
      if (request.headers.value(HttpHeaders.contentTypeHeader) == null) {
        request.headers.set(HttpHeaders.contentTypeHeader, 'multipart/form-data; boundary=$boundary');
      }
    } else if (prepared.body != null && prepared.body!.isNotEmpty) {
      bodyBytes = utf8.encode(prepared.body!);
    }

    if (bodyBytes != null) {
      request.contentLength = bodyBytes.length;
      request.add(bodyBytes);
    }

    final sentHeaders = <String, String>{};
    request.headers.forEach((name, values) => sentHeaders[name] = values.join(', '));

    final response = await request.close();
    final ttfb = stopwatch.elapsedMilliseconds;
    final builder = BytesBuilder(copy: false);
    await response.forEach(builder.add);
    final bytes = builder.takeBytes();
    stopwatch.stop();

    final headers = <String, String>{};
    response.headers.forEach((name, values) => headers[name] = values.join(', '));

    final charset = response.headers.contentType?.charset?.toLowerCase();
    final body = (charset == 'iso-8859-1' || charset == 'latin1')
        ? latin1.decode(bytes)
        : utf8.decode(bytes, allowMalformed: true);

    return ApiResponse(
      statusCode: response.statusCode,
      reasonPhrase: response.reasonPhrase,
      headers: headers,
      body: body,
      bytes: bytes,
      durationMs: stopwatch.elapsedMilliseconds,
      ttfbMs: ttfb,
      sizeBytes: bytes.length,
      requestUrl: uri.toString(),
      requestMethod: prepared.method,
      requestHeaders: sentHeaders,
      requestBody: bodyPreview,
      redirects: [
        for (final r in response.redirects) '${r.statusCode} → ${r.location}',
      ],
    );
  }

  Failure _mapError(Object e, SendOptions options) => switch (e) {
        TimeoutException() => TimeoutFailure('Request timed out after ${options.timeout.inSeconds}s'),
        HandshakeException() => NetworkFailure(
            'SSL handshake failed: ${e.message}. For self-signed dev servers, turn off SSL verification in Settings.'),
        SocketException() => NetworkFailure(
            'Could not connect${e.address != null ? ' to ${e.address!.host}' : ''}: '
            '${e.osError?.message ?? e.message}'),
        HttpException() => NetworkFailure(e.message),
        ArgumentError() || FormatException() => InvalidRequestFailure(e.toString()),
        _ => UnexpectedFailure(e.toString()),
      };
}
