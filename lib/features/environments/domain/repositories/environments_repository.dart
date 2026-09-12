import 'package:courier/features/environments/domain/entities/environment.dart';

abstract interface class EnvironmentsRepository {
  List<Environment> getAll();

  /// Inserts or replaces by id.
  Future<void> save(Environment environment);

  Future<void> delete(String id);

  String? getActiveId();

  Future<void> setActiveId(String? id);
}
