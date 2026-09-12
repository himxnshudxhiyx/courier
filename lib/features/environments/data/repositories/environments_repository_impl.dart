import 'package:courier/features/environments/data/datasources/environments_local_data_source.dart';
import 'package:courier/features/environments/data/models/environment_hive_model.dart';
import 'package:courier/features/environments/domain/entities/environment.dart';
import 'package:courier/features/environments/domain/repositories/environments_repository.dart';

class EnvironmentsRepositoryImpl implements EnvironmentsRepository {
  const EnvironmentsRepositoryImpl(this._dataSource);

  final EnvironmentsLocalDataSource _dataSource;

  @override
  List<Environment> getAll() => _dataSource.getAll().map((m) => m.toEntity()).toList();

  @override
  Future<void> save(Environment environment) => _dataSource.put(EnvironmentHiveModel.fromEntity(environment));

  @override
  Future<void> delete(String id) => _dataSource.delete(id);

  @override
  String? getActiveId() => _dataSource.getActiveId();

  @override
  Future<void> setActiveId(String? id) => _dataSource.setActiveId(id);
}
