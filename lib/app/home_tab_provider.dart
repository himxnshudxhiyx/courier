import 'package:courier/features/collections/domain/entities/saved_request.dart';
import 'package:courier/features/request/presentation/providers/request_providers.dart';
import 'package:courier/shared/domain/entities/api_request.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_tab_provider.g.dart';

enum HomeTab { request, history, collections, environments }

@Riverpod(keepAlive: true)
class SelectedHomeTab extends _$SelectedHomeTab {
  @override
  HomeTab build() => HomeTab.request;

  void select(HomeTab tab) => state = tab;
}

extension EditorNavigation on WidgetRef {
  /// Loads [request] into the editor and switches to the Request tab.
  void openInEditor(ApiRequest request, {SavedRequest? saved}) {
    read(requestEditorProvider.notifier).load(request, saved: saved);
    read(sendControllerProvider.notifier).clear();
    read(selectedHomeTabProvider.notifier).select(HomeTab.request);
  }
}
