import 'package:courier/core/error/failure.dart';
import 'package:courier/shared/domain/entities/api_request.dart';
import 'package:courier/shared/domain/entities/api_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'request_state.freezed.dart';

@freezed
abstract class RequestEditorState with _$RequestEditorState {
  const factory RequestEditorState({
    @Default(ApiRequest()) ApiRequest request,

    /// Set when the request was opened from (or saved to) a collection.
    String? savedRequestId,
    String? savedRequestName,
  }) = _RequestEditorState;
}

@freezed
abstract class SendState with _$SendState {
  const factory SendState({
    @Default(false) bool isSending,
    ApiResponse? response,

    /// The request that produced [response].
    ApiRequest? request,
    Failure? failure,
  }) = _SendState;
}
