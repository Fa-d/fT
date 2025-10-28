import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/download_task.dart';
import 'media_item_model.dart';

part 'download_task_model.freezed.dart';
part 'download_task_model.g.dart';

@freezed
class DownloadTaskModel with _$DownloadTaskModel {
  const DownloadTaskModel._();

  const factory DownloadTaskModel({
    required String id,
    required MediaItemModel mediaItem,
    required String status,
    @Default(0.0) double progress,
    String? localPath,
    int? totalBytes,
    int? downloadedBytes,
    required String createdAt,
    String? completedAt,
    String? errorMessage,
    required String quality,
  }) = _DownloadTaskModel;

  factory DownloadTaskModel.fromJson(Map<String, dynamic> json) =>
      _$DownloadTaskModelFromJson(json);

  /// Convert to domain entity
  DownloadTask toEntity() {
    return DownloadTask(
      id: id,
      mediaItem: mediaItem.toEntity(),
      status: _parseStatus(status),
      progress: progress,
      localPath: localPath,
      totalBytes: totalBytes,
      downloadedBytes: downloadedBytes,
      createdAt: DateTime.parse(createdAt),
      completedAt: completedAt != null ? DateTime.parse(completedAt!) : null,
      errorMessage: errorMessage,
      quality: quality,
    );
  }

  /// Create from domain entity
  factory DownloadTaskModel.fromEntity(DownloadTask entity) {
    return DownloadTaskModel(
      id: entity.id,
      mediaItem: MediaItemModel.fromEntity(entity.mediaItem),
      status: _statusToString(entity.status),
      progress: entity.progress,
      localPath: entity.localPath,
      totalBytes: entity.totalBytes,
      downloadedBytes: entity.downloadedBytes,
      createdAt: entity.createdAt.toIso8601String(),
      completedAt: entity.completedAt?.toIso8601String(),
      errorMessage: entity.errorMessage,
      quality: entity.quality,
    );
  }

  static DownloadStatus _parseStatus(String status) {
    switch (status) {
      case 'pending':
        return DownloadStatus.pending;
      case 'downloading':
        return DownloadStatus.downloading;
      case 'paused':
        return DownloadStatus.paused;
      case 'completed':
        return DownloadStatus.completed;
      case 'failed':
        return DownloadStatus.failed;
      case 'cancelled':
        return DownloadStatus.cancelled;
      default:
        return DownloadStatus.pending;
    }
  }

  static String _statusToString(DownloadStatus status) {
    switch (status) {
      case DownloadStatus.pending:
        return 'pending';
      case DownloadStatus.downloading:
        return 'downloading';
      case DownloadStatus.paused:
        return 'paused';
      case DownloadStatus.completed:
        return 'completed';
      case DownloadStatus.failed:
        return 'failed';
      case DownloadStatus.cancelled:
        return 'cancelled';
    }
  }
}
