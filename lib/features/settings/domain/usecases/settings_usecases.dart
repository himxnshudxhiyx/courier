import 'package:courier/features/settings/domain/entities/app_settings.dart';
import 'package:courier/features/settings/domain/repositories/settings_repository.dart';

class GetSettings {
  const GetSettings(this._repository);

  final SettingsRepository _repository;

  AppSettings call() => _repository.get();
}

class UpdateSettings {
  const UpdateSettings(this._repository);

  final SettingsRepository _repository;

  Future<void> call(AppSettings settings) => _repository.save(settings.copyWith(
        timeoutSeconds: settings.timeoutSeconds.clamp(1, 600),
        historyLimit: settings.historyLimit.clamp(10, 1000),
      ));
}
