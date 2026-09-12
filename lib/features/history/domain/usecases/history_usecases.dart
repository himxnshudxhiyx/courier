import 'package:courier/features/history/domain/entities/history_entry.dart';
import 'package:courier/features/history/domain/repositories/history_repository.dart';

/// Keeps stored history small: response bodies above this are cut.
const kMaxStoredBodyChars = 256 * 1024;

class GetHistory {
  const GetHistory(this._repository);

  final HistoryRepository _repository;

  List<HistoryEntry> call() => _repository.getAll();
}

class AddHistoryEntry {
  const AddHistoryEntry(this._repository);

  final HistoryRepository _repository;

  Future<void> call(HistoryEntry entry, {required int limit, required bool keepResponseBody}) {
    final response = entry.response;
    final stored = response == null
        ? entry
        : entry.copyWith(
            response: keepResponseBody
                ? response.truncated(kMaxStoredBodyChars)
                : response.copyWith(body: '', bytes: null, bodyTruncated: response.body.isNotEmpty),
          );
    return _repository.add(stored, limit: limit);
  }
}

class DeleteHistoryEntry {
  const DeleteHistoryEntry(this._repository);

  final HistoryRepository _repository;

  Future<void> call(String id) => _repository.delete(id);
}

class ClearHistory {
  const ClearHistory(this._repository);

  final HistoryRepository _repository;

  Future<void> call() => _repository.clear();
}
