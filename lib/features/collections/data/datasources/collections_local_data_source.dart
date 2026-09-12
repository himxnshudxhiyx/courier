import 'package:courier/features/collections/data/models/saved_request_hive_model.dart';
import 'package:hive_ce/hive_ce.dart';

class CollectionsLocalDataSource {
  const CollectionsLocalDataSource(this._box);

  final Box<SavedRequestHiveModel> _box;

  List<SavedRequestHiveModel> getAll() => _box.values.toList();

  Future<void> put(SavedRequestHiveModel model) => _box.put(model.id, model);

  Future<void> delete(String id) => _box.delete(id);
}
