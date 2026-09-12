import 'package:courier/core/error/result.dart';
import 'package:courier/core/network/cancel_token.dart';
import 'package:courier/features/request/domain/entities/send_options.dart';
import 'package:courier/features/request/domain/services/request_preparer.dart';
import 'package:courier/shared/domain/entities/api_response.dart';

abstract interface class HttpRepository {
  Future<Result<ApiResponse>> send(
    PreparedRequest request, {
    required SendOptions options,
    CancelToken? cancelToken,
  });
}
