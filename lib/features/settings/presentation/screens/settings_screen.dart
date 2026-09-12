import 'package:courier/features/history/presentation/providers/history_providers.dart';
import 'package:courier/features/settings/domain/entities/app_settings.dart';
import 'package:courier/features/settings/presentation/providers/settings_providers.dart';
import 'package:courier/shared/presentation/utils/clipboard.dart';
import 'package:courier/shared/presentation/widgets/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const _historyLimits = [50, 100, 200, 500, 1000];

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsControllerProvider);
    final controller = ref.read(settingsControllerProvider.notifier);
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 32),
        children: [
          const SectionLabel('Appearance'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SegmentedButton<ThemePreference>(
              segments: const [
                ButtonSegment(value: ThemePreference.system, label: Text('System'), icon: Icon(Icons.brightness_auto)),
                ButtonSegment(value: ThemePreference.light, label: Text('Light'), icon: Icon(Icons.light_mode_outlined)),
                ButtonSegment(value: ThemePreference.dark, label: Text('Dark'), icon: Icon(Icons.dark_mode_outlined)),
              ],
              selected: {settings.theme},
              onSelectionChanged: (s) => controller.save(settings.copyWith(theme: s.first)),
            ),
          ),
          const SectionLabel('Requests'),
          ListTile(
            title: const Text('Timeout'),
            trailing: Text('${settings.timeoutSeconds}s', style: const TextStyle(fontWeight: FontWeight.w600)),
            subtitle: Slider(
              min: 5,
              max: 120,
              divisions: 23,
              value: settings.timeoutSeconds.clamp(5, 120).toDouble(),
              label: '${settings.timeoutSeconds}s',
              onChanged: (v) => controller.save(settings.copyWith(timeoutSeconds: v.round())),
            ),
          ),
          SwitchListTile(
            title: const Text('Follow redirects'),
            value: settings.followRedirects,
            onChanged: (v) => controller.save(settings.copyWith(followRedirects: v)),
          ),
          SwitchListTile(
            title: const Text('Verify SSL certificates'),
            subtitle: const Text('Turn off to call dev servers with self-signed certificates'),
            value: settings.verifySsl,
            onChanged: (v) => controller.save(settings.copyWith(verifySsl: v)),
          ),
          const SectionLabel('History'),
          SwitchListTile(
            title: const Text('Save response bodies'),
            subtitle: const Text('Keeps up to 256 KB per entry so you can review responses later'),
            value: settings.saveResponseBodies,
            onChanged: (v) => controller.save(settings.copyWith(saveResponseBodies: v)),
          ),
          ListTile(
            title: const Text('Keep last'),
            trailing: DropdownButton<int>(
              value: _historyLimits.contains(settings.historyLimit) ? settings.historyLimit : 200,
              underline: const SizedBox.shrink(),
              items: [for (final n in _historyLimits) DropdownMenuItem(value: n, child: Text('$n requests'))],
              onChanged: (v) {
                if (v != null) controller.save(settings.copyWith(historyLimit: v));
              },
            ),
          ),
          ListTile(
            leading: Icon(Icons.delete_sweep_outlined, color: scheme.error),
            title: Text('Clear history', style: TextStyle(color: scheme.error)),
            onTap: () async {
              final confirmed = await showConfirmDialog(
                context,
                title: 'Clear history?',
                message: 'All saved history entries will be removed.',
                confirmLabel: 'Clear',
              );
              if (!confirmed) return;
              await ref.read(historyControllerProvider.notifier).clear();
              if (context.mounted) showMessage(context, 'History cleared');
            },
          ),
          const SectionLabel('About'),
          const ListTile(
            leading: Icon(Icons.send_rounded),
            title: Text('Courier'),
            subtitle: Text('Version 1.0.0 · Send and inspect API requests from your phone'),
          ),
        ],
      ),
    );
  }
}
