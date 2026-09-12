import 'package:courier/core/storage/storage_providers.dart';
import 'package:courier/core/utils/id_generator.dart';
import 'package:courier/features/environments/data/datasources/environments_local_data_source.dart';
import 'package:courier/features/environments/data/repositories/environments_repository_impl.dart';
import 'package:courier/features/environments/domain/entities/environment.dart';
import 'package:courier/features/environments/domain/repositories/environments_repository.dart';
import 'package:courier/features/environments/domain/usecases/environments_usecases.dart';
import 'package:courier/shared/domain/entities/api_request.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'environments_providers.g.dart';

@Riverpod(keepAlive: true)
EnvironmentsRepository environmentsRepository(Ref ref) => EnvironmentsRepositoryImpl(
      EnvironmentsLocalDataSource(ref.watch(environmentsBoxProvider), ref.watch(preferencesBoxProvider)),
    );

@Riverpod(keepAlive: true)
class EnvironmentsController extends _$EnvironmentsController {
  @override
  List<Environment> build() => GetEnvironments(ref.watch(environmentsRepositoryProvider))();

  EnvironmentsRepository get _repository => ref.read(environmentsRepositoryProvider);

  Future<Environment> create(String name, {List<KeyValuePair> variables = const []}) async {
    final environment = Environment(id: generateId(), name: name, variables: variables);
    await save(environment);
    state = GetEnvironments(_repository)();
    return environment;
  }

  /// Updates state synchronously: variable fields are bound to this state
  /// while the user types.
  Future<void> save(Environment environment) async {
    final exists = state.any((e) => e.id == environment.id);
    state = exists
        ? [for (final e in state) e.id == environment.id ? environment : e]
        : [...state, environment];
    await SaveEnvironment(_repository)(environment);
  }

  Future<void> duplicate(Environment source) => create(
        '${source.name} copy',
        variables: [for (final v in source.variables) KeyValuePair.create(key: v.key, value: v.value, enabled: v.enabled)],
      );

  Future<void> delete(String id) async {
    state = state.where((e) => e.id != id).toList();
    await DeleteEnvironment(_repository)(id);
    ref.invalidate(activeEnvironmentIdProvider);
  }
}

@Riverpod(keepAlive: true)
class ActiveEnvironmentId extends _$ActiveEnvironmentId {
  @override
  String? build() => GetActiveEnvironmentId(ref.watch(environmentsRepositoryProvider))();

  Future<void> select(String? id) async {
    state = id;
    await SetActiveEnvironment(ref.read(environmentsRepositoryProvider))(id);
  }
}

@riverpod
Environment? activeEnvironment(Ref ref) {
  final id = ref.watch(activeEnvironmentIdProvider);
  if (id == null) return null;
  return ref.watch(environmentsControllerProvider).where((e) => e.id == id).firstOrNull;
}

@riverpod
List<KeyValuePair> activeVariables(Ref ref) => ref.watch(activeEnvironmentProvider)?.variables ?? const [];
