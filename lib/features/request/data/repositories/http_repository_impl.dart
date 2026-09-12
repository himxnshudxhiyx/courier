import 'package:courier/core/error/failure.dart';
import 'package:courier/core/error/result.dart';
import 'package:courier/core/network/cancel_token.dart';
import 'package:courier/features/request/data/datasources/http_remote_data_source.dart';
import 'package:courier/features/request/domain/entities/send_options.dart';
import 'package:courier/features/request/domain/repositories/http_repository.dart';
import 'package:courier/features/request/domain/services/request_preparer.dart';
import 'package:courier/shared/domain/entities/api_response.dart';

class HttpRepositoryImpl implements HttpRepository {
  const HttpRepositoryImpl(this._dataSource);

  final HttpRemoteDataSource _dataSource;

  @override
  Future<Result<ApiResponse>> send(
    PreparedRequest request, {
    required SendOptions options,
    CancelToken? cancelToken,
  }) async {
    try {
      return Ok(await _dataSource.send(request, options, cancelToken));
    } on Failure catch (f) {
      return Err(f);
    }
  }
}
