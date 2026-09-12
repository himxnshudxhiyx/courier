import 'package:courier/core/storage/storage_providers.dart';
import 'package:courier/features/settings/data/datasources/settings_local_data_source.dart';
import 'package:courier/features/settings/data/repositories/settings_repository_impl.dart';
import 'package:courier/features/settings/domain/entities/app_settings.dart';
import 'package:courier/features/settings/domain/repositories/settings_repository.dart';
import 'package:courier/features/settings/domain/usecases/settings_usecases.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'settings_providers.g.dart';

@Riverpod(keepAlive: true)
SettingsRepository settingsRepository(Ref ref) =>
    SettingsRepositoryImpl(SettingsLocalDataSource(ref.watch(settingsBoxProvider)));

@Riverpod(keepAlive: true)
class SettingsController extends _$SettingsController {
  @override
  AppSettings build() => GetSettings(ref.watch(settingsRepositoryProvider))();

  Future<void> save(AppSettings settings) async {
    state = settings;
    final repository = ref.read(settingsRepositoryProvider);
    await UpdateSettings(repository)(settings);
    state = GetSettings(repository)();
  }
}
