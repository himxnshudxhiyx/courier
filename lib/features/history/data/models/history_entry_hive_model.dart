import 'package:courier/features/history/domain/entities/history_entry.dart';
import 'package:courier/shared/data/models/request_hive_models.dart';

class HistoryEntryHiveModel {
  const HistoryEntryHiveModel({
    required this.id,
    required this.request,
    required this.response,
    required this.error,
    required this.timestampMs,
  });

  final String id;
  final RequestHiveModel request;
  final ResponseHiveModel? response;
  final String? error;
  final int timestampMs;

  factory HistoryEntryHiveModel.fromEntity(HistoryEntry e) => HistoryEntryHiveModel(
        id: e.id,
        request: RequestHiveModel.fromEntity(e.request),
        response: e.response == null ? null : ResponseHiveModel.fromEntity(e.response!),
        error: e.error,
        timestampMs: e.timestamp.millisecondsSinceEpoch,
      );

  HistoryEntry toEntity() => HistoryEntry(
        id: id,
        request: request.toEntity(),
        response: response?.toEntity(),
        error: error,
        timestamp: DateTime.fromMillisecondsSinceEpoch(timestampMs),
      );
}
