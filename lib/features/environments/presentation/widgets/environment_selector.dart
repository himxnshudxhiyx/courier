import 'package:courier/app/home_tab_provider.dart';
import 'package:courier/features/environments/presentation/providers/environments_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const _none = '__none__';
const _manage = '__manage__';

class EnvironmentSelector extends ConsumerWidget {
  const EnvironmentSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final active = ref.watch(activeEnvironmentProvider);
    final environments = ref.watch(environmentsControllerProvider);
    final scheme = Theme.of(context).colorScheme;

    return PopupMenuButton<String>(
      tooltip: 'Environment',
      position: PopupMenuPosition.under,
      onSelected: (value) {
        switch (value) {
          case _manage:
            ref.read(selectedHomeTabProvider.notifier).select(HomeTab.environments);
          case _none:
            ref.read(activeEnvironmentIdProvider.notifier).select(null);
          default:
            ref.read(activeEnvironmentIdProvider.notifier).select(value);
        }
      },
      itemBuilder: (_) => [
        CheckedPopupMenuItem(value: _none, checked: active == null, child: const Text('No Environment')),
        for (final e in environments)
          CheckedPopupMenuItem(value: e.id, checked: e.id == active?.id, child: Text(e.name)),
        const PopupMenuDivider(),
        const PopupMenuItem(value: _manage, child: Text('Manage environments')),
      ],
      child: Container(
        padding: const EdgeInsets.fromLTRB(10, 6, 4, 6),
        decoration: BoxDecoration(
          border: Border.all(color: active == null ? scheme.outlineVariant : scheme.primary.withValues(alpha: 0.6)),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          Icon(Icons.layers_outlined, size: 16, color: active == null ? scheme.onSurfaceVariant : scheme.primary),
          const SizedBox(width: 6),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 150),
            child: Text(
              active?.name ?? 'No Environment',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: scheme.onSurface),
            ),
          ),
          Icon(Icons.arrow_drop_down, color: scheme.onSurfaceVariant),
        ]),
      ),
    );
  }
}
