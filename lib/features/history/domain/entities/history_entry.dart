import 'package:courier/shared/domain/entities/api_request.dart';
import 'package:courier/shared/domain/entities/api_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'history_entry.freezed.dart';

@freezed
abstract class HistoryEntry with _$HistoryEntry {
  const factory HistoryEntry({
    required String id,
    required ApiRequest request,
    ApiResponse? response,
    String? error,
    required DateTime timestamp,
  }) = _HistoryEntry;
}
