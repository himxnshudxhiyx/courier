import 'package:courier/core/error/failure.dart';
import 'package:courier/core/error/result.dart';
import 'package:courier/core/network/cancel_token.dart';
import 'package:courier/features/request/domain/entities/send_options.dart';
import 'package:courier/features/request/domain/repositories/http_repository.dart';
import 'package:courier/features/request/domain/services/curl_generator.dart';
import 'package:courier/features/request/domain/services/curl_parser.dart';
import 'package:courier/features/request/domain/services/request_preparer.dart';
import 'package:courier/shared/domain/entities/api_request.dart';
import 'package:courier/shared/domain/entities/api_response.dart';

class SendRequest {
  const SendRequest(this._repository);

  final HttpRepository _repository;

  Future<Result<ApiResponse>> call(
    ApiRequest request, {
    required List<KeyValuePair> variables,
    required SendOptions options,
    CancelToken? cancelToken,
  }) async {
    if (request.isEmpty) return const Err(InvalidRequestFailure('Enter a URL'));
    final prepared = prepareRequest(request, variables: variables);
    if (prepared.unresolvedVariables.isNotEmpty) {
      final names = prepared.unresolvedVariables.map((v) => '{{$v}}').join(', ');
      return Err(InvalidRequestFailure('Unresolved variables: $names. Select or edit an environment.'));
    }
    return _repository.send(prepared, options: options, cancelToken: cancelToken);
  }
}

class ParseCurl {
  const ParseCurl([this._parser = const CurlParser()]);

  final CurlParser _parser;

  Result<ApiRequest> call(String command) {
    try {
      return Ok(_parser.parse(command.trim()));
    } on CurlParseException catch (e) {
      return Err(InvalidRequestFailure(e.message));
    }
  }
}

class GenerateCurl {
  const GenerateCurl([this._generator = const CurlGenerator()]);

  final CurlGenerator _generator;

  String call(ApiRequest request, {List<KeyValuePair> variables = const [], bool resolveVariables = true}) =>
      _generator.generate(request, variables: variables, resolveVariables: resolveVariables);
}
