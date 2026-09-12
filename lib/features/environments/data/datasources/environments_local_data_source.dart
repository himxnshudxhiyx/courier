import 'package:courier/features/environments/data/models/environment_hive_model.dart';
import 'package:hive_ce/hive_ce.dart';

class EnvironmentsLocalDataSource {
  const EnvironmentsLocalDataSource(this._box, this._preferences);

  static const _activeIdKey = 'activeEnvironmentId';

  final Box<EnvironmentHiveModel> _box;
  final Box<String> _preferences;

  List<EnvironmentHiveModel> getAll() => _box.values.toList();

  Future<void> put(EnvironmentHiveModel model) => _box.put(model.id, model);

  Future<void> delete(String id) => _box.delete(id);

  String? getActiveId() => _preferences.get(_activeIdKey);

  Future<void> setActiveId(String? id) =>
      id == null ? _preferences.delete(_activeIdKey) : _preferences.put(_activeIdKey, id);
}
