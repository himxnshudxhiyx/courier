import 'package:courier/core/storage/hive_storage.dart';
import 'package:courier/features/collections/data/models/saved_request_hive_model.dart';
import 'package:courier/features/environments/data/models/environment_hive_model.dart';
import 'package:courier/features/history/data/models/history_entry_hive_model.dart';
import 'package:courier/features/settings/data/models/settings_hive_model.dart';
import 'package:hive_ce/hive_ce.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'storage_providers.g.dart';

// Boxes are opened in initHiveStorage() before runApp; tests can override these.

@Riverpod(keepAlive: true)
Box<HistoryEntryHiveModel> historyBox(Ref ref) => Hive.box(HiveBoxes.history);

@Riverpod(keepAlive: true)
Box<SavedRequestHiveModel> collectionsBox(Ref ref) => Hive.box(HiveBoxes.collections);

@Riverpod(keepAlive: true)
Box<EnvironmentHiveModel> environmentsBox(Ref ref) => Hive.box(HiveBoxes.environments);

@Riverpod(keepAlive: true)
Box<SettingsHiveModel> settingsBox(Ref ref) => Hive.box(HiveBoxes.settings);

@Riverpod(keepAlive: true)
Box<String> preferencesBox(Ref ref) => Hive.box(HiveBoxes.preferences);
