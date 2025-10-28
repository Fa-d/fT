import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../domain/entities/download_task.dart';

part 'download_state.freezed.dart';

@freezed
class DownloadState with _$DownloadState {
  const factory DownloadState.initial() = _Initial;
  const factory DownloadState.loading() = _Loading;
  const factory DownloadState.loaded(List<DownloadTask> downloads) = _Loaded;
  const factory DownloadState.downloading({
    required List<DownloadTask> downloads,
    required String activeTaskId,
  }) = _Downloading;
  const factory DownloadState.error(String message) = _Error;
}
