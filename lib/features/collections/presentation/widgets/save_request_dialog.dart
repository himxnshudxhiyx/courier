import 'package:courier/core/utils/formatters.dart';
import 'package:courier/features/collections/domain/entities/saved_request.dart';
import 'package:courier/features/collections/presentation/providers/collections_providers.dart';
import 'package:courier/shared/domain/entities/api_request.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Saves [request] to a collection, or renames/moves [existing] when given.
Future<SavedRequest?> showSaveRequestDialog(
  BuildContext context, {
  required ApiRequest request,
  SavedRequest? existing,
}) =>
    showDialog<SavedRequest>(
      context: context,
      builder: (_) => _SaveRequestDialog(request: request, existing: existing),
    );

String suggestRequestName(String url) {
  final path = shortUrl(url.split('?').first);
  final segments = path.split('/').where((s) => s.isNotEmpty && !s.startsWith('{{')).toList();
  if (segments.isNotEmpty) return segments.last;
  final host = urlHost(url);
  return host.isEmpty ? 'Untitled request' : host;
}

class _SaveRequestDialog extends ConsumerStatefulWidget {
  const _SaveRequestDialog({required this.request, this.existing});

  final ApiRequest request;
  final SavedRequest? existing;

  @override
  ConsumerState<_SaveRequestDialog> createState() => _SaveRequestDialogState();
}

class _SaveRequestDialogState extends ConsumerState<_SaveRequestDialog> {
  late final _name = TextEditingController(text: widget.existing?.name ?? suggestRequestName(widget.request.url));
  late final _folder = TextEditingController(text: widget.existing?.folder ?? '');

  @override
  void dispose() {
    _name.dispose();
    _folder.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final name = _name.text.trim();
    if (name.isEmpty) return;
    final navigator = Navigator.of(context);
    final saved = await ref.read(collectionsControllerProvider.notifier).save(
          id: widget.existing?.id,
          name: name,
          folder: _folder.text,
          request: widget.request,
        );
    navigator.pop(saved);
  }

  @override
  Widget build(BuildContext context) {
    final folders = ref.watch(collectionFoldersProvider);
    return AlertDialog(
      title: Text(widget.existing == null ? 'Save request' : 'Edit request'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _name,
              autofocus: true,
              decoration: const InputDecoration(labelText: 'Name'),
              onSubmitted: (_) => _save(),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _folder,
              decoration: const InputDecoration(labelText: 'Folder (optional)', hintText: 'e.g. recommendations'),
            ),
            if (folders.isNotEmpty) ...[
              const SizedBox(height: 8),
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: [
                  for (final f in folders)
                    ActionChip(
                      avatar: const Icon(Icons.folder_outlined, size: 16),
                      label: Text(f),
                      onPressed: () => setState(() => _folder.text = f),
                    ),
                ],
              ),
            ],
          ],
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
        FilledButton(onPressed: _save, child: const Text('Save')),
      ],
    );
  }
}
