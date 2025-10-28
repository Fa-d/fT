import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';
import '../../../domain/entities/playback_state.dart';
import '../../../domain/usecases/save_playback_state.dart';
import 'player_event.dart';
import 'player_state.dart';

/// Simplified Player BLoC
/// Demonstrates video playback state management
class PlayerBloc extends Bloc<PlayerEvent, PlayerState> {
  final SavePlaybackState savePlaybackStateUseCase;
  VideoPlayerController? videoController;
  Timer? _positionTimer;

  PlayerBloc({
    required this.savePlaybackStateUseCase,
  }) : super(const PlayerState.initial()) {
    on<PlayerEvent>(_onEvent);
  }

  Future<void> _onEvent(
    PlayerEvent event,
    Emitter<PlayerState> emit,
  ) async {
    await event.when(
      initialize: (mediaItem) async {
        try {
          emit(PlayerState.loading(mediaItem));

          videoController = VideoPlayerController.networkUrl(
            Uri.parse(mediaItem.streamUrl),
          );

          await videoController!.initialize();

          final playbackState = PlaybackState(
            mediaItemId: mediaItem.id,
            position: Duration.zero,
            duration: videoController!.value.duration,
            isPlaying: false,
            isBuffering: false,
            lastUpdated: DateTime.now(),
          );

          emit(PlayerState.ready(
            mediaItem: mediaItem,
            playbackState: playbackState,
          ));

          _startPositionTimer();
        } catch (e) {
          emit(PlayerState.error(e.toString()));
        }
      },
      play: () async {
        if (videoController == null) return;
        await videoController!.play();
        // State will be updated by position timer
      },
      pause: () async {
        if (videoController == null) return;
        await videoController!.pause();
        // State will be updated by position timer
      },
      seekTo: (position) async {
        if (videoController == null) return;
        await videoController!.seekTo(position);
      },
      setSpeed: (speed) async {
        if (videoController == null) return;
        await videoController!.setPlaybackSpeed(speed);
      },
      setQuality: (quality) async {
        // TODO: Implement quality switching
      },
      setVolume: (volume) async {
        if (videoController == null) return;
        await videoController!.setVolume(volume);
      },
      toggleMute: () async {
        if (videoController == null) return;
        final currentVolume = videoController!.value.volume;
        await videoController!.setVolume(currentVolume > 0 ? 0 : 1.0);
      },
      updatePosition: (position) {
        // Called by timer to update position
      },
      updateBuffering: (isBuffering) {
        // Called when buffering state changes
      },
      videoCompleted: () {
        // Called when video completes
      },
      dispose: () {
        _cleanup();
      },
    );
  }

  void _startPositionTimer() {
    _positionTimer?.cancel();
    _positionTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (videoController != null && videoController!.value.isPlaying) {
        // Update position in state
      }
    });
  }

  void _cleanup() {
    _positionTimer?.cancel();
    videoController?.dispose();
    videoController = null;
  }

  @override
  Future<void> close() {
    _cleanup();
    return super.close();
  }
}
