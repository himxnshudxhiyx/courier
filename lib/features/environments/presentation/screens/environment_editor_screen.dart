import 'package:courier/core/theme/app_theme.dart';
import 'package:courier/features/environments/presentation/providers/environments_providers.dart';
import 'package:courier/features/request/domain/services/request_preparer.dart';
import 'package:courier/shared/presentation/widgets/common_widgets.dart';
import 'package:courier/shared/presentation/widgets/key_value_editor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EnvironmentEditorScreen extends ConsumerWidget {
  const EnvironmentEditorScreen({super.key, required this.environmentId});

  final String environmentId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final environment =
        ref.watch(environmentsControllerProvider.select((list) => list.where((e) => e.id == environmentId).firstOrNull));
    final isActive = ref.watch(activeEnvironmentIdProvider) == environmentId;
    final scheme = Theme.of(context).colorScheme;

    if (environment == null) {
      return Scaffold(appBar: AppBar(), body: const EmptyState(icon: Icons.layers_clear, title: 'Environment deleted', message: ''));
    }

    final controller = ref.read(environmentsControllerProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text(environment.name),
        actions: [
          IconButton(
            tooltip: 'Rename',
            icon: const Icon(Icons.edit_outlined),
            onPressed: () async {
              final name = await showTextInputDialog(context, title: 'Rename environment', initialValue: environment.name);
              if (name != null) await controller.save(environment.copyWith(name: name));
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(12, 0, 12, 32),
        children: [
          SwitchListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 4),
            title: const Text('Active environment'),
            subtitle: const Text('Variables are substituted when sending requests'),
            value: isActive,
            onChanged: (on) => ref.read(activeEnvironmentIdProvider.notifier).select(on ? environmentId : null),
          ),
          const SectionLabel('Variables', padding: EdgeInsets.fromLTRB(4, 12, 4, 0)),
          KeyValueEditor(
            items: environment.variables,
            onChanged: (variables) => controller.save(environment.copyWith(variables: variables)),
            keyHint: 'Name',
            addLabel: 'Add variable',
            emptyMessage: 'No variables yet. Try baseUrl or token.',
          ),
          const SectionLabel('Usage', padding: EdgeInsets.fromLTRB(4, 20, 4, 8)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Text(
              'Reference variables as {{name}} in the URL, params, headers, body or auth. '
              'Built-in dynamic variables work without an environment:',
              style: TextStyle(color: scheme.onSurfaceVariant, fontSize: 13),
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: [
              for (final v in kDynamicVariables)
                Chip(label: Text('{{$v}}', style: monoStyle(context, fontSize: 12))),
            ],
          ),
        ],
      ),
    );
  }
}
