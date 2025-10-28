import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../domain/entities/media_item.dart';

part 'download_event.freezed.dart';

@freezed
class DownloadEvent with _$DownloadEvent {
  const factory DownloadEvent.loadDownloads() = _LoadDownloads;
  const factory DownloadEvent.startDownload({
    required MediaItem mediaItem,
    required String quality,
  }) = _StartDownload;
  const factory DownloadEvent.pauseDownload(String taskId) = _PauseDownload;
  const factory DownloadEvent.resumeDownload(String taskId) = _ResumeDownload;
  const factory DownloadEvent.cancelDownload(String taskId) = _CancelDownload;
  const factory DownloadEvent.deleteDownload(String taskId) = _DeleteDownload;
}
