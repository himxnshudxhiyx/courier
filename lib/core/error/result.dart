import 'package:courier/core/error/failure.dart';

sealed class Result<T> {
  const Result();

  R fold<R>(R Function(Failure failure) onErr, R Function(T value) onOk) => switch (this) {
        Ok(:final value) => onOk(value),
        Err(:final failure) => onErr(failure),
      };
}

final class Ok<T> extends Result<T> {
  const Ok(this.value);

  final T value;
}

final class Err<T> extends Result<T> {
  const Err(this.failure);

  final Failure failure;
}
