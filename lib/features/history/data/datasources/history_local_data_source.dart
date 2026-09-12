import 'package:courier/features/history/data/models/history_entry_hive_model.dart';
import 'package:hive_ce/hive_ce.dart';

class HistoryLocalDataSource {
  const HistoryLocalDataSource(this._box);

  final Box<HistoryEntryHiveModel> _box;

  List<HistoryEntryHiveModel> getAll() => _box.values.toList();

  Future<void> put(HistoryEntryHiveModel model) => _box.put(model.id, model);

  Future<void> deleteAll(Iterable<String> ids) => _box.deleteAll(ids);

  Future<void> delete(String id) => _box.delete(id);

  Future<void> clear() => _box.clear();
}
