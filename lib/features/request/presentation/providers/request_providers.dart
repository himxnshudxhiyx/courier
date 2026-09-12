import 'package:courier/core/error/failure.dart';
import 'package:courier/core/error/result.dart';
import 'package:courier/core/network/cancel_token.dart';
import 'package:courier/core/utils/id_generator.dart';
import 'package:courier/core/utils/json_utils.dart';
import 'package:courier/features/collections/domain/entities/saved_request.dart';
import 'package:courier/features/environments/presentation/providers/environments_providers.dart';
import 'package:courier/features/history/domain/entities/history_entry.dart';
import 'package:courier/features/history/presentation/providers/history_providers.dart';
import 'package:courier/features/request/data/datasources/http_remote_data_source.dart';
import 'package:courier/features/request/data/repositories/http_repository_impl.dart';
import 'package:courier/features/request/domain/entities/send_options.dart';
import 'package:courier/features/request/domain/repositories/http_repository.dart';
import 'package:courier/features/request/domain/services/url_params.dart';
import 'package:courier/features/request/domain/usecases/request_usecases.dart';
import 'package:courier/features/request/presentation/providers/request_state.dart';
import 'package:courier/features/settings/presentation/providers/settings_providers.dart';
import 'package:courier/shared/domain/entities/api_request.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'request_providers.g.dart';

@Riverpod(keepAlive: true)
HttpRepository httpRepository(Ref ref) => const HttpRepositoryImpl(HttpRemoteDataSource());

@Riverpod(keepAlive: true)
class RequestEditor extends _$RequestEditor {
  @override
  RequestEditorState build() => const RequestEditorState();

  ApiRequest get _request => state.request;

  void _update(ApiRequest request) => state = state.copyWith(request: request);

  void setMethod(String method) => _update(_request.copyWith(method: method));

  /// Keeps the URL exactly as typed and re-derives params from its query.
  void setUrl(String url) => _update(_request.copyWith(url: url, params: paramsFromUrl(url, _request.params)));

  void setParams(List<KeyValuePair> params) =>
      _update(_request.copyWith(params: params, url: buildUrl(splitUrl(_request.url).base, params)));

  void setHeaders(List<KeyValuePair> headers) => _update(_request.copyWith(headers: headers));

  void setBodyType(BodyType type) => _update(_request.copyWith(bodyType: type));

  void setBody(String body) => _update(_request.copyWith(body: body));

  void setFormFields(List<KeyValuePair> fields) => _update(_request.copyWith(formFields: fields));

  void setAuth(AuthConfig auth) => _update(_request.copyWith(auth: auth));

  /// Returns false when the body isn't valid JSON.
  bool prettifyBody() {
    final pretty = tryPrettyJson(_request.body);
    if (pretty == null) return false;
    setBody(pretty);
    return true;
  }

  void load(ApiRequest request, {SavedRequest? saved}) => state = RequestEditorState(
        request: request,
        savedRequestId: saved?.id,
        savedRequestName: saved?.name,
      );

  void markSaved(SavedRequest saved) =>
      state = state.copyWith(savedRequestId: saved.id, savedRequestName: saved.name);

  void reset() => state = const RequestEditorState();

  /// Replaces the editor with the parsed command. Returns the failure, if any.
  Failure? importCurl(String command) => const ParseCurl()(command).fold(
        (failure) => failure,
        (request) {
          load(request);
          return null;
        },
      );
}

@Riverpod(keepAlive: true)
class SendController extends _$SendController {
  CancelToken? _cancelToken;

  @override
  SendState build() => const SendState();

  Future<void> send() async {
    if (state.isSending) return;
    final request = ref.read(requestEditorProvider).request;
    final settings = ref.read(settingsControllerProvider);
    final token = _cancelToken = CancelToken();
    state = state.copyWith(isSending: true, failure: null);

    final result = await SendRequest(ref.read(httpRepositoryProvider))(
      request,
      variables: ref.read(activeVariablesProvider),
      options: SendOptions(
        timeout: Duration(seconds: settings.timeoutSeconds),
        followRedirects: settings.followRedirects,
        verifySsl: settings.verifySsl,
      ),
      cancelToken: token,
    );
    _cancelToken = null;

    final history = ref.read(historyControllerProvider.notifier);
    switch (result) {
      case Ok(:final value):
        state = SendState(response: value, request: request);
        await history.add(HistoryEntry(id: generateId(), request: request, response: value, timestamp: DateTime.now()));
      case Err(:final failure):
        state = SendState(failure: failure, request: request);
        if (failure is NetworkFailure || failure is TimeoutFailure) {
          await history.add(
            HistoryEntry(id: generateId(), request: request, error: failure.message, timestamp: DateTime.now()),
          );
        }
    }
  }

  void cancel() => _cancelToken?.cancel();

  void clear() {
    if (!state.isSending) state = const SendState();
  }
}
