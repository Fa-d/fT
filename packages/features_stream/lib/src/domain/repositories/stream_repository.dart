import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import '../entities/media_item.dart';
import '../entities/playlist.dart';
import '../entities/download_task.dart';
import '../entities/playback_state.dart';

/// Stream repository interface
/// Defines contracts for media streaming and download operations
abstract class StreamRepository {
  /// Get a single media item by ID
  Future<Either<Failure, MediaItem>> getMediaItem(String id);

  /// Get a list of media items with pagination
  Future<Either<Failure, List<MediaItem>>> getMediaItems({
    int page = 1,
    int limit = 20,
    MediaType? type,
  });

  /// Search for media items
  Future<Either<Failure, List<MediaItem>>> searchMediaItems(String query);

  /// Get a playlist by ID
  Future<Either<Failure, Playlist>> getPlaylist(String id);

  /// Get user playlists
  Future<Either<Failure, List<Playlist>>> getUserPlaylists();

  /// Create a new playlist
  Future<Either<Failure, Playlist>> createPlaylist({
    required String name,
    required String description,
  });

  /// Add media item to playlist
  Future<Either<Failure, Unit>> addToPlaylist({
    required String playlistId,
    required String mediaItemId,
  });

  /// Start a download task
  Future<Either<Failure, DownloadTask>> startDownload({
    required MediaItem mediaItem,
    required String quality,
  });

  /// Pause a download task
  Future<Either<Failure, Unit>> pauseDownload(String taskId);

  /// Resume a download task
  Future<Either<Failure, Unit>> resumeDownload(String taskId);

  /// Cancel a download task
  Future<Either<Failure, Unit>> cancelDownload(String taskId);

  /// Delete a downloaded file
  Future<Either<Failure, Unit>> deleteDownload(String taskId);

  /// Get all download tasks
  Future<Either<Failure, List<DownloadTask>>> getDownloads();

  /// Get download task by ID
  Future<Either<Failure, DownloadTask>> getDownloadTask(String taskId);

  /// Stream download progress
  Stream<DownloadTask> watchDownloadProgress(String taskId);

  /// Save playback state
  Future<Either<Failure, Unit>> savePlaybackState(PlaybackState state);

  /// Get playback state for a media item
  Future<Either<Failure, PlaybackState?>> getPlaybackState(String mediaItemId);

  /// Get playback history
  Future<Either<Failure, List<PlaybackState>>> getPlaybackHistory({
    int limit = 50,
  });
}
