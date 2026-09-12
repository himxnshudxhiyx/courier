import 'package:courier/core/theme/app_theme.dart';
import 'package:courier/core/utils/formatters.dart';
import 'package:courier/core/utils/json_utils.dart';
import 'package:courier/features/request/presentation/widgets/curl_sheets.dart';
import 'package:courier/shared/domain/entities/api_request.dart';
import 'package:courier/shared/domain/entities/api_response.dart';
import 'package:courier/shared/presentation/utils/clipboard.dart';
import 'package:courier/shared/presentation/widgets/badges.dart';
import 'package:courier/shared/presentation/widgets/code_view.dart';
import 'package:courier/shared/presentation/widgets/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class ResponseScreen extends StatefulWidget {
  const ResponseScreen({super.key, required this.response, this.request});

  final ApiResponse response;

  /// The editor request behind this response, used for "Copy as cURL".
  final ApiRequest? request;

  @override
  State<ResponseScreen> createState() => _ResponseScreenState();
}

class _ResponseScreenState extends State<ResponseScreen> with SingleTickerProviderStateMixin {
  late final _tabs = TabController(length: 3, vsync: this);
  late final bool _isJson = widget.response.isJson;
  late final String? _prettyBody = _isJson ? tryPrettyJson(widget.response.body) : null;

  bool _pretty = true;
  bool _wrap = true;
  bool _searching = false;
  String _query = '';

  String get _displayBody => _pretty && _prettyBody != null ? _prettyBody : widget.response.body;

  @override
  void dispose() {
    _tabs.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final r = widget.response;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Response'),
        actions: [
          if (widget.request != null)
            IconButton(
              tooltip: 'Copy as cURL',
              icon: const Icon(Icons.terminal_rounded),
              onPressed: () => showCurlExportSheet(context, widget.request!),
            ),
          IconButton(
            tooltip: 'Share response',
            icon: const Icon(Icons.ios_share),
            onPressed: r.body.isEmpty
                ? null
                : () => SharePlus.instance.share(ShareParams(text: _displayBody, subject: '${r.requestMethod} ${r.requestUrl}')),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
            child: Wrap(
              spacing: 14,
              runSpacing: 8,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                StatusBadge(statusCode: r.statusCode, reasonPhrase: r.reasonPhrase),
                MetricChip(icon: Icons.schedule, label: formatDuration(r.durationMs)),
                if (r.ttfbMs != null) MetricChip(icon: Icons.bolt, label: 'TTFB ${formatDuration(r.ttfbMs!)}'),
                MetricChip(icon: Icons.data_object, label: formatBytes(r.sizeBytes)),
              ],
            ),
          ),
          TabBar(
            controller: _tabs,
            isScrollable: true,
            tabs: [
              const Tab(text: 'Body'),
              Tab(text: 'Headers (${r.headers.length})'),
              const Tab(text: 'Request'),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabs,
              children: [
                _buildBody(context),
                _HeaderList(headers: r.headers, emptyMessage: 'No response headers'),
                _RequestDetails(response: r),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    final r = widget.response;
    final scheme = Theme.of(context).colorScheme;

    if (r.isImage) {
      return InteractiveViewer(
        maxScale: 8,
        child: Center(
          child: Image.memory(r.bytes!, errorBuilder: (_, _, _) => const Text('Could not decode image')),
        ),
      );
    }
    if (r.body.isEmpty) {
      return EmptyState(
        icon: Icons.inbox_outlined,
        title: 'No body',
        message: r.bodyTruncated
            ? 'Response bodies are not being saved in history. You can change this in Settings.'
            : 'The server returned an empty body.',
      );
    }

    final text = _displayBody;
    final matches = countMatches(text, _query);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 8, 4, 0),
          child: Row(children: [
            if (_prettyBody != null)
              SegmentedButton<bool>(
                segments: const [
                  ButtonSegment(value: true, label: Text('Pretty')),
                  ButtonSegment(value: false, label: Text('Raw')),
                ],
                selected: {_pretty},
                showSelectedIcon: false,
                style: const ButtonStyle(
                  visualDensity: VisualDensity.compact,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                onSelectionChanged: (s) => setState(() => _pretty = s.first),
              )
            else
              Flexible(
                child: Text(
                  r.contentType.isEmpty ? 'Body' : r.contentType.split(';').first,
                  overflow: TextOverflow.ellipsis,
                  style: monoStyle(context, fontSize: 12, color: scheme.onSurfaceVariant),
                ),
              ),
            const Spacer(),
            IconButton(
              tooltip: _wrap ? 'Turn off line wrap' : 'Wrap lines',
              isSelected: _wrap,
              icon: const Icon(Icons.wrap_text),
              onPressed: () => setState(() => _wrap = !_wrap),
            ),
            IconButton(
              tooltip: 'Search',
              isSelected: _searching,
              icon: const Icon(Icons.search),
              onPressed: () => setState(() {
                _searching = !_searching;
                if (!_searching) _query = '';
              }),
            ),
            IconButton(
              tooltip: 'Copy body',
              icon: const Icon(Icons.copy_rounded),
              onPressed: () => copyText(context, text, message: 'Response body copied'),
            ),
          ]),
        ),
        if (_searching)
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 4, 12, 4),
            child: TextField(
              autofocus: true,
              autocorrect: false,
              onChanged: (v) => setState(() => _query = v),
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search, size: 20),
                hintText: 'Find in response',
                suffixText: _query.isEmpty ? null : '$matches ${matches == 1 ? 'match' : 'matches'}',
              ),
            ),
          ),
        if (r.bodyTruncated)
          Container(
            margin: const EdgeInsets.fromLTRB(12, 6, 12, 0),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: scheme.secondaryContainer.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'History keeps the first ${formatBytes(r.body.length)} of this response.',
              style: const TextStyle(fontSize: 12.5),
            ),
          ),
        Expanded(child: CodeView(text: text, json: _isJson, search: _query, wrap: _wrap)),
      ],
    );
  }
}

class _HeaderList extends StatelessWidget {
  const _HeaderList({required this.headers, required this.emptyMessage});

  final Map<String, String> headers;
  final String emptyMessage;

  @override
  Widget build(BuildContext context) {
    if (headers.isEmpty) {
      return EmptyState(icon: Icons.list_alt, title: 'No headers', message: emptyMessage);
    }
    final entries = headers.entries.toList();
    return ListView(
      padding: const EdgeInsets.only(bottom: 24),
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: TextButton.icon(
            onPressed: () => copyText(
              context,
              entries.map((e) => '${e.key}: ${e.value}').join('\n'),
              message: 'Headers copied',
            ),
            icon: const Icon(Icons.copy_rounded, size: 16),
            label: const Text('Copy all'),
          ),
        ),
        for (final e in entries) _HeaderRow(name: e.key, value: e.value),
      ],
    );
  }
}

class _HeaderRow extends StatelessWidget {
  const _HeaderRow({required this.name, required this.value});

  final String name;
  final String value;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return InkWell(
      onLongPress: () => copyText(context, '$name: $value', message: 'Header copied'),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
        decoration: BoxDecoration(border: Border(bottom: BorderSide(color: scheme.outlineVariant))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(name,
                style: monoStyle(context, fontSize: 12, color: scheme.onSurfaceVariant, fontWeight: FontWeight.w600)),
            const SizedBox(height: 2),
            SelectableText(value, style: monoStyle(context, fontSize: 13)),
          ],
        ),
      ),
    );
  }
}

class _RequestDetails extends StatelessWidget {
  const _RequestDetails({required this.response});

  final ApiResponse response;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final body = response.requestBody;
    return ListView(
      padding: const EdgeInsets.only(bottom: 24),
      children: [
        const SectionLabel('URL'),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            MethodBadge(response.requestMethod, fontSize: 13),
            const SizedBox(width: 8),
            Expanded(child: SelectableText(response.requestUrl, style: monoStyle(context, fontSize: 13))),
          ]),
        ),
        if (response.redirects.isNotEmpty) ...[
          const SectionLabel('Redirects'),
          for (final r in response.redirects)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
              child: SelectableText(r, style: monoStyle(context, fontSize: 12.5)),
            ),
        ],
        const SectionLabel('Headers sent'),
        if (response.requestHeaders.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text('None', style: TextStyle(color: scheme.onSurfaceVariant)),
          )
        else
          for (final e in response.requestHeaders.entries) _HeaderRow(name: e.key, value: e.value),
        if (body != null && body.isNotEmpty) ...[
          const SectionLabel('Body sent'),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(color: scheme.surfaceContainer, borderRadius: BorderRadius.circular(8)),
            padding: const EdgeInsets.all(12),
            child: SelectableText(body, style: monoStyle(context, fontSize: 12.5)),
          ),
        ],
      ],
    );
  }
}
