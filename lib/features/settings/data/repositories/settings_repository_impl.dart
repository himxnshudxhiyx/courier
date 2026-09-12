import 'package:courier/features/settings/data/datasources/settings_local_data_source.dart';
import 'package:courier/features/settings/data/models/settings_hive_model.dart';
import 'package:courier/features/settings/domain/entities/app_settings.dart';
import 'package:courier/features/settings/domain/repositories/settings_repository.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  const SettingsRepositoryImpl(this._dataSource);

  final SettingsLocalDataSource _dataSource;

  @override
  AppSettings get() => _dataSource.get()?.toEntity() ?? const AppSettings();

  @override
  Future<void> save(AppSettings settings) => _dataSource.put(SettingsHiveModel.fromEntity(settings));
}
