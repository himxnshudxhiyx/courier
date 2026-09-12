import 'package:courier/features/settings/domain/entities/app_settings.dart';

class SettingsHiveModel {
  const SettingsHiveModel({
    required this.timeoutSeconds,
    required this.followRedirects,
    required this.verifySsl,
    required this.historyLimit,
    required this.saveResponseBodies,
    required this.theme,
  });

  final int timeoutSeconds;
  final bool followRedirects;
  final bool verifySsl;
  final int historyLimit;
  final bool saveResponseBodies;
  final String theme;

  factory SettingsHiveModel.fromEntity(AppSettings e) => SettingsHiveModel(
        timeoutSeconds: e.timeoutSeconds,
        followRedirects: e.followRedirects,
        verifySsl: e.verifySsl,
        historyLimit: e.historyLimit,
        saveResponseBodies: e.saveResponseBodies,
        theme: e.theme.name,
      );

  AppSettings toEntity() => AppSettings(
        timeoutSeconds: timeoutSeconds,
        followRedirects: followRedirects,
        verifySsl: verifySsl,
        historyLimit: historyLimit,
        saveResponseBodies: saveResponseBodies,
        theme: ThemePreference.values.asNameMap()[theme] ?? ThemePreference.dark,
      );
}
