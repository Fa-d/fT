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
