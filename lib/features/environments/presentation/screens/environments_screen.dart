import 'package:courier/features/environments/domain/entities/environment.dart';
import 'package:courier/features/environments/presentation/providers/environments_providers.dart';
import 'package:courier/features/environments/presentation/screens/environment_editor_screen.dart';
import 'package:courier/shared/presentation/widgets/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum _EnvAction { rename, duplicate, delete }

class EnvironmentsScreen extends ConsumerWidget {
  const EnvironmentsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final environments = ref.watch(environmentsControllerProvider);
    final activeId = ref.watch(activeEnvironmentIdProvider);
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Environments')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _create(context, ref),
        icon: const Icon(Icons.add),
        label: const Text('New'),
      ),
      body: environments.isEmpty
          ? const EmptyState(
              icon: Icons.layers_outlined,
              title: 'No environments',
              message: 'Create environments like Dev and Prod with variables such as baseUrl and token, '
                  'then use {{baseUrl}} in any request.',
            )
          : ListView(
              padding: const EdgeInsets.only(bottom: 96),
              children: [
                for (final env in environments)
                  ListTile(
                    leading: IconButton(
                      tooltip: env.id == activeId ? 'Active' : 'Set active',
                      icon: Icon(
                        env.id == activeId ? Icons.check_circle : Icons.radio_button_unchecked,
                        color: env.id == activeId ? scheme.primary : null,
                      ),
                      onPressed: () =>
                          ref.read(activeEnvironmentIdProvider.notifier).select(env.id == activeId ? null : env.id),
                    ),
                    title: Text(env.name),
                    subtitle: Text(_variableSummary(env)),
                    onTap: () => _openEditor(context, env),
                    trailing: PopupMenuButton<_EnvAction>(
                      onSelected: (a) => _onAction(context, ref, env, a),
                      itemBuilder: (_) => const [
                        PopupMenuItem(value: _EnvAction.rename, child: Text('Rename')),
                        PopupMenuItem(value: _EnvAction.duplicate, child: Text('Duplicate')),
                        PopupMenuItem(value: _EnvAction.delete, child: Text('Delete')),
                      ],
                    ),
                  ),
              ],
            ),
    );
  }

  static String _variableSummary(Environment env) {
    final count = env.variables.where((v) => v.isActive).length;
    return count == 1 ? '1 variable' : '$count variables';
  }

  void _openEditor(BuildContext context, Environment env) => Navigator.of(context)
      .push(MaterialPageRoute(builder: (_) => EnvironmentEditorScreen(environmentId: env.id)));

  Future<void> _create(BuildContext context, WidgetRef ref) async {
    final name = await showTextInputDialog(context, title: 'New environment', hintText: 'e.g. Dev', confirmLabel: 'Create');
    if (name == null) return;
    final env = await ref.read(environmentsControllerProvider.notifier).create(name);
    if (ref.read(activeEnvironmentIdProvider) == null) {
      await ref.read(activeEnvironmentIdProvider.notifier).select(env.id);
    }
    if (context.mounted) _openEditor(context, env);
  }

  Future<void> _onAction(BuildContext context, WidgetRef ref, Environment env, _EnvAction action) async {
    final controller = ref.read(environmentsControllerProvider.notifier);
    switch (action) {
      case _EnvAction.rename:
        final name = await showTextInputDialog(context, title: 'Rename environment', initialValue: env.name);
        if (name != null) await controller.save(env.copyWith(name: name));
      case _EnvAction.duplicate:
        await controller.duplicate(env);
      case _EnvAction.delete:
        final confirmed = await showConfirmDialog(
          context,
          title: 'Delete environment?',
          message: '"${env.name}" and its variables will be removed.',
        );
        if (confirmed) await controller.delete(env.id);
    }
  }
}
