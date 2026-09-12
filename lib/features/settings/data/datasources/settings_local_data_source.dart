import 'package:courier/features/settings/data/models/settings_hive_model.dart';
import 'package:hive_ce/hive_ce.dart';

class SettingsLocalDataSource {
  const SettingsLocalDataSource(this._box);

  static const _key = 'settings';

  final Box<SettingsHiveModel> _box;

  SettingsHiveModel? get() => _box.get(_key);

  Future<void> put(SettingsHiveModel model) => _box.put(_key, model);
}
