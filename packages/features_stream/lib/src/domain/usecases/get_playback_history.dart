import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import '../entities/playback_state.dart';
import '../repositories/stream_repository.dart';

/// Get playback history use case
class GetPlaybackHistory
    implements UseCase<List<PlaybackState>, GetPlaybackHistoryParams> {
  final StreamRepository repository;

  GetPlaybackHistory(this.repository);

  @override
  Future<Either<Failure, List<PlaybackState>>> call(
      GetPlaybackHistoryParams params) async {
    return repository.getPlaybackHistory(limit: params.limit);
  }
}

/// Parameters for GetPlaybackHistory use case
class GetPlaybackHistoryParams extends Equatable {
  final int limit;

  const GetPlaybackHistoryParams({this.limit = 50});

  @override
  List<Object?> get props => [limit];
}
