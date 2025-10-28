import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';
import '../../../domain/entities/playback_state.dart';
import '../../../domain/usecases/save_playback_state.dart';
import 'player_event.dart';
import 'player_state.dart';

/// Player BLoC
/// Manages video/audio playback state with event sourcing integration
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
    event.when(
      initialize: (mediaItem) => _onInitialize(mediaItem, emit),
      play: () => _onPlay(emit),
      pause: () => _onPause(emit),
      seekTo: (position) => _onSeekTo(position, emit),
      setSpeed: (speed) => _onSetSpeed(speed, emit),
      setQuality: (quality) => _onSetQuality(quality, emit),
      setVolume: (volume) => _onSetVolume(volume, emit),
      toggleMute: () => _onToggleMute(emit),
      updatePosition: (position) => _onUpdatePosition(position, emit),
      updateBuffering: (isBuffering) => _onUpdateBuffering(isBuffering, emit),
      videoCompleted: () => _onVideoCompleted(emit),
      dispose: () => _onDispose(emit),
    );
  }

  Future<void> _onInitialize(
    mediaItem,
    Emitter<PlayerState> emit,
  ) async {
    try {
      emit(PlayerState.loading(mediaItem));

      // Initialize video controller
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

      // Listen to video controller changes
      videoController!.addListener(() => _onVideoControllerUpdate());

      // Start position tracking timer
      _startPositionTimer();
    } catch (e) {
      emit(PlayerState.error(e.toString()));
    }
  }

  void _onVideoControllerUpdate() {
    if (videoController == null) return;

    if (videoController!.value.isBuffering) {
      add(const PlayerEvent.updateBuffering(true));
    } else {
      add(const PlayerEvent.updateBuffering(false));
    }

    if (videoController!.value.position >= videoController!.value.duration &&
        videoController!.value.duration.inMilliseconds > 0) {
      add(const PlayerEvent.videoCompleted());
    }
  }

  void _startPositionTimer() {
    _positionTimer?.cancel();
    _positionTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (videoController != null && videoController!.value.isPlaying) {
        add(PlayerEvent.updatePosition(videoController!.value.position));
      }
    });
  }

  Future<void> _onPlay(Emitter<PlayerState> emit) async {
    if (videoController == null) return;

    await videoController!.play();

    state.maybeWhen(
      ready: (mediaItem, playbackState) {
        emit(PlayerState.playing(
          mediaItem: mediaItem,
          playbackState: playbackState,
        ));
      },
      paused: (mediaItem, playbackState) {
        final updatedState = PlaybackState(
          mediaItemId: playbackState.mediaItemId,
          position: playbackState.position,
          duration: playbackState.duration,
          isPlaying: true,
          isBuffering: false,
          playbackSpeed: playbackState.playbackSpeed,
          currentQuality: playbackState.currentQuality,
          volume: playbackState.volume,
          isMuted: playbackState.isMuted,
          lastUpdated: DateTime.now(),
        );
        emit(PlayerState.playing(
          mediaItem: mediaItem,
          playbackState: updatedState,
        ));
      },
      buffering: (mediaItem, playbackState) {
        emit(PlayerState.playing(
          mediaItem: mediaItem,
          playbackState: playbackState,
        ));
      },
      orElse: () {},
    );
  }

  Future<void> _onPause(Emitter<PlayerState> emit) async {
    if (videoController == null) return;

    await videoController!.pause();

    state.maybeWhen(
      playing: (mediaItem, playbackState) {
        final updatedState = PlaybackState(
          mediaItemId: playbackState.mediaItemId,
          position: videoController!.value.position,
          duration: playbackState.duration,
          isPlaying: false,
          isBuffering: false,
          playbackSpeed: playbackState.playbackSpeed,
          currentQuality: playbackState.currentQuality,
          volume: playbackState.volume,
          isMuted: playbackState.isMuted,
          lastUpdated: DateTime.now(),
        );

        // Save playback state
        _savePlaybackState(updatedState);

        emit(PlayerState.paused(
          mediaItem: mediaItem,
          playbackState: updatedState,
        ));
      },
      orElse: () {},
    );
  }

  Future<void> _onSeekTo(
    Duration position,
    Emitter<PlayerState> emit,
  ) async {
    if (videoController == null) return;

    await videoController!.seekTo(position);

    state.maybeWhen(
      playing: (mediaItem, playbackState) {
        final updatedState = PlaybackState(
          mediaItemId: playbackState.mediaItemId,
          position: position,
          duration: playbackState.duration,
          isPlaying: playbackState.isPlaying,
          isBuffering: false,
          playbackSpeed: playbackState.playbackSpeed,
          currentQuality: playbackState.currentQuality,
          volume: playbackState.volume,
          isMuted: playbackState.isMuted,
          lastUpdated: DateTime.now(),
        );
        emit(PlayerState.playing(
          mediaItem: mediaItem,
          playbackState: updatedState,
        ));
      },
      paused: (mediaItem, playbackState) {
        final updatedState = PlaybackState(
          mediaItemId: playbackState.mediaItemId,
          position: position,
          duration: playbackState.duration,
          isPlaying: false,
          isBuffering: false,
          playbackSpeed: playbackState.playbackSpeed,
          currentQuality: playbackState.currentQuality,
          volume: playbackState.volume,
          isMuted: playbackState.isMuted,
          lastUpdated: DateTime.now(),
        );
        emit(PlayerState.paused(
          mediaItem: mediaItem,
          playbackState: updatedState,
        ));
      },
      orElse: () {},
    );
  }

  Future<void> _onSetSpeed(
    double speed,
    Emitter<PlayerState> emit,
  ) async {
    if (videoController == null) return;

    await videoController!.setPlaybackSpeed(speed);

    state.maybeWhen(
      playing: (mediaItem, playbackState) {
        final updatedState = PlaybackState(
          mediaItemId: playbackState.mediaItemId,
          position: playbackState.position,
          duration: playbackState.duration,
          isPlaying: playbackState.isPlaying,
          isBuffering: false,
          playbackSpeed: speed,
          currentQuality: playbackState.currentQuality,
          volume: playbackState.volume,
          isMuted: playbackState.isMuted,
          lastUpdated: DateTime.now(),
        );
        emit(PlayerState.playing(
          mediaItem: mediaItem,
          playbackState: updatedState,
        ));
      },
      paused: (mediaItem, playbackState) {
        final updatedState = PlaybackState(
          mediaItemId: playbackState.mediaItemId,
          position: playbackState.position,
          duration: playbackState.duration,
          isPlaying: false,
          isBuffering: false,
          playbackSpeed: speed,
          currentQuality: playbackState.currentQuality,
          volume: playbackState.volume,
          isMuted: playbackState.isMuted,
          lastUpdated: DateTime.now(),
        );
        emit(PlayerState.paused(
          mediaItem: mediaItem,
          playbackState: updatedState,
        ));
      },
      orElse: () {},
    );
  }

  Future<void> _onSetQuality(
    String quality,
    Emitter<PlayerState> emit,
  ) async {
    await state.whenOrNull(
      playing: (mediaItem, playbackState) async {
        await _switchQuality(quality, mediaItem, playbackState, emit, wasPlaying: true);
      },
      paused: (mediaItem, playbackState) async {
        await _switchQuality(quality, mediaItem, playbackState, emit, wasPlaying: false);
      },
      ready: (mediaItem, playbackState) async {
        await _switchQuality(quality, mediaItem, playbackState, emit, wasPlaying: false);
      },
    );
  }

  Future<void> _switchQuality(
    String quality,
    dynamic mediaItem,
    PlaybackState playbackState,
    Emitter<PlayerState> emit, {
    required bool wasPlaying,
  }) async {
    // Get the new quality URL
    final newUrl = mediaItem.qualityOptions[quality];
    if (newUrl == null || newUrl.isEmpty) return;

    // Save current state
    final currentPosition = videoController?.value.position ?? Duration.zero;

    // Emit buffering state
    final bufferingState = PlaybackState(
      mediaItemId: playbackState.mediaItemId,
      position: currentPosition,
      duration: playbackState.duration,
      isPlaying: false,
      isBuffering: true,
      playbackSpeed: playbackState.playbackSpeed,
      currentQuality: quality,
      volume: playbackState.volume,
      isMuted: playbackState.isMuted,
      lastUpdated: DateTime.now(),
    );
    emit(PlayerState.buffering(
      mediaItem: mediaItem,
      playbackState: bufferingState,
    ));

    try {
      // Dispose old controller
      await videoController?.pause();
      await videoController?.dispose();

      // Create new controller with new quality
      videoController = VideoPlayerController.networkUrl(Uri.parse(newUrl));
      await videoController!.initialize();

      // Listen to video controller changes
      videoController!.addListener(() => _onVideoControllerUpdate());

      // Restore state
      await videoController!.seekTo(currentPosition);
      await videoController!.setPlaybackSpeed(playbackState.playbackSpeed);
      await videoController!.setVolume(playbackState.isMuted ? 0 : playbackState.volume);

      // Resume playback if it was playing
      if (wasPlaying) {
        await videoController!.play();
      }

      // Emit updated state
      final updatedState = PlaybackState(
        mediaItemId: playbackState.mediaItemId,
        position: currentPosition,
        duration: videoController!.value.duration,
        isPlaying: wasPlaying,
        isBuffering: false,
        playbackSpeed: playbackState.playbackSpeed,
        currentQuality: quality,
        volume: playbackState.volume,
        isMuted: playbackState.isMuted,
        lastUpdated: DateTime.now(),
      );

      if (wasPlaying) {
        emit(PlayerState.playing(
          mediaItem: mediaItem,
          playbackState: updatedState,
        ));
      } else {
        emit(PlayerState.paused(
          mediaItem: mediaItem,
          playbackState: updatedState,
        ));
      }
    } catch (e) {
      emit(PlayerState.error('Failed to switch quality: $e'));
    }
  }

  Future<void> _onSetVolume(
    double volume,
    Emitter<PlayerState> emit,
  ) async {
    if (videoController == null) return;

    await videoController!.setVolume(volume);

    state.maybeWhen(
      playing: (mediaItem, playbackState) {
        final updatedState = PlaybackState(
          mediaItemId: playbackState.mediaItemId,
          position: playbackState.position,
          duration: playbackState.duration,
          isPlaying: playbackState.isPlaying,
          isBuffering: false,
          playbackSpeed: playbackState.playbackSpeed,
          currentQuality: playbackState.currentQuality,
          volume: volume,
          isMuted: playbackState.isMuted,
          lastUpdated: DateTime.now(),
        );
        emit(PlayerState.playing(
          mediaItem: mediaItem,
          playbackState: updatedState,
        ));
      },
      paused: (mediaItem, playbackState) {
        final updatedState = PlaybackState(
          mediaItemId: playbackState.mediaItemId,
          position: playbackState.position,
          duration: playbackState.duration,
          isPlaying: false,
          isBuffering: false,
          playbackSpeed: playbackState.playbackSpeed,
          currentQuality: playbackState.currentQuality,
          volume: volume,
          isMuted: playbackState.isMuted,
          lastUpdated: DateTime.now(),
        );
        emit(PlayerState.paused(
          mediaItem: mediaItem,
          playbackState: updatedState,
        ));
      },
      orElse: () {},
    );
  }

  Future<void> _onToggleMute(Emitter<PlayerState> emit) async {
    if (videoController == null) return;

    state.maybeWhen(
      playing: (mediaItem, playbackState) {
        final newMuteState = !playbackState.isMuted;
        videoController!.setVolume(newMuteState ? 0 : playbackState.volume);

        final updatedState = PlaybackState(
          mediaItemId: playbackState.mediaItemId,
          position: playbackState.position,
          duration: playbackState.duration,
          isPlaying: playbackState.isPlaying,
          isBuffering: false,
          playbackSpeed: playbackState.playbackSpeed,
          currentQuality: playbackState.currentQuality,
          volume: playbackState.volume,
          isMuted: newMuteState,
          lastUpdated: DateTime.now(),
        );
        emit(PlayerState.playing(
          mediaItem: mediaItem,
          playbackState: updatedState,
        ));
      },
      paused: (mediaItem, playbackState) {
        final newMuteState = !playbackState.isMuted;
        videoController!.setVolume(newMuteState ? 0 : playbackState.volume);

        final updatedState = PlaybackState(
          mediaItemId: playbackState.mediaItemId,
          position: playbackState.position,
          duration: playbackState.duration,
          isPlaying: false,
          isBuffering: false,
          playbackSpeed: playbackState.playbackSpeed,
          currentQuality: playbackState.currentQuality,
          volume: playbackState.volume,
          isMuted: newMuteState,
          lastUpdated: DateTime.now(),
        );
        emit(PlayerState.paused(
          mediaItem: mediaItem,
          playbackState: updatedState,
        ));
      },
      orElse: () {},
    );
  }

  void _onUpdatePosition(
    Duration position,
    Emitter<PlayerState> emit,
  ) {
    state.maybeWhen(
      playing: (mediaItem, playbackState) {
        final updatedState = PlaybackState(
          mediaItemId: playbackState.mediaItemId,
          position: position,
          duration: playbackState.duration,
          isPlaying: true,
          isBuffering: false,
          playbackSpeed: playbackState.playbackSpeed,
          currentQuality: playbackState.currentQuality,
          volume: playbackState.volume,
          isMuted: playbackState.isMuted,
          lastUpdated: DateTime.now(),
        );
        emit(PlayerState.playing(
          mediaItem: mediaItem,
          playbackState: updatedState,
        ));

        // Save playback state periodically
        if (position.inSeconds % 10 == 0) {
          _savePlaybackState(updatedState);
        }
      },
      orElse: () {},
    );
  }

  void _onUpdateBuffering(
    bool isBuffering,
    Emitter<PlayerState> emit,
  ) {
    if (isBuffering) {
      state.maybeWhen(
        playing: (mediaItem, playbackState) {
          emit(PlayerState.buffering(
            mediaItem: mediaItem,
            playbackState: playbackState,
          ));
        },
        orElse: () {},
      );
    }
  }

  void _onVideoCompleted(Emitter<PlayerState> emit) {
    state.maybeWhen(
      playing: (mediaItem, playbackState) {
        final updatedState = PlaybackState(
          mediaItemId: playbackState.mediaItemId,
          position: playbackState.duration,
          duration: playbackState.duration,
          isPlaying: false,
          isBuffering: false,
          playbackSpeed: playbackState.playbackSpeed,
          currentQuality: playbackState.currentQuality,
          volume: playbackState.volume,
          isMuted: playbackState.isMuted,
          lastUpdated: DateTime.now(),
        );

        _savePlaybackState(updatedState);

        emit(PlayerState.completed(
          mediaItem: mediaItem,
          playbackState: updatedState,
        ));
      },
      orElse: () {},
    );
  }

  void _onDispose(Emitter<PlayerState> emit) {
    _cleanup();
  }

  void _savePlaybackState(PlaybackState state) {
    savePlaybackStateUseCase(SavePlaybackStateParams(state: state));
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
