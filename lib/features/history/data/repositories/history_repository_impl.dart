import 'package:courier/features/history/data/datasources/history_local_data_source.dart';
import 'package:courier/features/history/data/models/history_entry_hive_model.dart';
import 'package:courier/features/history/domain/entities/history_entry.dart';
import 'package:courier/features/history/domain/repositories/history_repository.dart';

class HistoryRepositoryImpl implements HistoryRepository {
  const HistoryRepositoryImpl(this._dataSource);

  final HistoryLocalDataSource _dataSource;

  @override
  List<HistoryEntry> getAll() => (_dataSource.getAll()..sort((a, b) => b.timestampMs.compareTo(a.timestampMs)))
      .map((m) => m.toEntity())
      .toList();

  @override
  Future<void> add(HistoryEntry entry, {required int limit}) async {
    await _dataSource.put(HistoryEntryHiveModel.fromEntity(entry));
    final all = _dataSource.getAll();
    if (all.length <= limit) return;
    all.sort((a, b) => b.timestampMs.compareTo(a.timestampMs));
    await _dataSource.deleteAll(all.skip(limit).map((m) => m.id));
  }

  @override
  Future<void> delete(String id) => _dataSource.delete(id);

  @override
  Future<void> clear() => _dataSource.clear();
}
