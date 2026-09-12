import 'package:courier/shared/domain/entities/api_request.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'environment.freezed.dart';

@freezed
abstract class Environment with _$Environment {
  const factory Environment({
    required String id,
    required String name,
    @Default([]) List<KeyValuePair> variables,
  }) = _Environment;
}
