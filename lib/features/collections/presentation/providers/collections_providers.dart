import 'package:courier/core/storage/storage_providers.dart';
import 'package:courier/core/utils/id_generator.dart';
import 'package:courier/features/collections/data/datasources/collections_local_data_source.dart';
import 'package:courier/features/collections/data/repositories/collections_repository_impl.dart';
import 'package:courier/features/collections/domain/entities/saved_request.dart';
import 'package:courier/features/collections/domain/repositories/collections_repository.dart';
import 'package:courier/features/collections/domain/usecases/collections_usecases.dart';
import 'package:courier/shared/domain/entities/api_request.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'collections_providers.g.dart';

@Riverpod(keepAlive: true)
CollectionsRepository collectionsRepository(Ref ref) =>
    CollectionsRepositoryImpl(CollectionsLocalDataSource(ref.watch(collectionsBoxProvider)));

@Riverpod(keepAlive: true)
class CollectionsController extends _$CollectionsController {
  @override
  List<SavedRequest> build() => GetSavedRequests(ref.watch(collectionsRepositoryProvider))();

  CollectionsRepository get _repository => ref.read(collectionsRepositoryProvider);

  Future<SavedRequest> save({
    String? id,
    required String name,
    required String folder,
    required ApiRequest request,
  }) async {
    final saved = SavedRequest(
      id: id ?? generateId(),
      name: name.trim(),
      folder: folder.trim(),
      request: request,
      updatedAt: DateTime.now(),
    );
    await SaveRequest(_repository)(saved);
    state = GetSavedRequests(_repository)();
    return saved;
  }

  Future<void> duplicate(SavedRequest source) =>
      save(name: '${source.name} copy', folder: source.folder, request: source.request);

  Future<void> delete(String id) async {
    state = state.where((e) => e.id != id).toList();
    await DeleteSavedRequest(_repository)(id);
  }
}

@riverpod
List<String> collectionFolders(Ref ref) {
  final folders = ref.watch(collectionsControllerProvider).map((s) => s.folder).where((f) => f.isNotEmpty).toSet();
  return folders.toList()..sort((a, b) => a.toLowerCase().compareTo(b.toLowerCase()));
}
