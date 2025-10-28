import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import '../entities/media_item.dart';
import '../repositories/stream_repository.dart';

/// Get media items with pagination use case
class GetMediaItems implements UseCase<List<MediaItem>, GetMediaItemsParams> {
  final StreamRepository repository;

  GetMediaItems(this.repository);

  @override
  Future<Either<Failure, List<MediaItem>>> call(
      GetMediaItemsParams params) async {
    return repository.getMediaItems(
      page: params.page,
      limit: params.limit,
      type: params.type,
    );
  }
}

/// Parameters for GetMediaItems use case
class GetMediaItemsParams extends Equatable {
  final int page;
  final int limit;
  final MediaType? type;

  const GetMediaItemsParams({
    this.page = 1,
    this.limit = 20,
    this.type,
  });

  @override
  List<Object?> get props => [page, limit, type];
}
