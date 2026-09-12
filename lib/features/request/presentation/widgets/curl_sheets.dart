import 'package:courier/core/theme/app_theme.dart';
import 'package:courier/features/environments/presentation/providers/environments_providers.dart';
import 'package:courier/features/request/domain/usecases/request_usecases.dart';
import 'package:courier/features/request/presentation/providers/request_providers.dart';
import 'package:courier/shared/domain/entities/api_request.dart';
import 'package:courier/shared/presentation/utils/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';

Future<void> showImportCurlSheet(BuildContext context) => showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => const ImportCurlSheet(),
    );

Future<void> showCurlExportSheet(BuildContext context, ApiRequest request) => showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => CurlExportSheet(request: request),
    );

class ImportCurlSheet extends ConsumerStatefulWidget {
  const ImportCurlSheet({super.key});

  @override
  ConsumerState<ImportCurlSheet> createState() => _ImportCurlSheetState();
}

class _ImportCurlSheetState extends ConsumerState<ImportCurlSheet> {
  final _controller = TextEditingController();
  String? _error;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _paste() async {
    final text = (await Clipboard.getData(Clipboard.kTextPlain))?.text;
    setState(() {
      if (text == null || text.trim().isEmpty) {
        _error = 'Clipboard is empty';
      } else {
        _controller.text = text;
        _error = null;
      }
    });
  }

  void _import() {
    final failure = ref.read(requestEditorProvider.notifier).importCurl(_controller.text);
    if (failure != null) {
      setState(() => _error = failure.message);
      return;
    }
    ref.read(sendControllerProvider.notifier).clear();
    final messenger = ScaffoldMessenger.of(context);
    Navigator.pop(context);
    messenger.showSnackBar(const SnackBar(content: Text('Request imported from cURL')));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 0, 16, 16 + MediaQuery.viewInsetsOf(context).bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Import cURL', style: theme.textTheme.titleLarge),
          const SizedBox(height: 4),
          Text(
            'Paste a command copied from Bruno, Postman, a terminal or browser DevTools.',
            style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _controller,
            minLines: 6,
            maxLines: 12,
            autocorrect: false,
            enableSuggestions: false,
            smartQuotesType: SmartQuotesType.disabled,
            smartDashesType: SmartDashesType.disabled,
            style: monoStyle(context, fontSize: 12.5),
            onChanged: (_) {
              if (_error != null) setState(() => _error = null);
            },
            decoration: InputDecoration(
              hintText: "curl --location 'https://api.example.com/v1/items' \\\n"
                  "  --header 'Content-Type: application/json' \\\n"
                  "  --data '{\"id\": 1}'",
              errorText: _error,
              errorMaxLines: 3,
            ),
          ),
          const SizedBox(height: 12),
          Row(children: [
            OutlinedButton.icon(onPressed: _paste, icon: const Icon(Icons.content_paste, size: 18), label: const Text('Paste')),
            const Spacer(),
            FilledButton.icon(onPressed: _import, icon: const Icon(Icons.check, size: 18), label: const Text('Import')),
          ]),
        ],
      ),
    );
  }
}

class CurlExportSheet extends ConsumerStatefulWidget {
  const CurlExportSheet({super.key, required this.request});

  final ApiRequest request;

  @override
  ConsumerState<CurlExportSheet> createState() => _CurlExportSheetState();
}

class _CurlExportSheetState extends ConsumerState<CurlExportSheet> {
  bool _resolveVariables = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final environment = ref.watch(activeEnvironmentProvider);
    final curl = const GenerateCurl()(
      widget.request,
      variables: ref.watch(activeVariablesProvider),
      resolveVariables: _resolveVariables,
    );

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('cURL', style: theme.textTheme.titleLarge),
          const SizedBox(height: 12),
          ConstrainedBox(
            constraints: BoxConstraints(maxHeight: MediaQuery.sizeOf(context).height * 0.45),
            child: Container(
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainer,
                borderRadius: BorderRadius.circular(10),
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(12),
                child: SelectableText(curl, style: monoStyle(context, fontSize: 12.5)),
              ),
            ),
          ),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Resolve variables'),
            subtitle: Text(environment == null
                ? 'No environment selected, only built-in variables'
                : 'Using "${environment.name}"'),
            value: _resolveVariables,
            onChanged: (v) => setState(() => _resolveVariables = v),
          ),
          Row(children: [
            OutlinedButton.icon(
              onPressed: () => SharePlus.instance.share(ShareParams(text: curl, subject: 'cURL request')),
              icon: const Icon(Icons.ios_share, size: 18),
              label: const Text('Share'),
            ),
            const Spacer(),
            FilledButton.icon(
              onPressed: () {
                copyText(context, curl, message: 'cURL copied');
                Navigator.pop(context);
              },
              icon: const Icon(Icons.copy, size: 18),
              label: const Text('Copy'),
            ),
          ]),
        ],
      ),
    );
  }
}
