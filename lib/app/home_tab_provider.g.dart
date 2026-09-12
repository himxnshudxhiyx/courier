// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_tab_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SelectedHomeTab)
final selectedHomeTabProvider = SelectedHomeTabProvider._();

final class SelectedHomeTabProvider
    extends $NotifierProvider<SelectedHomeTab, HomeTab> {
  SelectedHomeTabProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'selectedHomeTabProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$selectedHomeTabHash();

  @$internal
  @override
  SelectedHomeTab create() => SelectedHomeTab();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(HomeTab value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<HomeTab>(value),
    );
  }
}

String _$selectedHomeTabHash() => r'4353c614c292dcf544c92077c71996a04fcb7dc8';

abstract class _$SelectedHomeTab extends $Notifier<HomeTab> {
  HomeTab build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<HomeTab, HomeTab>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<HomeTab, HomeTab>,
              HomeTab,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
