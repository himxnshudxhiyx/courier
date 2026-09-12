import 'package:courier/features/settings/domain/entities/app_settings.dart';

abstract interface class SettingsRepository {
  AppSettings get();

  Future<void> save(AppSettings settings);
}
