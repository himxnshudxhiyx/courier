import 'package:courier/app/home_tab_provider.dart';
import 'package:courier/core/theme/app_theme.dart';
import 'package:courier/core/utils/formatters.dart';
import 'package:courier/features/collections/presentation/widgets/save_request_dialog.dart';
import 'package:courier/features/history/domain/entities/history_entry.dart';
import 'package:courier/features/history/presentation/providers/history_providers.dart';
import 'package:courier/features/request/presentation/screens/response_screen.dart';
import 'package:courier/features/request/presentation/widgets/curl_sheets.dart';
import 'package:courier/shared/presentation/widgets/badges.dart';
import 'package:courier/shared/presentation/widgets/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HistoryScreen extends ConsumerStatefulWidget {
  const HistoryScreen({super.key});

  @override
  ConsumerState<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends ConsumerState<HistoryScreen> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final entries = ref.watch(historyControllerProvider);
    final q = _query.trim().toLowerCase();
    final filtered = q.isEmpty
        ? entries
        : entries
            .where((e) =>
                e.request.url.toLowerCase().contains(q) ||
                e.request.method.toLowerCase() == q ||
                (e.response?.statusCode.toString().startsWith(q) ?? false))
            .toList();

    // Flatten into day headers followed by their entries.
    final rows = <Object>[];
    String? lastDay;
    for (final e in filtered) {
      final day = formatDayLabel(e.timestamp);
      if (day != lastDay) rows.add(lastDay = day);
      rows.add(e);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('History'),
        actions: [
          if (entries.isNotEmpty)
            IconButton(
              tooltip: 'Clear history',
              icon: const Icon(Icons.delete_sweep_outlined),
              onPressed: () async {
                final confirmed = await showConfirmDialog(
                  context,
                  title: 'Clear history?',
                  message: 'All ${entries.length} entries will be removed.',
                  confirmLabel: 'Clear',
                );
                if (confirmed) await ref.read(historyControllerProvider.notifier).clear();
              },
            ),
        ],
      ),
      body: entries.isEmpty
          ? const EmptyState(
              icon: Icons.history,
              title: 'No history yet',
              message: 'Requests you send appear here along with their responses.',
            )
          : Column(children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 0, 12, 8),
                child: TextField(
                  onChanged: (v) => setState(() => _query = v),
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.search, size: 20),
                    hintText: 'Search by URL, method or status',
                  ),
                ),
              ),
              Expanded(
                child: filtered.isEmpty
                    ? const EmptyState(icon: Icons.search_off, title: 'No matches', message: 'Try a different search.')
                    : ListView.builder(
                        padding: const EdgeInsets.only(bottom: 24),
                        itemCount: rows.length,
                        itemBuilder: (context, i) => switch (rows[i]) {
                          final String day => SectionLabel(day, padding: const EdgeInsets.fromLTRB(16, 14, 16, 4)),
                          final HistoryEntry entry => _HistoryTile(key: ValueKey(entry.id), entry: entry),
                          _ => const SizedBox.shrink(),
                        },
                      ),
              ),
            ]),
    );
  }
}

class _HistoryTile extends ConsumerWidget {
  const _HistoryTile({super.key, required this.entry});

  final HistoryEntry entry;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheme = Theme.of(context).colorScheme;
    final response = entry.response;
    final brightness = Theme.of(context).brightness;

    return Dismissible(
      key: ValueKey('dismiss:${entry.id}'),
      direction: DismissDirection.endToStart,
      background: Container(
        color: scheme.error,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        child: Icon(Icons.delete_outline, color: scheme.onError),
      ),
      onDismissed: (_) => _delete(context, ref),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        leading: SizedBox(
          width: 44,
          child: Align(alignment: Alignment.centerLeft, child: MethodBadge(entry.request.method, abbreviate: true)),
        ),
        title: Text(
          shortUrl(entry.request.url.split('?').first),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: monoStyle(context, fontSize: 13.5),
        ),
        subtitle: Text(
          '${urlHost(entry.request.url)} · ${formatTime(entry.timestamp)}',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontSize: 12, color: scheme.onSurfaceVariant),
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if (response != null)
              Text('${response.statusCode}',
                  style: monoStyle(context,
                      fontSize: 13, fontWeight: FontWeight.w700, color: statusColor(response.statusCode, brightness)))
            else
              Text('Error', style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600, color: scheme.error)),
            if (response != null)
              Text(formatDuration(response.durationMs),
                  style: monoStyle(context, fontSize: 11.5, color: scheme.onSurfaceVariant)),
          ],
        ),
        onTap: () => _showActions(context, ref),
      ),
    );
  }

  Future<void> _delete(BuildContext context, WidgetRef ref) async {
    final messenger = ScaffoldMessenger.of(context);
    final controller = ref.read(historyControllerProvider.notifier);
    await controller.delete(entry.id);
    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
        content: const Text('Entry deleted'),
        action: SnackBarAction(label: 'Undo', onPressed: () => controller.restore(entry)),
      ));
  }

  void _showActions(BuildContext context, WidgetRef ref) {
    final response = entry.response;
    showModalBottomSheet<void>(
      context: context,
      builder: (sheetContext) {
        void run(VoidCallback action) {
          Navigator.pop(sheetContext);
          action();
        }

        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  MethodBadge(entry.request.method, fontSize: 13),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(entry.request.url,
                        maxLines: 3, overflow: TextOverflow.ellipsis, style: monoStyle(context, fontSize: 13)),
                  ),
                ]),
              ),
              if (entry.error != null)
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                  child: Text(entry.error!, style: TextStyle(color: Theme.of(context).colorScheme.error, fontSize: 13)),
                ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.edit_outlined),
                title: const Text('Open in editor'),
                onTap: () => run(() => ref.openInEditor(entry.request)),
              ),
              ListTile(
                enabled: response != null,
                leading: const Icon(Icons.visibility_outlined),
                title: const Text('View response'),
                onTap: () => run(() => Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => ResponseScreen(response: response!, request: entry.request),
                    ))),
              ),
              ListTile(
                leading: const Icon(Icons.terminal_rounded),
                title: const Text('Copy as cURL'),
                onTap: () => run(() => showCurlExportSheet(context, entry.request)),
              ),
              ListTile(
                leading: const Icon(Icons.bookmark_add_outlined),
                title: const Text('Save to collection'),
                onTap: () => run(() => showSaveRequestDialog(context, request: entry.request)),
              ),
              ListTile(
                leading: Icon(Icons.delete_outline, color: Theme.of(context).colorScheme.error),
                title: Text('Delete', style: TextStyle(color: Theme.of(context).colorScheme.error)),
                onTap: () => run(() => _delete(context, ref)),
              ),
            ],
          ),
        );
      },
    );
  }
}
