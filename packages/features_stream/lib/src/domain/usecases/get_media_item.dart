import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import '../entities/media_item.dart';
import '../repositories/stream_repository.dart';

/// Get media item by ID use case
class GetMediaItem implements UseCase<MediaItem, GetMediaItemParams> {
  final StreamRepository repository;

  GetMediaItem(this.repository);

  @override
  Future<Either<Failure, MediaItem>> call(GetMediaItemParams params) async {
    // Validate input
    if (params.id.isEmpty) {
      return const Left(ValidationFailure('Media item ID cannot be empty'));
    }

    return repository.getMediaItem(params.id);
  }
}

/// Parameters for GetMediaItem use case
class GetMediaItemParams extends Equatable {
  final String id;

  const GetMediaItemParams({required this.id});

  @override
  List<Object?> get props => [id];
}
