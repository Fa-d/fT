/// Base exception for server-related errors
class ServerException implements Exception {
  final String message;

  ServerException(this.message);
}

/// Exception for cache-related errors
class CacheException implements Exception {
  final String message;

  CacheException(this.message);
}

/// Exception for network-related errors
class NetworkException implements Exception {
  final String message;

  NetworkException(this.message);
}
