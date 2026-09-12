// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'collections_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(collectionsRepository)
final collectionsRepositoryProvider = CollectionsRepositoryProvider._();

final class CollectionsRepositoryProvider
    extends
        $FunctionalProvider<
          CollectionsRepository,
          CollectionsRepository,
          CollectionsRepository
        >
    with $Provider<CollectionsRepository> {
  CollectionsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'collectionsRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$collectionsRepositoryHash();

  @$internal
  @override
  $ProviderElement<CollectionsRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CollectionsRepository create(Ref ref) {
    return collectionsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CollectionsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CollectionsRepository>(value),
    );
  }
}

String _$collectionsRepositoryHash() =>
    r'4ad8ee22e697d8e57a25f6b0fa6ebf49f6245b39';

@ProviderFor(CollectionsController)
final collectionsControllerProvider = CollectionsControllerProvider._();

final class CollectionsControllerProvider
    extends $NotifierProvider<CollectionsController, List<SavedRequest>> {
  CollectionsControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'collectionsControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$collectionsControllerHash();

  @$internal
  @override
  CollectionsController create() => CollectionsController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<SavedRequest> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<SavedRequest>>(value),
    );
  }
}

String _$collectionsControllerHash() =>
    r'03ab0fa145e356c6771d2706b388ff8c3309e2cc';

abstract class _$CollectionsController extends $Notifier<List<SavedRequest>> {
  List<SavedRequest> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<List<SavedRequest>, List<SavedRequest>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<SavedRequest>, List<SavedRequest>>,
              List<SavedRequest>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

@ProviderFor(collectionFolders)
final collectionFoldersProvider = CollectionFoldersProvider._();

final class CollectionFoldersProvider
    extends $FunctionalProvider<List<String>, List<String>, List<String>>
    with $Provider<List<String>> {
  CollectionFoldersProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'collectionFoldersProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$collectionFoldersHash();

  @$internal
  @override
  $ProviderElement<List<String>> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  List<String> create(Ref ref) {
    return collectionFolders(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<String> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<String>>(value),
    );
  }
}

String _$collectionFoldersHash() => r'6d97be8a88a938bda41e22200680ac5ac04af78d';
