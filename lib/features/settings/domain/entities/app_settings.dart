import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_settings.freezed.dart';

enum ThemePreference { system, light, dark }

@freezed
abstract class AppSettings with _$AppSettings {
  const factory AppSettings({
    @Default(30) int timeoutSeconds,
    @Default(true) bool followRedirects,
    @Default(true) bool verifySsl,
    @Default(200) int historyLimit,
    @Default(true) bool saveResponseBodies,
    @Default(ThemePreference.dark) ThemePreference theme,
  }) = _AppSettings;
}
