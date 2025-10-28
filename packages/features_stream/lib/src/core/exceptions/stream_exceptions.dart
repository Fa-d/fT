library;

/// Custom exceptions for the stream feature
/// Provides better error handling and debugging

/// Base exception for stream feature
abstract class StreamException implements Exception {
  final String message;
  final dynamic cause;

  const StreamException(this.message, [this.cause]);

  @override
  String toString() => 'StreamException: $message${cause != null ? ' (Cause: $cause)' : ''}';
}

/// Exception thrown when player initialization fails
class PlayerInitializationException extends StreamException {
  const PlayerInitializationException(super.message, [super.cause]);

  @override
  String toString() => 'PlayerInitializationException: $message${cause != null ? ' (Cause: $cause)' : ''}';
}

/// Exception thrown when quality switching fails
class QualitySwitchException extends StreamException {
  final String requestedQuality;

  const QualitySwitchException(this.requestedQuality, String message, [dynamic cause])
      : super(message, cause);

  @override
  String toString() => 'QualitySwitchException: Failed to switch to $requestedQuality - $message${cause != null ? ' (Cause: $cause)' : ''}';
}

/// Exception thrown when seeking fails
class SeekException extends StreamException {
  final Duration requestedPosition;

  const SeekException(this.requestedPosition, super.message, [super.cause]);

  @override
  String toString() => 'SeekException: Failed to seek to $requestedPosition - $message${cause != null ? ' (Cause: $cause)' : ''}';
}

/// Exception thrown when download operations fail
class DownloadException extends StreamException {
  final String? downloadId;

  const DownloadException(super.message, [this.downloadId, super.cause]);

  @override
  String toString() => 'DownloadException${downloadId != null ? ' (ID: $downloadId)' : ''}: $message${cause != null ? ' (Cause: $cause)' : ''}';
}

/// Exception thrown when URL validation fails
class InvalidUrlException extends StreamException {
  final String url;

  const InvalidUrlException(this.url, [String? message])
      : super(message ?? 'Invalid URL format');

  @override
  String toString() => 'InvalidUrlException: $url - $message';
}

/// Exception thrown when media item validation fails
class InvalidMediaItemException extends StreamException {
  final String field;

  const InvalidMediaItemException(this.field, String message)
      : super(message);

  @override
  String toString() => 'InvalidMediaItemException: $field - $message';
}

/// Exception thrown when playback state operations fail
class PlaybackStateException extends StreamException {
  const PlaybackStateException(super.message, [super.cause]);

  @override
  String toString() => 'PlaybackStateException: $message${cause != null ? ' (Cause: $cause)' : ''}';
}

/// Exception thrown when storage operations fail
class StorageException extends StreamException {
  final String operation;

  const StorageException(this.operation, String message, [dynamic cause])
      : super(message, cause);

  @override
  String toString() => 'StorageException ($operation): $message${cause != null ? ' (Cause: $cause)' : ''}';
}
