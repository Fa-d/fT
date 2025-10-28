import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import '../entities/playback_state.dart';
import '../repositories/stream_repository.dart';

/// Save playback state use case
class SavePlaybackState implements UseCase<Unit, SavePlaybackStateParams> {
  final StreamRepository repository;

  SavePlaybackState(this.repository);

  @override
  Future<Either<Failure, Unit>> call(SavePlaybackStateParams params) async {
    // Validate input
    if (params.state.mediaItemId.isEmpty) {
      return const Left(ValidationFailure('Media item ID cannot be empty'));
    }

    if (params.state.position.isNegative) {
      return const Left(ValidationFailure('Position cannot be negative'));
    }

    if (params.state.position > params.state.duration) {
      return const Left(ValidationFailure('Position cannot exceed duration'));
    }

    if (params.state.playbackSpeed < 0 || params.state.playbackSpeed > 2.0) {
      return const Left(ValidationFailure('Playback speed must be between 0 and 2.0'));
    }

    if (params.state.volume < 0 || params.state.volume > 1.0) {
      return const Left(ValidationFailure('Volume must be between 0.0 and 1.0'));
    }

    return repository.savePlaybackState(params.state);
  }
}

/// Parameters for SavePlaybackState use case
class SavePlaybackStateParams extends Equatable {
  final PlaybackState state;

  const SavePlaybackStateParams({required this.state});

  @override
  List<Object?> get props => [state];
}
