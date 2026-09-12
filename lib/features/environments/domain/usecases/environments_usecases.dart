import 'package:courier/features/environments/domain/entities/environment.dart';
import 'package:courier/features/environments/domain/repositories/environments_repository.dart';

class GetEnvironments {
  const GetEnvironments(this._repository);

  final EnvironmentsRepository _repository;

  List<Environment> call() =>
      _repository.getAll()..sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
}

class SaveEnvironment {
  const SaveEnvironment(this._repository);

  final EnvironmentsRepository _repository;

  Future<void> call(Environment environment) => _repository.save(environment);
}

class DeleteEnvironment {
  const DeleteEnvironment(this._repository);

  final EnvironmentsRepository _repository;

  Future<void> call(String id) async {
    if (_repository.getActiveId() == id) await _repository.setActiveId(null);
    await _repository.delete(id);
  }
}

class GetActiveEnvironmentId {
  const GetActiveEnvironmentId(this._repository);

  final EnvironmentsRepository _repository;

  String? call() => _repository.getActiveId();
}

class SetActiveEnvironment {
  const SetActiveEnvironment(this._repository);

  final EnvironmentsRepository _repository;

  Future<void> call(String? id) => _repository.setActiveId(id);
}
