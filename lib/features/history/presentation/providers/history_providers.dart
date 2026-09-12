import 'package:courier/core/storage/storage_providers.dart';
import 'package:courier/features/history/data/datasources/history_local_data_source.dart';
import 'package:courier/features/history/data/repositories/history_repository_impl.dart';
import 'package:courier/features/history/domain/entities/history_entry.dart';
import 'package:courier/features/history/domain/repositories/history_repository.dart';
import 'package:courier/features/history/domain/usecases/history_usecases.dart';
import 'package:courier/features/settings/presentation/providers/settings_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'history_providers.g.dart';

@Riverpod(keepAlive: true)
HistoryRepository historyRepository(Ref ref) =>
    HistoryRepositoryImpl(HistoryLocalDataSource(ref.watch(historyBoxProvider)));

@Riverpod(keepAlive: true)
class HistoryController extends _$HistoryController {
  @override
  List<HistoryEntry> build() => GetHistory(ref.watch(historyRepositoryProvider))();

  HistoryRepository get _repository => ref.read(historyRepositoryProvider);

  Future<void> add(HistoryEntry entry) async {
    final settings = ref.read(settingsControllerProvider);
    await AddHistoryEntry(_repository)(
      entry,
      limit: settings.historyLimit,
      keepResponseBody: settings.saveResponseBodies,
    );
    state = GetHistory(_repository)();
  }

  /// Re-inserts an entry removed by mistake (undo).
  Future<void> restore(HistoryEntry entry) async {
    await AddHistoryEntry(_repository)(
      entry,
      limit: ref.read(settingsControllerProvider).historyLimit,
      keepResponseBody: true,
    );
    state = GetHistory(_repository)();
  }

  Future<void> delete(String id) async {
    // Update synchronously so a dismissed list row leaves the tree right away.
    state = state.where((e) => e.id != id).toList();
    await DeleteHistoryEntry(_repository)(id);
  }

  Future<void> clear() async {
    state = const [];
    await ClearHistory(_repository)();
  }
}
