import 'package:courier/features/history/domain/entities/history_entry.dart';

abstract interface class HistoryRepository {
  /// Newest first.
  List<HistoryEntry> getAll();

  /// Adds [entry] and drops the oldest entries beyond [limit].
  Future<void> add(HistoryEntry entry, {required int limit});

  Future<void> delete(String id);

  Future<void> clear();
}
