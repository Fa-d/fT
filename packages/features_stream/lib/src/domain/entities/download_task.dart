import 'package:equatable/equatable.dart';
import 'media_item.dart';

/// Download task entity
/// Represents an offline download task for a media item
class DownloadTask extends Equatable {
  final String id;
  final MediaItem mediaItem;
  final DownloadStatus status;
  final double progress; // 0.0 to 1.0
  final String? localPath;
  final int? totalBytes;
  final int? downloadedBytes;
  final DateTime createdAt;
  final DateTime? completedAt;
  final String? errorMessage;
  final String quality; // Selected quality for download

  const DownloadTask({
    required this.id,
    required this.mediaItem,
    required this.status,
    this.progress = 0.0,
    this.localPath,
    this.totalBytes,
    this.downloadedBytes,
    required this.createdAt,
    this.completedAt,
    this.errorMessage,
    required this.quality,
  });

  /// Create a new download task
  factory DownloadTask.create({
    required String id,
    required MediaItem mediaItem,
    required String quality,
  }) {
    return DownloadTask(
      id: id,
      mediaItem: mediaItem,
      status: DownloadStatus.pending,
      progress: 0.0,
      createdAt: DateTime.now(),
      quality: quality,
    );
  }

  /// Check if download is complete
  bool get isComplete => status == DownloadStatus.completed;

  /// Check if download is in progress
  bool get isInProgress => status == DownloadStatus.downloading;

  /// Check if download has failed
  bool get hasFailed => status == DownloadStatus.failed;

  /// Check if download is paused
  bool get isPaused => status == DownloadStatus.paused;

  @override
  List<Object?> get props => [
        id,
        mediaItem,
        status,
        progress,
        localPath,
        totalBytes,
        downloadedBytes,
        createdAt,
        completedAt,
        errorMessage,
        quality,
      ];
}

/// Download status enumeration
enum DownloadStatus {
  pending,
  downloading,
  paused,
  completed,
  failed,
  cancelled,
}
