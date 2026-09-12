import 'package:courier/features/collections/data/datasources/collections_local_data_source.dart';
import 'package:courier/features/collections/data/models/saved_request_hive_model.dart';
import 'package:courier/features/collections/domain/entities/saved_request.dart';
import 'package:courier/features/collections/domain/repositories/collections_repository.dart';

class CollectionsRepositoryImpl implements CollectionsRepository {
  const CollectionsRepositoryImpl(this._dataSource);

  final CollectionsLocalDataSource _dataSource;

  @override
  List<SavedRequest> getAll() => _dataSource.getAll().map((m) => m.toEntity()).toList();

  @override
  Future<void> save(SavedRequest request) => _dataSource.put(SavedRequestHiveModel.fromEntity(request));

  @override
  Future<void> delete(String id) => _dataSource.delete(id);
}
