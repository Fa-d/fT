import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import '../entities/download_task.dart';
import '../entities/media_item.dart';
import '../repositories/stream_repository.dart';

/// Start download use case
class StartDownload implements UseCase<DownloadTask, StartDownloadParams> {
  final StreamRepository repository;

  StartDownload(this.repository);

  @override
  Future<Either<Failure, DownloadTask>> call(
      StartDownloadParams params) async {
    return repository.startDownload(
      mediaItem: params.mediaItem,
      quality: params.quality,
    );
  }
}

/// Parameters for StartDownload use case
class StartDownloadParams extends Equatable {
  final MediaItem mediaItem;
  final String quality;

  const StartDownloadParams({
    required this.mediaItem,
    required this.quality,
  });

  @override
  List<Object?> get props => [mediaItem, quality];
}
