// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'environments_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(environmentsRepository)
final environmentsRepositoryProvider = EnvironmentsRepositoryProvider._();

final class EnvironmentsRepositoryProvider
    extends
        $FunctionalProvider<
          EnvironmentsRepository,
          EnvironmentsRepository,
          EnvironmentsRepository
        >
    with $Provider<EnvironmentsRepository> {
  EnvironmentsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'environmentsRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$environmentsRepositoryHash();

  @$internal
  @override
  $ProviderElement<EnvironmentsRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  EnvironmentsRepository create(Ref ref) {
    return environmentsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(EnvironmentsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<EnvironmentsRepository>(value),
    );
  }
}

String _$environmentsRepositoryHash() =>
    r'2704aba369f31f42849fbfcc020a09426f920daa';

@ProviderFor(EnvironmentsController)
final environmentsControllerProvider = EnvironmentsControllerProvider._();

final class EnvironmentsControllerProvider
    extends $NotifierProvider<EnvironmentsController, List<Environment>> {
  EnvironmentsControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'environmentsControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$environmentsControllerHash();

  @$internal
  @override
  EnvironmentsController create() => EnvironmentsController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<Environment> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<Environment>>(value),
    );
  }
}

String _$environmentsControllerHash() =>
    r'ad65e3e0397ef19bcd2f39ee05bc8b363a011bf5';

abstract class _$EnvironmentsController extends $Notifier<List<Environment>> {
  List<Environment> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<List<Environment>, List<Environment>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<Environment>, List<Environment>>,
              List<Environment>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

@ProviderFor(ActiveEnvironmentId)
final activeEnvironmentIdProvider = ActiveEnvironmentIdProvider._();

final class ActiveEnvironmentIdProvider
    extends $NotifierProvider<ActiveEnvironmentId, String?> {
  ActiveEnvironmentIdProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'activeEnvironmentIdProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$activeEnvironmentIdHash();

  @$internal
  @override
  ActiveEnvironmentId create() => ActiveEnvironmentId();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String?>(value),
    );
  }
}

String _$activeEnvironmentIdHash() =>
    r'e4385fa0abf180ef18b45dcdf81bc1495394fbef';

abstract class _$ActiveEnvironmentId extends $Notifier<String?> {
  String? build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<String?, String?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<String?, String?>,
              String?,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

@ProviderFor(activeEnvironment)
final activeEnvironmentProvider = ActiveEnvironmentProvider._();

final class ActiveEnvironmentProvider
    extends $FunctionalProvider<Environment?, Environment?, Environment?>
    with $Provider<Environment?> {
  ActiveEnvironmentProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'activeEnvironmentProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$activeEnvironmentHash();

  @$internal
  @override
  $ProviderElement<Environment?> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Environment? create(Ref ref) {
    return activeEnvironment(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Environment? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Environment?>(value),
    );
  }
}

String _$activeEnvironmentHash() => r'9eb018f6721a2ddb7566719648463ddab24c5406';

@ProviderFor(activeVariables)
final activeVariablesProvider = ActiveVariablesProvider._();

final class ActiveVariablesProvider
    extends
        $FunctionalProvider<
          List<KeyValuePair>,
          List<KeyValuePair>,
          List<KeyValuePair>
        >
    with $Provider<List<KeyValuePair>> {
  ActiveVariablesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'activeVariablesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$activeVariablesHash();

  @$internal
  @override
  $ProviderElement<List<KeyValuePair>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  List<KeyValuePair> create(Ref ref) {
    return activeVariables(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<KeyValuePair> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<KeyValuePair>>(value),
    );
  }
}

String _$activeVariablesHash() => r'd61900f0cdeeed40ab37ace64e05861c41e03822';
