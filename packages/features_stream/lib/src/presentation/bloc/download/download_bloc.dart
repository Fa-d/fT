import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:core/core.dart';
import '../../../domain/usecases/get_downloads.dart';
import '../../../domain/usecases/start_download.dart';
import '../../../data/services/download_manager.dart';
import 'download_event.dart';
import 'download_state.dart';

/// Download BLoC
/// Manages offline download state
class DownloadBloc extends Bloc<DownloadEvent, DownloadState> {
  final GetDownloads getDownloadsUseCase;
  final StartDownload startDownloadUseCase;
  final DownloadManager downloadManager;

  DownloadBloc({
    required this.getDownloadsUseCase,
    required this.startDownloadUseCase,
    required this.downloadManager,
  }) : super(const DownloadState.initial()) {
    on<DownloadEvent>(_onEvent);
  }

  Future<void> _onEvent(
    DownloadEvent event,
    Emitter<DownloadState> emit,
  ) async {
    await event.when(
      loadDownloads: () => _onLoadDownloads(emit),
      startDownload: (mediaItem, quality) =>
          _onStartDownload(mediaItem, quality, emit),
      pauseDownload: (taskId) => _onPauseDownload(taskId, emit),
      resumeDownload: (taskId) => _onResumeDownload(taskId, emit),
      cancelDownload: (taskId) => _onCancelDownload(taskId, emit),
      deleteDownload: (taskId) => _onDeleteDownload(taskId, emit),
    );
  }

  Future<void> _onLoadDownloads(Emitter<DownloadState> emit) async {
    emit(const DownloadState.loading());

    final result = await getDownloadsUseCase(NoParams());

    result.fold(
      (failure) => emit(DownloadState.error(failure.message)),
      (downloads) => emit(DownloadState.loaded(downloads)),
    );
  }

  Future<void> _onStartDownload(
    mediaItem,
    String quality,
    Emitter<DownloadState> emit,
  ) async {
    final result = await startDownloadUseCase(
      StartDownloadParams(
        mediaItem: mediaItem,
        quality: quality,
      ),
    );

    result.fold(
      (failure) => emit(DownloadState.error(failure.message)),
      (task) {
        // Reload downloads to show the new task
        add(const DownloadEvent.loadDownloads());
      },
    );
  }

  Future<void> _onPauseDownload(
    String taskId,
    Emitter<DownloadState> emit,
  ) async {
    await downloadManager.pauseDownload(taskId);
    add(const DownloadEvent.loadDownloads());
  }

  Future<void> _onResumeDownload(
    String taskId,
    Emitter<DownloadState> emit,
  ) async {
    await downloadManager.resumeDownload(taskId);
    add(const DownloadEvent.loadDownloads());
  }

  Future<void> _onCancelDownload(
    String taskId,
    Emitter<DownloadState> emit,
  ) async {
    await downloadManager.cancelDownload(taskId);
    add(const DownloadEvent.loadDownloads());
  }

  Future<void> _onDeleteDownload(
    String taskId,
    Emitter<DownloadState> emit,
  ) async {
    await downloadManager.removeDownload(taskId);
    add(const DownloadEvent.loadDownloads());
  }
}
