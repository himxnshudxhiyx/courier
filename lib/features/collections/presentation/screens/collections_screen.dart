import 'package:courier/app/home_tab_provider.dart';
import 'package:courier/core/theme/app_theme.dart';
import 'package:courier/features/collections/domain/entities/saved_request.dart';
import 'package:courier/features/collections/presentation/providers/collections_providers.dart';
import 'package:courier/features/collections/presentation/widgets/save_request_dialog.dart';
import 'package:courier/features/request/presentation/widgets/curl_sheets.dart';
import 'package:courier/shared/presentation/widgets/badges.dart';
import 'package:courier/shared/presentation/widgets/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum _ItemAction { edit, duplicate, copyCurl, delete }

class CollectionsScreen extends ConsumerStatefulWidget {
  const CollectionsScreen({super.key});

  @override
  ConsumerState<CollectionsScreen> createState() => _CollectionsScreenState();
}

class _CollectionsScreenState extends ConsumerState<CollectionsScreen> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final saved = ref.watch(collectionsControllerProvider);
    final q = _query.trim().toLowerCase();
    final filtered = q.isEmpty
        ? saved
        : saved
            .where((s) =>
                s.name.toLowerCase().contains(q) ||
                s.folder.toLowerCase().contains(q) ||
                s.request.url.toLowerCase().contains(q))
            .toList();

    final byFolder = <String, List<SavedRequest>>{};
    for (final s in filtered) {
      byFolder.putIfAbsent(s.folder, () => []).add(s);
    }
    // Named folders first, loose requests last.
    final folders = byFolder.keys.toList()
      ..sort((a, b) {
        if (a.isEmpty != b.isEmpty) return a.isEmpty ? 1 : -1;
        return a.toLowerCase().compareTo(b.toLowerCase());
      });

    return Scaffold(
      appBar: AppBar(title: const Text('Collections')),
      body: saved.isEmpty
          ? const EmptyState(
              icon: Icons.folder_open_outlined,
              title: 'No saved requests',
              message: 'Save a request from the editor menu (⋮ → Save to collection) to reuse it later.',
            )
          : Column(children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 0, 12, 8),
                child: TextField(
                  onChanged: (v) => setState(() => _query = v),
                  decoration: const InputDecoration(prefixIcon: Icon(Icons.search, size: 20), hintText: 'Search requests'),
                ),
              ),
              Expanded(
                child: filtered.isEmpty
                    ? const EmptyState(icon: Icons.search_off, title: 'No matches', message: 'Try a different search.')
                    : ListView(
                        padding: const EdgeInsets.only(bottom: 24),
                        children: [
                          for (final folder in folders)
                            ExpansionTile(
                              key: PageStorageKey('folder:$folder'),
                              initiallyExpanded: true,
                              leading: Icon(folder.isEmpty ? Icons.description_outlined : Icons.folder_outlined),
                              title: Text(folder.isEmpty ? 'Unsorted' : folder),
                              subtitle: Text('${byFolder[folder]!.length} requests'),
                              childrenPadding: const EdgeInsets.only(left: 8),
                              children: [for (final s in byFolder[folder]!) _SavedRequestTile(saved: s)],
                            ),
                        ],
                      ),
              ),
            ]),
    );
  }
}

class _SavedRequestTile extends ConsumerWidget {
  const _SavedRequestTile({required this.saved});

  final SavedRequest saved;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheme = Theme.of(context).colorScheme;
    return ListTile(
      contentPadding: const EdgeInsets.only(left: 16, right: 4),
      leading: SizedBox(
        width: 44,
        child: Align(alignment: Alignment.centerLeft, child: MethodBadge(saved.request.method, abbreviate: true)),
      ),
      title: Text(saved.name, maxLines: 1, overflow: TextOverflow.ellipsis),
      subtitle: Text(
        saved.request.url,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: monoStyle(context, fontSize: 12, color: scheme.onSurfaceVariant),
      ),
      onTap: () => ref.openInEditor(saved.request, saved: saved),
      trailing: PopupMenuButton<_ItemAction>(
        onSelected: (action) => _onAction(context, ref, action),
        itemBuilder: (_) => const [
          PopupMenuItem(value: _ItemAction.edit, child: Text('Rename / move')),
          PopupMenuItem(value: _ItemAction.duplicate, child: Text('Duplicate')),
          PopupMenuItem(value: _ItemAction.copyCurl, child: Text('Copy as cURL')),
          PopupMenuItem(value: _ItemAction.delete, child: Text('Delete')),
        ],
      ),
    );
  }

  Future<void> _onAction(BuildContext context, WidgetRef ref, _ItemAction action) async {
    final controller = ref.read(collectionsControllerProvider.notifier);
    switch (action) {
      case _ItemAction.edit:
        await showSaveRequestDialog(context, request: saved.request, existing: saved);
      case _ItemAction.duplicate:
        await controller.duplicate(saved);
      case _ItemAction.copyCurl:
        await showCurlExportSheet(context, saved.request);
      case _ItemAction.delete:
        final confirmed = await showConfirmDialog(
          context,
          title: 'Delete request?',
          message: '"${saved.name}" will be removed from your collections.',
        );
        if (confirmed) await controller.delete(saved.id);
    }
  }
}
