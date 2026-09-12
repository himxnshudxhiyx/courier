// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(httpRepository)
final httpRepositoryProvider = HttpRepositoryProvider._();

final class HttpRepositoryProvider
    extends $FunctionalProvider<HttpRepository, HttpRepository, HttpRepository>
    with $Provider<HttpRepository> {
  HttpRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'httpRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$httpRepositoryHash();

  @$internal
  @override
  $ProviderElement<HttpRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  HttpRepository create(Ref ref) {
    return httpRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(HttpRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<HttpRepository>(value),
    );
  }
}

String _$httpRepositoryHash() => r'6f98df99694cb75522a74538277f906d5615bddb';

@ProviderFor(RequestEditor)
final requestEditorProvider = RequestEditorProvider._();

final class RequestEditorProvider
    extends $NotifierProvider<RequestEditor, RequestEditorState> {
  RequestEditorProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'requestEditorProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$requestEditorHash();

  @$internal
  @override
  RequestEditor create() => RequestEditor();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RequestEditorState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RequestEditorState>(value),
    );
  }
}

String _$requestEditorHash() => r'76105245c2ae18c740fc3182aad96976f74b620c';

abstract class _$RequestEditor extends $Notifier<RequestEditorState> {
  RequestEditorState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<RequestEditorState, RequestEditorState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<RequestEditorState, RequestEditorState>,
              RequestEditorState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

@ProviderFor(SendController)
final sendControllerProvider = SendControllerProvider._();

final class SendControllerProvider
    extends $NotifierProvider<SendController, SendState> {
  SendControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sendControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sendControllerHash();

  @$internal
  @override
  SendController create() => SendController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SendState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SendState>(value),
    );
  }
}

String _$sendControllerHash() => r'643a1dbccff4b31807f0ee46b55b46e1d96572b2';

abstract class _$SendController extends $Notifier<SendState> {
  SendState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<SendState, SendState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<SendState, SendState>,
              SendState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
