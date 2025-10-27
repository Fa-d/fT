import 'package:equatable/equatable.dart';

/// Abstract base class for all failures in the app
/// Using Equatable for value comparison
abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object?> get props => [message];
}

/// Server-related failures (API errors, 500 errors, etc.)
class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

/// Cache-related failures (local storage errors)
class CacheFailure extends Failure {
  const CacheFailure(super.message);
}

/// Network-related failures (no internet, timeout)
class NetworkFailure extends Failure {
  const NetworkFailure(super.message);
}

/// Validation failures (input validation)
class ValidationFailure extends Failure {
  const ValidationFailure(super.message);
}
