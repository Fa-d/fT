import 'package:equatable/equatable.dart';

/// Base class for all failures in the application
/// Used with Either<Failure, Success> pattern
abstract class Failure extends Equatable {
  final String message;
  final dynamic cause;

  const Failure(this.message, [this.cause]);

  @override
  List<Object?> get props => [message, cause];

  @override
  String toString() => '$runtimeType: $message';
}

/// Failure when a server request fails
class ServerFailure extends Failure {
  final int? statusCode;

  const ServerFailure(super.message, [this.statusCode, super.cause]);

  @override
  List<Object?> get props => [message, statusCode, cause];

  @override
  String toString() => 'ServerFailure: $message${statusCode != null ? ' (Status: $statusCode)' : ''}';
}

/// Failure when a cache operation fails
class CacheFailure extends Failure {
  const CacheFailure(super.message, [super.cause]);
}

/// Failure when network is unavailable
class NetworkFailure extends Failure {
  const NetworkFailure(super.message, [super.cause]);
}

/// Failure when authentication fails
class AuthenticationFailure extends Failure {
  const AuthenticationFailure(super.message, [super.cause]);
}

/// Failure when authorization fails
class AuthorizationFailure extends Failure {
  const AuthorizationFailure(super.message, [super.cause]);
}

/// Failure when validation fails
class ValidationFailure extends Failure {
  final Map<String, List<String>>? errors;

  const ValidationFailure(super.message, [this.errors, super.cause]);

  @override
  List<Object?> get props => [message, errors, cause];
}

/// Failure when a resource is not found
class NotFoundFailure extends Failure {
  const NotFoundFailure(super.message, [super.cause]);
}

/// Failure when an operation times out
class TimeoutFailure extends Failure {
  const TimeoutFailure(super.message, [super.cause]);
}

/// Failure when an unexpected error occurs
class UnexpectedFailure extends Failure {
  const UnexpectedFailure(super.message, [super.cause]);
}

/// Failure when sync operation fails
class SyncFailure extends Failure {
  const SyncFailure(super.message, [super.cause]);
}

/// Failure when conflict occurs
class ConflictFailure extends Failure {
  const ConflictFailure(super.message, [super.cause]);
}
