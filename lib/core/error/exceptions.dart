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

/// Exception for sync-related errors
class SyncException implements Exception {
  final String message;

  SyncException(this.message);
}

/// Exception when cached data is stale
class StaleDataException implements Exception {
  final String message;

  StaleDataException(this.message);
}
