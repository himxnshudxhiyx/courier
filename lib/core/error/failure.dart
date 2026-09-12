sealed class Failure implements Exception {
  const Failure(this.message);

  final String message;

  @override
  String toString() => message;
}

final class NetworkFailure extends Failure {
  const NetworkFailure(super.message);
}

final class TimeoutFailure extends Failure {
  const TimeoutFailure(super.message);
}

final class CancelledFailure extends Failure {
  const CancelledFailure() : super('Request cancelled');
}

final class InvalidRequestFailure extends Failure {
  const InvalidRequestFailure(super.message);
}

final class UnexpectedFailure extends Failure {
  const UnexpectedFailure(super.message);
}
