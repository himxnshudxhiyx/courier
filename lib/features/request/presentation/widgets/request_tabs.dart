import 'package:courier/core/theme/app_theme.dart';
import 'package:courier/core/utils/json_utils.dart';
import 'package:courier/features/request/presentation/providers/request_providers.dart';
import 'package:courier/shared/domain/entities/api_request.dart';
import 'package:courier/shared/presentation/utils/clipboard.dart';
import 'package:courier/shared/presentation/widgets/common_widgets.dart';
import 'package:courier/shared/presentation/widgets/key_value_editor.dart';
import 'package:courier/shared/presentation/widgets/synced_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const _tabPadding = EdgeInsets.fromLTRB(12, 4, 12, 24);

const kHeaderPresets = [
  ('Content-Type', 'application/json'),
  ('Accept', 'application/json'),
  ('Accept', '*/*'),
  ('Cache-Control', 'no-cache'),
  ('Accept-Language', 'en-US'),
  ('X-Requested-With', 'XMLHttpRequest'),
];

class ParamsTab extends ConsumerWidget {
  const ParamsTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final params = ref.watch(requestEditorProvider.select((s) => s.request.params));
    return ListView(
      padding: _tabPadding,
      children: [
        KeyValueEditor(
          items: params,
          onChanged: ref.read(requestEditorProvider.notifier).setParams,
          keyHint: 'Parameter',
          addLabel: 'Add param',
          emptyMessage: 'No query parameters',
        ),
        const InfoNote('Params stay in sync with the URL. Use {{variable}} to insert environment values.'),
      ],
    );
  }
}

class HeadersTab extends ConsumerWidget {
  const HeadersTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final headers = ref.watch(requestEditorProvider.select((s) => s.request.headers));
    return ListView(
      padding: _tabPadding,
      children: [
        KeyValueEditor(
          items: headers,
          onChanged: ref.read(requestEditorProvider.notifier).setHeaders,
          keyHint: 'Header',
          addLabel: 'Add header',
          emptyMessage: 'No custom headers',
          presets: kHeaderPresets,
        ),
        const InfoNote('Content-Type is added from the Body type, and Authorization from the Auth tab.'),
      ],
    );
  }
}

class BodyTab extends ConsumerWidget {
  const BodyTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final request = ref.watch(requestEditorProvider.select((s) => s.request));
    final notifier = ref.read(requestEditorProvider.notifier);
    final scheme = Theme.of(context).colorScheme;
    final type = request.bodyType;
    final showJsonWarning = type == BodyType.json &&
        request.body.trim().isNotEmpty &&
        !request.body.contains('{{') &&
        !isValidJson(request.body);

    return ListView(
      padding: _tabPadding,
      children: [
        const SizedBox(height: 8),
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: [
            for (final t in BodyType.values)
              ChoiceChip(label: Text(t.label), selected: t == type, onSelected: (_) => notifier.setBodyType(t)),
          ],
        ),
        const SizedBox(height: 12),
        if (type == BodyType.none)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: Text('This request has no body.',
                textAlign: TextAlign.center, style: TextStyle(color: scheme.onSurfaceVariant)),
          )
        else if (type.isRaw) ...[
          Row(children: [
            Text(type.contentType!, style: monoStyle(context, fontSize: 12, color: scheme.onSurfaceVariant)),
            const Spacer(),
            if (type == BodyType.json)
              TextButton(
                onPressed: () {
                  if (!notifier.prettifyBody()) showMessage(context, 'Body is not valid JSON');
                },
                child: const Text('Prettify'),
              ),
          ]),
          SyncedTextField(
            value: request.body,
            onChanged: notifier.setBody,
            minLines: 12,
            maxLines: null,
            keyboardType: TextInputType.multiline,
            style: monoStyle(context, fontSize: 13),
            hintText: type == BodyType.json ? '{\n  "key": "value"\n}' : 'Request body',
          ),
          if (showJsonWarning)
            Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Text('Invalid JSON', style: TextStyle(fontSize: 12, color: scheme.error)),
            ),
        ] else ...[
          KeyValueEditor(
            items: request.formFields,
            onChanged: notifier.setFormFields,
            keyHint: 'Field',
            addLabel: 'Add field',
            emptyMessage: 'No form fields',
          ),
          if (type == BodyType.multipart) const InfoNote('Multipart currently supports text fields only.'),
        ],
      ],
    );
  }
}

class AuthTab extends ConsumerWidget {
  const AuthTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(requestEditorProvider.select((s) => s.request.auth));
    final notifier = ref.read(requestEditorProvider.notifier);
    final scheme = Theme.of(context).colorScheme;
    final mono = monoStyle(context, fontSize: 13);

    return ListView(
      padding: _tabPadding,
      children: [
        const SizedBox(height: 8),
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: [
            for (final t in AuthType.values)
              ChoiceChip(
                label: Text(t.label),
                selected: t == auth.type,
                onSelected: (_) => notifier.setAuth(auth.copyWith(type: t)),
              ),
          ],
        ),
        const SizedBox(height: 16),
        ...switch (auth.type) {
          AuthType.none => [
              Text('No authorization will be sent.',
                  textAlign: TextAlign.center, style: TextStyle(color: scheme.onSurfaceVariant)),
            ],
          AuthType.bearer => [
              const _FieldLabel('Token'),
              SyncedTextField(
                value: auth.token,
                onChanged: (v) => notifier.setAuth(auth.copyWith(token: v)),
                minLines: 1,
                maxLines: 5,
                style: mono,
                hintText: 'eyJhbGciOi… or {{token}}',
              ),
              const InfoNote('Sent as "Authorization: Bearer <token>".'),
            ],
          AuthType.basic => [
              const _FieldLabel('Username'),
              SyncedTextField(
                value: auth.username,
                onChanged: (v) => notifier.setAuth(auth.copyWith(username: v)),
                style: mono,
              ),
              const SizedBox(height: 12),
              const _FieldLabel('Password'),
              _SecretField(value: auth.password, onChanged: (v) => notifier.setAuth(auth.copyWith(password: v))),
            ],
          AuthType.apiKey => [
              const _FieldLabel('Key'),
              SyncedTextField(
                value: auth.apiKey,
                onChanged: (v) => notifier.setAuth(auth.copyWith(apiKey: v)),
                style: mono,
                hintText: 'x-api-key',
              ),
              const SizedBox(height: 12),
              const _FieldLabel('Value'),
              _SecretField(value: auth.apiValue, onChanged: (v) => notifier.setAuth(auth.copyWith(apiValue: v))),
              const SizedBox(height: 16),
              const _FieldLabel('Add to'),
              SegmentedButton<bool>(
                segments: const [
                  ButtonSegment(value: false, label: Text('Header')),
                  ButtonSegment(value: true, label: Text('Query param')),
                ],
                selected: {auth.apiKeyInQuery},
                showSelectedIcon: false,
                onSelectionChanged: (s) => notifier.setAuth(auth.copyWith(apiKeyInQuery: s.first)),
              ),
            ],
        },
      ],
    );
  }
}

class _FieldLabel extends StatelessWidget {
  const _FieldLabel(this.text);

  final String text;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 6),
        child: Text(text,
            style: TextStyle(
                fontSize: 13, fontWeight: FontWeight.w500, color: Theme.of(context).colorScheme.onSurfaceVariant)),
      );
}

class _SecretField extends StatefulWidget {
  const _SecretField({required this.value, required this.onChanged});

  final String value;
  final ValueChanged<String> onChanged;

  @override
  State<_SecretField> createState() => _SecretFieldState();
}

class _SecretFieldState extends State<_SecretField> {
  bool _obscured = true;

  @override
  Widget build(BuildContext context) => SyncedTextField(
        value: widget.value,
        onChanged: widget.onChanged,
        obscureText: _obscured,
        style: monoStyle(context, fontSize: 13),
        decoration: InputDecoration(
          suffixIcon: IconButton(
            icon: Icon(_obscured ? Icons.visibility_outlined : Icons.visibility_off_outlined, size: 20),
            onPressed: () => setState(() => _obscured = !_obscured),
          ),
        ),
      );
}
