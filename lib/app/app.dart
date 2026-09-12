import 'package:courier/app/home_shell.dart';
import 'package:courier/core/theme/app_theme.dart';
import 'package:courier/features/settings/domain/entities/app_settings.dart';
import 'package:courier/features/settings/presentation/providers/settings_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CourierApp extends ConsumerWidget {
  const CourierApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(settingsControllerProvider.select((s) => s.theme));
    return MaterialApp(
      title: 'Courier',
      debugShowCheckedModeBanner: false,
      theme: buildAppTheme(Brightness.light),
      darkTheme: buildAppTheme(Brightness.dark),
      themeMode: switch (theme) {
        ThemePreference.system => ThemeMode.system,
        ThemePreference.light => ThemeMode.light,
        ThemePreference.dark => ThemeMode.dark,
      },
      home: const HomeShell(),
    );
  }
}
