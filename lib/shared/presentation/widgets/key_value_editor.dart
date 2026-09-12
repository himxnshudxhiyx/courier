import 'package:courier/core/theme/app_theme.dart';
import 'package:courier/shared/domain/entities/api_request.dart';
import 'package:courier/shared/presentation/widgets/synced_text_field.dart';
import 'package:flutter/material.dart';

/// Editable list of key/value rows with enable toggles, presets and a bulk
/// "key: value" text mode (handy for pasting many headers at once).
class KeyValueEditor extends StatefulWidget {
  const KeyValueEditor({
    super.key,
    required this.items,
    required this.onChanged,
    this.keyHint = 'Key',
    this.valueHint = 'Value',
    this.addLabel = 'Add',
    this.emptyMessage = 'Nothing added yet',
    this.presets = const [],
  });

  final List<KeyValuePair> items;
  final ValueChanged<List<KeyValuePair>> onChanged;
  final String keyHint;
  final String valueHint;
  final String addLabel;
  final String emptyMessage;
  final List<(String, String)> presets;

  @override
  State<KeyValueEditor> createState() => _KeyValueEditorState();
}

class _KeyValueEditorState extends State<KeyValueEditor> {
  // Non-null while in bulk mode. Not synced from props while typing, so
  // partially typed lines aren't rewritten under the cursor.
  TextEditingController? _bulkController;

  @override
  void dispose() {
    _bulkController?.dispose();
    super.dispose();
  }

  void _toggleBulk() => setState(() {
        if (_bulkController != null) {
          _bulkController!.dispose();
          _bulkController = null;
        } else {
          _bulkController = TextEditingController(
            text: widget.items
                .where((e) => !e.isEmpty)
                .map((e) => '${e.enabled ? '' : '# '}${e.key}: ${e.value}')
                .join('\n'),
          );
        }
      });

  void _applyBulk(String text) {
    final previous = widget.items;
    final lines = text.split('\n').where((l) => l.trim().isNotEmpty).toList();
    widget.onChanged([
      for (var i = 0; i < lines.length; i++) _parseLine(lines[i], i < previous.length ? previous[i].id : null),
    ]);
  }

  static KeyValuePair _parseLine(String line, String? id) {
    var text = line.trim();
    final enabled = !text.startsWith('#');
    if (!enabled) text = text.substring(1).trim();
    final colon = text.indexOf(':');
    final pair = KeyValuePair.create(
      key: (colon < 0 ? text : text.substring(0, colon)).trim(),
      value: colon < 0 ? '' : text.substring(colon + 1).trim(),
      enabled: enabled,
    );
    return id == null ? pair : pair.copyWith(id: id);
  }

  void _add([String key = '', String value = '']) =>
      widget.onChanged([...widget.items, KeyValuePair.create(key: key, value: value)]);

  void _update(KeyValuePair item) =>
      widget.onChanged([for (final e in widget.items) e.id == item.id ? item : e]);

  void _remove(String id) => widget.onChanged(widget.items.where((e) => e.id != id).toList());

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final bulk = _bulkController != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            TextButton.icon(
              onPressed: bulk ? null : _add,
              icon: const Icon(Icons.add, size: 18),
              label: Text(widget.addLabel),
            ),
            if (widget.presets.isNotEmpty && !bulk)
              PopupMenuButton<(String, String)>(
                tooltip: 'Common values',
                onSelected: (p) => _add(p.$1, p.$2),
                itemBuilder: (_) => [
                  for (final p in widget.presets)
                    PopupMenuItem(value: p, child: Text('${p.$1}: ${p.$2}', style: monoStyle(context, fontSize: 12.5))),
                ],
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                  child: Row(mainAxisSize: MainAxisSize.min, children: [
                    Icon(Icons.bolt, size: 18, color: scheme.primary),
                    const SizedBox(width: 4),
                    Text('Presets', style: TextStyle(color: scheme.primary, fontWeight: FontWeight.w500)),
                  ]),
                ),
              ),
            const Spacer(),
            TextButton(onPressed: _toggleBulk, child: Text(bulk ? 'Key/Value' : 'Bulk Edit')),
          ],
        ),
        if (bulk) ...[
          TextField(
            controller: _bulkController,
            onChanged: _applyBulk,
            minLines: 6,
            maxLines: null,
            autocorrect: false,
            enableSuggestions: false,
            smartQuotesType: SmartQuotesType.disabled,
            smartDashesType: SmartDashesType.disabled,
            style: monoStyle(context, fontSize: 12.5),
            decoration: const InputDecoration(hintText: 'key: value\n# disabled-key: value'),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Text(
              'One per line as "key: value". Prefix with # to disable.',
              style: TextStyle(fontSize: 12, color: scheme.onSurfaceVariant),
            ),
          ),
        ] else if (widget.items.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Text(widget.emptyMessage,
                textAlign: TextAlign.center, style: TextStyle(color: scheme.onSurfaceVariant)),
          )
        else
          for (final item in widget.items)
            _KeyValueRow(
              key: ValueKey(item.id),
              item: item,
              keyHint: widget.keyHint,
              valueHint: widget.valueHint,
              onChanged: _update,
              onRemove: () => _remove(item.id),
            ),
      ],
    );
  }
}

class _KeyValueRow extends StatelessWidget {
  const _KeyValueRow({
    super.key,
    required this.item,
    required this.keyHint,
    required this.valueHint,
    required this.onChanged,
    required this.onRemove,
  });

  final KeyValuePair item;
  final String keyHint;
  final String valueHint;
  final ValueChanged<KeyValuePair> onChanged;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final style = monoStyle(context, fontSize: 13);
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 34,
            height: 42,
            child: Checkbox(
              value: item.enabled,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              visualDensity: VisualDensity.compact,
              onChanged: (v) => onChanged(item.copyWith(enabled: v ?? true)),
            ),
          ),
          Expanded(
            flex: 2,
            child: Opacity(
              opacity: item.enabled ? 1 : 0.5,
              child: SyncedTextField(
                value: item.key,
                hintText: keyHint,
                style: style,
                onChanged: (v) => onChanged(item.copyWith(key: v)),
              ),
            ),
          ),
          const SizedBox(width: 6),
          Expanded(
            flex: 3,
            child: Opacity(
              opacity: item.enabled ? 1 : 0.5,
              child: SyncedTextField(
                value: item.value,
                hintText: valueHint,
                style: style,
                minLines: 1,
                maxLines: 4,
                onChanged: (v) => onChanged(item.copyWith(value: v)),
              ),
            ),
          ),
          IconButton(
            tooltip: 'Remove',
            visualDensity: VisualDensity.compact,
            icon: const Icon(Icons.close, size: 18),
            onPressed: onRemove,
          ),
        ],
      ),
    );
  }
}
