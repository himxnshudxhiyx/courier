import 'package:courier/core/theme/app_theme.dart';
import 'package:courier/core/utils/formatters.dart';
import 'package:courier/features/collections/presentation/providers/collections_providers.dart';
import 'package:courier/features/collections/presentation/widgets/save_request_dialog.dart';
import 'package:courier/features/environments/presentation/widgets/environment_selector.dart';
import 'package:courier/features/request/presentation/providers/request_providers.dart';
import 'package:courier/features/request/presentation/providers/request_state.dart';
import 'package:courier/features/request/presentation/screens/response_screen.dart';
import 'package:courier/features/request/presentation/widgets/curl_sheets.dart';
import 'package:courier/features/request/presentation/widgets/request_tabs.dart';
import 'package:courier/features/settings/presentation/screens/settings_screen.dart';
import 'package:courier/shared/domain/entities/api_request.dart';
import 'package:courier/shared/presentation/utils/clipboard.dart';
import 'package:courier/shared/presentation/widgets/badges.dart';
import 'package:courier/shared/presentation/widgets/synced_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum _MenuAction { save, saveAs, newRequest, settings }

class RequestScreen extends ConsumerStatefulWidget {
  const RequestScreen({super.key});

  @override
  ConsumerState<RequestScreen> createState() => _RequestScreenState();
}

class _RequestScreenState extends ConsumerState<RequestScreen> with SingleTickerProviderStateMixin {
  late final _tabs = TabController(length: 4, vsync: this);

  @override
  void dispose() {
    _tabs.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(sendControllerProvider, (previous, next) {
      if (previous?.isSending == true && !next.isSending && next.response != null) {
        openResponse(context, next);
      }
    });

    final editor = ref.watch(requestEditorProvider);
    final request = editor.request;
    final activeParams = request.params.where((p) => p.isActive).length;
    final activeHeaders = request.headers.where((h) => h.isActive).length;

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 12,
        title: const Align(alignment: Alignment.centerLeft, child: EnvironmentSelector()),
        actions: [
          IconButton(
            tooltip: 'Import cURL',
            icon: const Icon(Icons.input_rounded),
            onPressed: () => showImportCurlSheet(context),
          ),
          IconButton(
            tooltip: 'Copy as cURL',
            icon: const Icon(Icons.terminal_rounded),
            onPressed: request.isEmpty ? null : () => showCurlExportSheet(context, request),
          ),
          PopupMenuButton<_MenuAction>(
            onSelected: _onMenu,
            itemBuilder: (_) => [
              _menuItem(_MenuAction.save, Icons.bookmark_add_outlined,
                  editor.savedRequestId == null ? 'Save to collection' : 'Save changes'),
              if (editor.savedRequestId != null) _menuItem(_MenuAction.saveAs, Icons.copy_all_outlined, 'Save as new…'),
              _menuItem(_MenuAction.newRequest, Icons.note_add_outlined, 'New request'),
              _menuItem(_MenuAction.settings, Icons.settings_outlined, 'Settings'),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          if (editor.savedRequestName != null) _SavedLabel(name: editor.savedRequestName!),
          const Padding(padding: EdgeInsets.fromLTRB(12, 4, 12, 4), child: _UrlBar()),
          TabBar(
            controller: _tabs,
            isScrollable: true,
            tabs: [
              Tab(child: _TabLabel('Params', badge: activeParams > 0 ? '$activeParams' : null)),
              Tab(child: _TabLabel('Body', badge: request.bodyType != BodyType.none ? '•' : null)),
              Tab(child: _TabLabel('Headers', badge: activeHeaders > 0 ? '$activeHeaders' : null)),
              Tab(child: _TabLabel('Auth', badge: request.auth.type != AuthType.none ? '•' : null)),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabs,
              children: const [ParamsTab(), BodyTab(), HeadersTab(), AuthTab()],
            ),
          ),
          const _ResponseBar(),
        ],
      ),
    );
  }

  PopupMenuItem<_MenuAction> _menuItem(_MenuAction value, IconData icon, String label) => PopupMenuItem(
        value: value,
        child: Row(children: [Icon(icon, size: 20), const SizedBox(width: 12), Text(label)]),
      );

  Future<void> _onMenu(_MenuAction action) async {
    final editor = ref.read(requestEditorProvider);
    switch (action) {
      case _MenuAction.newRequest:
        ref.read(requestEditorProvider.notifier).reset();
        ref.read(sendControllerProvider.notifier).clear();
      case _MenuAction.settings:
        Navigator.of(context).push(MaterialPageRoute(builder: (_) => const SettingsScreen()));
      case _MenuAction.save || _MenuAction.saveAs:
        if (editor.request.isEmpty) {
          showMessage(context, 'Enter a URL before saving');
          return;
        }
        final existing = action == _MenuAction.save
            ? ref.read(collectionsControllerProvider).where((s) => s.id == editor.savedRequestId).firstOrNull
            : null;
        if (existing != null) {
          await ref.read(collectionsControllerProvider.notifier).save(
                id: existing.id,
                name: existing.name,
                folder: existing.folder,
                request: editor.request,
              );
          if (mounted) showMessage(context, 'Saved "${existing.name}"');
          return;
        }
        final saved = await showSaveRequestDialog(context, request: editor.request);
        if (saved != null) {
          ref.read(requestEditorProvider.notifier).markSaved(saved);
          if (mounted) showMessage(context, 'Saved "${saved.name}"');
        }
    }
  }
}

void openResponse(BuildContext context, SendState state) {
  final response = state.response;
  if (response == null) return;
  Navigator.of(context).push(
    MaterialPageRoute(builder: (_) => ResponseScreen(response: response, request: state.request)),
  );
}

class _UrlBar extends ConsumerWidget {
  const _UrlBar();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final request = ref.watch(requestEditorProvider.select((s) => s.request));
    final isSending = ref.watch(sendControllerProvider.select((s) => s.isSending));
    final notifier = ref.read(requestEditorProvider.notifier);
    final scheme = Theme.of(context).colorScheme;

    void send() {
      FocusManager.instance.primaryFocus?.unfocus();
      ref.read(sendControllerProvider.notifier).send();
    }

    void onUrlChanged(String value) {
      // A pasted cURL command (a big jump in length) is imported directly.
      final pasted = value.length - request.url.length > 8;
      if (pasted && value.trimLeft().startsWith('curl ')) {
        final failure = notifier.importCurl(value);
        if (failure == null) {
          ref.read(sendControllerProvider.notifier).clear();
          showMessage(context, 'Imported request from cURL');
          return;
        }
        showMessage(context, 'Could not parse cURL: ${failure.message}');
      }
      notifier.setUrl(value);
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(color: scheme.surfaceContainer, borderRadius: BorderRadius.circular(10)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PopupMenuButton<String>(
                  tooltip: 'Method',
                  initialValue: request.method,
                  onSelected: notifier.setMethod,
                  itemBuilder: (_) => [
                    for (final m in kHttpMethods) PopupMenuItem(value: m, child: MethodBadge(m, fontSize: 13)),
                  ],
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(12, 12, 2, 12),
                    child: Row(mainAxisSize: MainAxisSize.min, children: [
                      MethodBadge(request.method, fontSize: 13),
                      Icon(Icons.arrow_drop_down, size: 18, color: scheme.onSurfaceVariant),
                    ]),
                  ),
                ),
                Expanded(
                  child: SyncedTextField(
                    value: request.url,
                    onChanged: onUrlChanged,
                    minLines: 1,
                    maxLines: 4,
                    keyboardType: TextInputType.url,
                    textInputAction: TextInputAction.go,
                    onSubmitted: (_) => send(),
                    style: monoStyle(context, fontSize: 13.5),
                    decoration: const InputDecoration(
                      hintText: 'Enter URL or paste cURL',
                      fillColor: Colors.transparent,
                      contentPadding: EdgeInsets.fromLTRB(4, 12, 12, 12),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 8),
        SizedBox(
          height: 46,
          child: isSending
              ? OutlinedButton(
                  onPressed: ref.read(sendControllerProvider.notifier).cancel,
                  child: const Text('Cancel'),
                )
              : FilledButton(
                  style: FilledButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                  ),
                  onPressed: request.isEmpty ? null : send,
                  child: const Text('Send'),
                ),
        ),
      ],
    );
  }
}

class _TabLabel extends StatelessWidget {
  const _TabLabel(this.label, {this.badge});

  final String label;
  final String? badge;

  @override
  Widget build(BuildContext context) => Row(mainAxisSize: MainAxisSize.min, children: [
        Text(label),
        if (badge != null) ...[
          const SizedBox(width: 4),
          Text(badge!, style: TextStyle(fontSize: 11, color: Theme.of(context).colorScheme.primary)),
        ],
      ]);
}

class _SavedLabel extends StatelessWidget {
  const _SavedLabel({required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.onSurfaceVariant;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 4),
      child: Row(children: [
        Icon(Icons.bookmark_outline, size: 15, color: color),
        const SizedBox(width: 4),
        Expanded(
          child: Text(name, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 12.5, color: color)),
        ),
      ]),
    );
  }
}

class _ResponseBar extends ConsumerWidget {
  const _ResponseBar();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(sendControllerProvider);
    final scheme = Theme.of(context).colorScheme;
    final response = state.response;
    final failure = state.failure;

    if (state.isSending) {
      return Container(
        color: scheme.surfaceContainerLow,
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          const LinearProgressIndicator(minHeight: 2),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(children: [
              Text('Sending request…', style: TextStyle(color: scheme.onSurfaceVariant)),
            ]),
          ),
        ]),
      );
    }

    if (failure != null) {
      return Container(
        width: double.infinity,
        color: scheme.errorContainer.withValues(alpha: 0.35),
        padding: const EdgeInsets.fromLTRB(16, 10, 4, 10),
        child: Row(children: [
          Icon(Icons.error_outline, color: scheme.error, size: 20),
          const SizedBox(width: 10),
          Expanded(child: Text(failure.message, style: TextStyle(color: scheme.onSurface, fontSize: 13))),
          IconButton(
            tooltip: 'Dismiss',
            icon: const Icon(Icons.close, size: 18),
            onPressed: ref.read(sendControllerProvider.notifier).clear,
          ),
        ]),
      );
    }

    if (response == null) return const SizedBox.shrink();

    return Material(
      color: scheme.surfaceContainerLow,
      child: InkWell(
        onTap: () => openResponse(context, state),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 10, 8, 10),
          child: Row(children: [
            StatusBadge(statusCode: response.statusCode, reasonPhrase: response.reasonPhrase),
            const SizedBox(width: 12),
            MetricChip(icon: Icons.schedule, label: formatDuration(response.durationMs)),
            const SizedBox(width: 12),
            MetricChip(icon: Icons.data_object, label: formatBytes(response.sizeBytes)),
            const Spacer(),
            Text('Response', style: TextStyle(color: scheme.primary, fontWeight: FontWeight.w600)),
            Icon(Icons.chevron_right, color: scheme.primary),
          ]),
        ),
      ),
    );
  }
}
