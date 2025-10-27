/// Base class for all exceptions in the application
class AppException implements Exception {
  final String message;
  final dynamic cause;

  const AppException(this.message, [this.cause]);

  @override
  String toString() => 'AppException: $message${cause != null ? ' (Caused by: $cause)' : ''}';
}

/// Exception thrown when a server request fails
class ServerException extends AppException {
  final int? statusCode;

  const ServerException(super.message, [this.statusCode, super.cause]);

  @override
  String toString() => 'ServerException: $message${statusCode != null ? ' (Status: $statusCode)' : ''}';
}

/// Exception thrown when a cache operation fails
class CacheException extends AppException {
  const CacheException(super.message, [super.cause]);

  @override
  String toString() => 'CacheException: $message';
}

/// Exception thrown when network is unavailable
class NetworkException extends AppException {
  const NetworkException(super.message, [super.cause]);

  @override
  String toString() => 'NetworkException: $message';
}

/// Exception thrown when authentication fails
class AuthenticationException extends AppException {
  const AuthenticationException(super.message, [super.cause]);

  @override
  String toString() => 'AuthenticationException: $message';
}

/// Exception thrown when authorization fails
class AuthorizationException extends AppException {
  const AuthorizationException(super.message, [super.cause]);

  @override
  String toString() => 'AuthorizationException: $message';
}

/// Exception thrown when validation fails
class ValidationException extends AppException {
  final Map<String, List<String>>? errors;

  const ValidationException(super.message, [this.errors, super.cause]);

  @override
  String toString() => 'ValidationException: $message';
}

/// Exception thrown when a resource is not found
class NotFoundException extends AppException {
  const NotFoundException(super.message, [super.cause]);

  @override
  String toString() => 'NotFoundException: $message';
}

/// Exception thrown when an operation times out
class TimeoutException extends AppException {
  const TimeoutException(super.message, [super.cause]);

  @override
  String toString() => 'TimeoutException: $message';
}

/// Exception thrown when version conflict occurs in event sourcing
class VersionConflictException extends AppException {
  final int expectedVersion;
  final int actualVersion;

  const VersionConflictException(
    String message,
    this.expectedVersion,
    this.actualVersion, [
    dynamic cause,
  ]) : super(message, cause);

  @override
  String toString() =>
      'VersionConflictException: $message (Expected: $expectedVersion, Actual: $actualVersion)';
}
