import 'package:courier/core/storage/hive_registrar.g.dart';
import 'package:courier/features/collections/data/models/saved_request_hive_model.dart';
import 'package:courier/features/environments/data/models/environment_hive_model.dart';
import 'package:courier/features/history/data/models/history_entry_hive_model.dart';
import 'package:courier/features/settings/data/models/settings_hive_model.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';

abstract final class HiveBoxes {
  static const history = 'history';
  static const collections = 'collections';
  static const environments = 'environments';
  static const settings = 'settings';
  static const preferences = 'preferences';
}

Future<void> initHiveStorage() async {
  await Hive.initFlutter('courier');
  Hive.registerAdapters();
  await Future.wait([
    Hive.openBox<HistoryEntryHiveModel>(HiveBoxes.history),
    Hive.openBox<SavedRequestHiveModel>(HiveBoxes.collections),
    Hive.openBox<EnvironmentHiveModel>(HiveBoxes.environments),
    Hive.openBox<SettingsHiveModel>(HiveBoxes.settings),
    Hive.openBox<String>(HiveBoxes.preferences),
  ]);
}
