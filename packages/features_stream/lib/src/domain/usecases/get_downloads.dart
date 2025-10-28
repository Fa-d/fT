import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import '../entities/download_task.dart';
import '../repositories/stream_repository.dart';

/// Get all downloads use case
class GetDownloads implements UseCase<List<DownloadTask>, NoParams> {
  final StreamRepository repository;

  GetDownloads(this.repository);

  @override
  Future<Either<Failure, List<DownloadTask>>> call(NoParams params) async {
    return repository.getDownloads();
  }
}
