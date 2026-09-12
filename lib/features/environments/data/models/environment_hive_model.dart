import 'package:courier/features/environments/domain/entities/environment.dart';
import 'package:courier/shared/data/models/request_hive_models.dart';

class EnvironmentHiveModel {
  const EnvironmentHiveModel({required this.id, required this.name, required this.variables});

  final String id;
  final String name;
  final List<KeyValueHiveModel> variables;

  factory EnvironmentHiveModel.fromEntity(Environment e) => EnvironmentHiveModel(
        id: e.id,
        name: e.name,
        variables: e.variables.map(KeyValueHiveModel.fromEntity).toList(),
      );

  Environment toEntity() =>
      Environment(id: id, name: name, variables: variables.map((v) => v.toEntity()).toList());
}
