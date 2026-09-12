import 'package:courier/features/collections/data/models/saved_request_hive_model.dart';
import 'package:courier/features/environments/data/models/environment_hive_model.dart';
import 'package:courier/features/history/data/models/history_entry_hive_model.dart';
import 'package:courier/features/settings/data/models/settings_hive_model.dart';
import 'package:courier/shared/data/models/request_hive_models.dart';
import 'package:hive_ce/hive_ce.dart';

// Field indices are tracked in hive_adapters.g.yaml; commit it so stored data
// stays readable as models evolve.
@GenerateAdapters([
  AdapterSpec<KeyValueHiveModel>(),
  AdapterSpec<AuthHiveModel>(),
  AdapterSpec<RequestHiveModel>(),
  AdapterSpec<ResponseHiveModel>(),
  AdapterSpec<HistoryEntryHiveModel>(),
  AdapterSpec<SavedRequestHiveModel>(),
  AdapterSpec<EnvironmentHiveModel>(),
  AdapterSpec<SettingsHiveModel>(),
])
part 'hive_adapters.g.dart';
