// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'storage_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(historyBox)
final historyBoxProvider = HistoryBoxProvider._();

final class HistoryBoxProvider
    extends
        $FunctionalProvider<
          Box<HistoryEntryHiveModel>,
          Box<HistoryEntryHiveModel>,
          Box<HistoryEntryHiveModel>
        >
    with $Provider<Box<HistoryEntryHiveModel>> {
  HistoryBoxProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'historyBoxProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$historyBoxHash();

  @$internal
  @override
  $ProviderElement<Box<HistoryEntryHiveModel>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  Box<HistoryEntryHiveModel> create(Ref ref) {
    return historyBox(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Box<HistoryEntryHiveModel> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Box<HistoryEntryHiveModel>>(value),
    );
  }
}

String _$historyBoxHash() => r'800a5fda534091202ef5104b27b38e9e1bea60f9';

@ProviderFor(collectionsBox)
final collectionsBoxProvider = CollectionsBoxProvider._();

final class CollectionsBoxProvider
    extends
        $FunctionalProvider<
          Box<SavedRequestHiveModel>,
          Box<SavedRequestHiveModel>,
          Box<SavedRequestHiveModel>
        >
    with $Provider<Box<SavedRequestHiveModel>> {
  CollectionsBoxProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'collectionsBoxProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$collectionsBoxHash();

  @$internal
  @override
  $ProviderElement<Box<SavedRequestHiveModel>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  Box<SavedRequestHiveModel> create(Ref ref) {
    return collectionsBox(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Box<SavedRequestHiveModel> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Box<SavedRequestHiveModel>>(value),
    );
  }
}

String _$collectionsBoxHash() => r'17a0939326a528bccc5025e223512c36ea6cc31f';

@ProviderFor(environmentsBox)
final environmentsBoxProvider = EnvironmentsBoxProvider._();

final class EnvironmentsBoxProvider
    extends
        $FunctionalProvider<
          Box<EnvironmentHiveModel>,
          Box<EnvironmentHiveModel>,
          Box<EnvironmentHiveModel>
        >
    with $Provider<Box<EnvironmentHiveModel>> {
  EnvironmentsBoxProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'environmentsBoxProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$environmentsBoxHash();

  @$internal
  @override
  $ProviderElement<Box<EnvironmentHiveModel>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  Box<EnvironmentHiveModel> create(Ref ref) {
    return environmentsBox(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Box<EnvironmentHiveModel> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Box<EnvironmentHiveModel>>(value),
    );
  }
}

String _$environmentsBoxHash() => r'611ef4b32e6f7092e9cc3e38fd7c2ed4e0f600ab';

@ProviderFor(settingsBox)
final settingsBoxProvider = SettingsBoxProvider._();

final class SettingsBoxProvider
    extends
        $FunctionalProvider<
          Box<SettingsHiveModel>,
          Box<SettingsHiveModel>,
          Box<SettingsHiveModel>
        >
    with $Provider<Box<SettingsHiveModel>> {
  SettingsBoxProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'settingsBoxProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$settingsBoxHash();

  @$internal
  @override
  $ProviderElement<Box<SettingsHiveModel>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  Box<SettingsHiveModel> create(Ref ref) {
    return settingsBox(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Box<SettingsHiveModel> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Box<SettingsHiveModel>>(value),
    );
  }
}

String _$settingsBoxHash() => r'30f2281c08b5996c14aa9a32692f7a3c1b6c5818';

@ProviderFor(preferencesBox)
final preferencesBoxProvider = PreferencesBoxProvider._();

final class PreferencesBoxProvider
    extends $FunctionalProvider<Box<String>, Box<String>, Box<String>>
    with $Provider<Box<String>> {
  PreferencesBoxProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'preferencesBoxProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$preferencesBoxHash();

  @$internal
  @override
  $ProviderElement<Box<String>> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Box<String> create(Ref ref) {
    return preferencesBox(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Box<String> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Box<String>>(value),
    );
  }
}

String _$preferencesBoxHash() => r'47324c03de80107b3107294da72cf975a5e5f0e6';
