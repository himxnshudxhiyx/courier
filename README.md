<p align="center">
  <img src="assets/icon/icon_rounded.png" alt="Courier app icon" width="128" height="128">
</p>

<h1 align="center">Courier</h1>

<p align="center">
  A mobile API client, like Bruno or Postman, built for phones. Paste a cURL command, adjust the request, send it, and inspect the response without leaving your device.
</p>

<p align="center">
  Built with Flutter, clean architecture, Riverpod (codegen), freezed and Hive.
</p>

## Features

**Requests**
- **Import cURL** by pasting it straight into the URL field or using the import sheet. Handles output from Bruno, Postman, Chrome/Firefox DevTools and terminals: `'…'`, `"…"` and `$'…'` quoting, line continuations, `-X`, `-H`, `-d`/`--data-raw`/`--data-binary`/`--data-urlencode`, `--json`, `-F`, `-u`, `-G`, `-I`, `-A`, `-b`, `-e`, and combined flags such as `-sSL`.
- **Params** stay in sync with the URL's query string.
- **Body**: None, JSON (with Prettify and a validity hint), Text, XML, Form URL Encoded, and Multipart (text fields).
- **Headers** with one-tap presets and a bulk-edit mode (`key: value` per line).
- **Auth**: Bearer token, Basic, and API key (sent as a header or query param). An `Authorization` header in an imported cURL is moved into the Auth tab.
- **Copy as cURL**: copy or share, with or without environment variables filled in.
- **Cancel** a request while it's in flight.

**Responses**
- Status, total time, time to first byte (TTFB) and size.
- Pretty/Raw JSON with syntax highlighting, search with match count, and a line-wrap toggle.
- Image previews for `image/*` responses.
- Response headers, plus what was actually sent: final URL, headers, body and redirects.
- Copy or share the body.

**Organisation**
- **History**: every request is saved automatically with its response (up to 256 KB per entry). Entries are grouped by day and searchable. Swipe to delete (with undo), or tap to reopen the request, view the response, copy as cURL or save to a collection.
- **Collections**: save requests into folders, then rename, move, duplicate or delete them.
- **Environments** such as Dev and Prod with variables. Use `{{baseUrl}}`, `{{token}}` and so on anywhere in a request. Built-in dynamic variables: `{{$timestamp}}`, `{{$timestampMs}}`, `{{$isoTimestamp}}`, `{{$randomInt}}`, `{{$guid}}`. Sending is blocked if a variable can't be resolved.
- **Settings**: theme (system, light or dark), timeout, follow redirects, SSL verification (turn it off for self-signed dev servers), whether to save response bodies, and the history limit.

## Requirements

| Tool | Version |
| --- | --- |
| Flutter | 3.47.2, managed with [fvm](https://fvm.app) |
| Dart | 3.13 |
| Xcode | Required for iOS builds |
| Android SDK | Required for Android builds |
| Python 3 + Pillow | Only needed to regenerate the app icon |

If you don't use fvm, drop the `fvm` prefix from the commands below.

## Getting started

```sh
fvm flutter pub get
fvm dart run build_runner build   # generates *.g.dart and *.freezed.dart
fvm flutter run
```

Generated files are included in the project (commit them too), so the app builds without running codegen first. Re-run `build_runner` whenever you change a freezed entity, a `@riverpod` provider or a Hive model. During development, `fvm dart run build_runner watch` regenerates on save.

## Tests and analysis

```sh
fvm flutter analyze
fvm flutter test
```

`test/curl_test.dart` covers cURL parsing, variable and auth resolution, and a round trip from a request to cURL and back.

## Building

```sh
# iOS: development-signed IPA → build/ios/ipa/
fvm flutter build ipa --release --export-method development

# Android
fvm flutter build apk --release
```

The iOS project uses automatic signing with team `HYARC37HZZ`. A development IPA only installs on devices registered in that team's provisioning profile.

## Architecture

The code follows clean architecture, organised by feature. Dependencies point inward: `presentation → domain ← data`.

```
lib/
├── main.dart                  # opens Hive, then runs the app in a ProviderScope
├── app/                       # MaterialApp, bottom-nav shell, tab provider, openInEditor()
├── core/
│   ├── error/                 # Failure types and Result<T> (Ok / Err)
│   ├── network/               # CancelToken
│   ├── storage/               # Hive setup, box providers, @GenerateAdapters spec
│   ├── theme/                 # light/dark themes, method, status and code colours
│   └── utils/                 # formatters, ids, JSON helpers
├── shared/
│   ├── domain/entities/       # ApiRequest, KeyValuePair, AuthConfig, ApiResponse (freezed)
│   ├── data/models/           # Hive models for requests and responses, with mappers
│   └── presentation/          # KeyValueEditor, CodeView, SyncedTextField, badges, dialogs
└── features/
    ├── request/               # editor, sending, response viewer, cURL import/export
    ├── history/
    ├── collections/
    ├── environments/
    └── settings/
```

Each feature has the same layout:

```
feature/
├── domain/        # pure Dart: entities (freezed), repository interfaces, use cases
├── data/          # Hive models + mappers, data sources, repository implementations
└── presentation/  # @riverpod providers and notifiers, screens, widgets
```

Key pieces:

- **Domain services** (`features/request/domain/services/`): `CurlParser`, `CurlGenerator`, `prepareRequest` (variables, auth, content type and form encoding) and URL/param syncing. All are pure Dart with no Flutter dependencies.
- **HTTP** (`features/request/data/datasources/http_remote_data_source.dart`) uses `dart:io`'s `HttpClient` directly. That exposes redirects, TTFB, certificate overrides and cancellation. Errors are mapped to `Failure` types and returned as a `Result`.
- **State**: `RequestEditor` holds the request being edited, and `SendController` handles sending, cancelling and recording history. Each feature has a controller over its repository. Controllers update state before writing to Hive, so text fields bound to them don't lose keystrokes.
- **Dependency injection** is done with Riverpod providers. Hive boxes are exposed as providers (`core/storage/storage_providers.dart`), so tests can override them.

## Storage

Data is stored in Hive boxes under the app's documents directory (`courier/`): `history`, `collections`, `environments`, `settings` and `preferences`.

Adapters are generated from `lib/core/storage/hive_adapters.dart` with `hive_ce`, the maintained fork of Hive. Enums are stored by name. **Commit `hive_adapters.g.yaml`**: it records field indices so existing data stays readable as models change. To add a stored type, create the model plus its mappers, add an `AdapterSpec` to that file, open a box in `hive_storage.dart`, and re-run `build_runner`.

## App icon and launch screen

The icon and the launch-screen images are drawn by `tool/generate_icon.py`. Its colours and geometry are defined at the top of the file. To regenerate the images and apply them to both platforms:

```sh
python3 tool/generate_icon.py
fvm dart run flutter_launcher_icons
fvm dart run flutter_native_splash:create
```

- **Icon:** configured in `flutter_launcher_icons.yaml`. Android gets an adaptive icon made from separate foreground and background images.
- **Launch screen:** configured in `flutter_native_splash.yaml`. It shows the plane centred on `#171717`, the dark theme's background colour, and includes Android 12's splash screen.

## Platform notes

- **Plain HTTP** is allowed so local and dev servers work: `usesCleartextTraffic` on Android and `NSAllowsArbitraryLoads` on iOS. Tighten these before a store release.
- **URLs without a scheme** get `https://` added when sent.

## Limitations and ideas

- Multipart bodies support text fields only; there's no file upload yet.
- The request being edited isn't kept after the app is closed; save it to a collection to keep it.
- Very large responses (over 300 KB) are shown without syntax highlighting.
- Ideas:
  - response checks (status and JSON-path conditions)
  - importing Bruno or Postman collections
  - a collapsible JSON tree
  - a "Share to Courier" share target
  - multiple request tabs
