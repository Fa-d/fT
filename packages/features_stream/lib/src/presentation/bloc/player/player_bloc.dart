import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/playback_state.dart';
import '../../../domain/usecases/save_playback_state.dart';
import '../../../domain/services/video_player_service.dart';
import '../../../core/constants/stream_constants.dart';
import '../../../core/utils/logger.dart';
import '../../../core/exceptions/stream_exceptions.dart';
import 'player_event.dart';
import 'player_state.dart';

/// Player BLoC
/// Manages video/audio playback state with clean architecture
/// Uses VideoPlayerService abstraction instead of direct VideoPlayerController
class PlayerBloc extends Bloc<PlayerEvent, PlayerState> {
  final SavePlaybackState savePlaybackStateUseCase;
  final VideoPlayerService videoPlayerService;

  Timer? _positionTimer;
  Timer? _autoSaveTimer;
  bool _isSeeking = false;
  StreamSubscription<void>? _playerStateSubscription;

  PlayerBloc({
    required this.savePlaybackStateUseCase,
    required this.videoPlayerService,
  }) : super(const PlayerState.initial()) {
    on<PlayerEvent>(_onEvent);
  }

  Future<void> _onEvent(
    PlayerEvent event,
    Emitter<PlayerState> emit,
  ) async {
    await event.map(
      initialize: (e) async => await _onInitialize(e.mediaItem, emit),
      play: (_) async => await _onPlay(emit),
      pause: (_) async => await _onPause(emit),
      seekTo: (e) async => await _onSeekTo(e.position, emit),
      setSpeed: (e) async => await _onSetSpeed(e.speed, emit),
      setQuality: (e) async => await _onSetQuality(e.quality, emit),
      setVolume: (e) async => await _onSetVolume(e.volume, emit),
      toggleMute: (_) async => await _onToggleMute(emit),
      updatePosition: (e) async => _onUpdatePosition(e.position, emit),
      updateBuffering: (e) async => _onUpdateBuffering(e.isBuffering, emit),
      videoCompleted: (_) async => _onVideoCompleted(emit),
      dispose: (_) async => _onDispose(emit),
    );
  }

  Future<void> _onInitialize(
    mediaItem,
    Emitter<PlayerState> emit,
  ) async {
    try {
      Logger.info('PlayerBloc: Initializing player for media: ${mediaItem.id}');
      emit(PlayerState.loading(mediaItem));

      // Validate media item
      _validateMediaItem(mediaItem);

      // Initialize video service
      await videoPlayerService.initialize(mediaItem.streamUrl);

      // Determine initial quality
      String? initialQuality;
      if (mediaItem.qualityOptions.isNotEmpty) {
        initialQuality = mediaItem.qualityOptions.keys.contains(StreamConstants.defaultQuality)
            ? StreamConstants.defaultQuality
            : mediaItem.qualityOptions.keys.first;
      }

      // Create initial playback state
      final playbackState = PlaybackState(
        mediaItemId: mediaItem.id,
        position: Duration.zero,
        duration: videoPlayerService.currentState.duration,
        isPlaying: false,
        isBuffering: false,
        playbackSpeed: StreamConstants.defaultPlaybackSpeed,
        currentQuality: initialQuality,
        volume: StreamConstants.defaultVolume,
        isMuted: StreamConstants.defaultMuteState,
        lastUpdated: DateTime.now(),
      );

      emit(PlayerState.ready(
        mediaItem: mediaItem,
        playbackState: playbackState,
      ));

      // Start timers
      _startPositionTimer();
      _startAutoSaveTimer();

      Logger.info('PlayerBloc: Player initialized successfully');
    } on StreamException catch (e) {
      Logger.error('PlayerBloc: Initialization failed', e);
      emit(PlayerState.error(e.message));
    } catch (e) {
      Logger.error('PlayerBloc: Unexpected initialization error', e);
      emit(PlayerState.error('Failed to initialize player: ${e.toString()}'));
    }
  }

  Future<void> _onPlay(Emitter<PlayerState> emit) async {
    try {
      Logger.debug('PlayerBloc: Play requested');
      await videoPlayerService.play();

      _emitPlaybackState(emit, (playbackState) {
        return _copyPlaybackState(
          playbackState,
          isPlaying: true,
          isBuffering: false,
        );
      }, playing: true);
    } catch (e) {
      Logger.error('PlayerBloc: Play failed', e);
      emit(PlayerState.error('Failed to play: ${e.toString()}'));
    }
  }

  Future<void> _onPause(Emitter<PlayerState> emit) async {
    try {
      Logger.debug('PlayerBloc: Pause requested');
      await videoPlayerService.pause();

      _emitPlaybackState(emit, (playbackState) {
        final updatedState = _copyPlaybackState(
          playbackState,
          isPlaying: false,
          isBuffering: false,
          position: videoPlayerService.currentState.position,
        );

        // Save state on pause
        _savePlaybackState(updatedState);

        return updatedState;
      }, playing: false);
    } catch (e) {
      Logger.error('PlayerBloc: Pause failed', e);
    }
  }

  Future<void> _onSeekTo(
    Duration position,
    Emitter<PlayerState> emit,
  ) async {
    try {
      Logger.debug('PlayerBloc: Seek to $position requested');
      _isSeeking = true;
      await videoPlayerService.seekTo(position);

      // Small delay for seek to complete
      await Future.delayed(StreamConstants.seekCompleteDelay);
      _isSeeking = false;

      _emitPlaybackState(emit, (playbackState) {
        return _copyPlaybackState(
          playbackState,
          position: position,
          isBuffering: false,
        );
      });
    } on SeekException catch (e) {
      Logger.error('PlayerBloc: Seek failed', e);
      _isSeeking = false;
      emit(PlayerState.error(e.message));
    } catch (e) {
      Logger.error('PlayerBloc: Unexpected seek error', e);
      _isSeeking = false;
    }
  }

  Future<void> _onSetSpeed(
    double speed,
    Emitter<PlayerState> emit,
  ) async {
    try {
      Logger.debug('PlayerBloc: Set speed to $speed requested');

      // Validate speed
      if (!StreamConstants.availablePlaybackSpeeds.contains(speed)) {
        Logger.warning('PlayerBloc: Invalid speed $speed, using default');
        return;
      }

      await videoPlayerService.setPlaybackSpeed(speed);

      _emitPlaybackState(emit, (playbackState) {
        return _copyPlaybackState(
          playbackState,
          playbackSpeed: speed,
          isBuffering: false,
        );
      });
    } catch (e) {
      Logger.error('PlayerBloc: Set speed failed', e);
    }
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
    try {
      Logger.info('PlayerBloc: Switching quality to $quality');

      // Get the new quality URL
      final newUrl = mediaItem.qualityOptions[quality];
      if (newUrl == null || newUrl.isEmpty) {
        throw QualitySwitchException(quality, 'Quality option not available');
      }

      // Save current position
      final currentPosition = videoPlayerService.currentState.position;

      // Emit buffering state
      emit(PlayerState.buffering(
        mediaItem: mediaItem,
        playbackState: _copyPlaybackState(
          playbackState,
          position: currentPosition,
          isPlaying: false,
          isBuffering: true,
          currentQuality: quality,
        ),
      ));

      // Reinitialize with new URL
      await videoPlayerService.initialize(newUrl);

      // Restore state
      await videoPlayerService.seekTo(currentPosition);
      await videoPlayerService.setPlaybackSpeed(playbackState.playbackSpeed);
      await videoPlayerService.setVolume(playbackState.isMuted ? 0 : playbackState.volume);

      // Resume playback if it was playing
      if (wasPlaying) {
        await videoPlayerService.play();
      }

      // Emit updated state
      final updatedState = _copyPlaybackState(
        playbackState,
        position: currentPosition,
        duration: videoPlayerService.currentState.duration,
        isPlaying: wasPlaying,
        isBuffering: false,
        currentQuality: quality,
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

      Logger.info('PlayerBloc: Quality switched successfully to $quality');
    } on QualitySwitchException catch (e) {
      Logger.error('PlayerBloc: Quality switch failed', e);
      emit(PlayerState.error(e.message));
    } catch (e) {
      Logger.error('PlayerBloc: Unexpected quality switch error', e);
      emit(PlayerState.error('Failed to switch quality: ${e.toString()}'));
    }
  }

  Future<void> _onSetVolume(
    double volume,
    Emitter<PlayerState> emit,
  ) async {
    try {
      Logger.debug('PlayerBloc: Set volume to $volume requested');
      await videoPlayerService.setVolume(volume);

      _emitPlaybackState(emit, (playbackState) {
        return _copyPlaybackState(
          playbackState,
          volume: volume,
          isBuffering: false,
        );
      });
    } catch (e) {
      Logger.error('PlayerBloc: Set volume failed', e);
    }
  }

  Future<void> _onToggleMute(Emitter<PlayerState> emit) async {
    try {
      _emitPlaybackState(emit, (playbackState) {
        final newMuteState = !playbackState.isMuted;
        Logger.debug('PlayerBloc: Toggle mute to $newMuteState');

        videoPlayerService.setVolume(newMuteState ? 0 : playbackState.volume);

        return _copyPlaybackState(
          playbackState,
          isMuted: newMuteState,
        );
      });
    } catch (e) {
      Logger.error('PlayerBloc: Toggle mute failed', e);
    }
  }

  void _onUpdatePosition(
    Duration position,
    Emitter<PlayerState> emit,
  ) {
    _emitPlaybackState(emit, (playbackState) {
      return _copyPlaybackState(
        playbackState,
        position: position,
      );
    });
  }

  void _onUpdateBuffering(
    bool isBuffering,
    Emitter<PlayerState> emit,
  ) {
    // Don't show buffering state while seeking
    if (isBuffering && !_isSeeking) {
      state.maybeWhen(
        playing: (mediaItem, playbackState) {
          emit(PlayerState.buffering(
            mediaItem: mediaItem,
            playbackState: _copyPlaybackState(playbackState, isBuffering: true),
          ));
        },
        orElse: () {},
      );
    }
  }

  void _onVideoCompleted(Emitter<PlayerState> emit) {
    state.maybeWhen(
      playing: (mediaItem, playbackState) {
        Logger.info('PlayerBloc: Video completed');
        final updatedState = _copyPlaybackState(
          playbackState,
          position: playbackState.duration,
          isPlaying: false,
          isBuffering: false,
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

  // Helper Methods

  /// Copy playback state with optional updates
  /// Reduces duplication in state updates
  PlaybackState _copyPlaybackState(
    PlaybackState original, {
    Duration? position,
    Duration? duration,
    bool? isPlaying,
    bool? isBuffering,
    double? playbackSpeed,
    String? currentQuality,
    double? volume,
    bool? isMuted,
  }) {
    return PlaybackState(
      mediaItemId: original.mediaItemId,
      position: position ?? original.position,
      duration: duration ?? original.duration,
      isPlaying: isPlaying ?? original.isPlaying,
      isBuffering: isBuffering ?? original.isBuffering,
      playbackSpeed: playbackSpeed ?? original.playbackSpeed,
      currentQuality: currentQuality ?? original.currentQuality,
      volume: volume ?? original.volume,
      isMuted: isMuted ?? original.isMuted,
      lastUpdated: DateTime.now(),
    );
  }

  /// Emit playback state based on current player state
  /// Automatically determines which state variant to emit
  void _emitPlaybackState(
    Emitter<PlayerState> emit,
    PlaybackState Function(PlaybackState) updater, {
    bool? playing,
  }) {
    state.maybeWhen(
      ready: (mediaItem, playbackState) {
        final updated = updater(playbackState);
        emit(PlayerState.ready(mediaItem: mediaItem, playbackState: updated));
      },
      playing: (mediaItem, playbackState) {
        final updated = updater(playbackState);
        final isPlaying = playing ?? updated.isPlaying;
        if (isPlaying) {
          emit(PlayerState.playing(mediaItem: mediaItem, playbackState: updated));
        } else {
          emit(PlayerState.paused(mediaItem: mediaItem, playbackState: updated));
        }
      },
      paused: (mediaItem, playbackState) {
        final updated = updater(playbackState);
        final isPlaying = playing ?? updated.isPlaying;
        if (isPlaying) {
          emit(PlayerState.playing(mediaItem: mediaItem, playbackState: updated));
        } else {
          emit(PlayerState.paused(mediaItem: mediaItem, playbackState: updated));
        }
      },
      buffering: (mediaItem, playbackState) {
        final updated = updater(playbackState);
        if (updated.isBuffering) {
          emit(PlayerState.buffering(mediaItem: mediaItem, playbackState: updated));
        } else if (updated.isPlaying) {
          emit(PlayerState.playing(mediaItem: mediaItem, playbackState: updated));
        } else {
          emit(PlayerState.paused(mediaItem: mediaItem, playbackState: updated));
        }
      },
      orElse: () {},
    );
  }

  void _startPositionTimer() {
    _positionTimer?.cancel();
    _positionTimer = Timer.periodic(StreamConstants.positionUpdateInterval, (_) {
      if (videoPlayerService.isInitialized && videoPlayerService.currentState.isPlaying) {
        add(PlayerEvent.updatePosition(videoPlayerService.currentState.position));
      }
    });
  }

  void _startAutoSaveTimer() {
    _autoSaveTimer?.cancel();
    _autoSaveTimer = Timer.periodic(StreamConstants.playbackStateSaveInterval, (_) {
      state.maybeWhen(
        playing: (_, playbackState) => _savePlaybackState(playbackState),
        orElse: () {},
      );
    });
  }

  void _savePlaybackState(PlaybackState state) {
    Logger.debug('PlayerBloc: Saving playback state');
    savePlaybackStateUseCase(SavePlaybackStateParams(state: state));
  }

  void _validateMediaItem(dynamic mediaItem) {
    if (mediaItem.streamUrl.isEmpty) {
      throw const InvalidMediaItemException('streamUrl', 'Stream URL cannot be empty');
    }

    if (mediaItem.title.isEmpty || mediaItem.title.length > StreamConstants.maxTitleLength) {
      throw InvalidMediaItemException(
        'title',
        'Title must be between ${StreamConstants.minTitleLength} and ${StreamConstants.maxTitleLength} characters',
      );
    }
  }

  void _cleanup() {
    Logger.info('PlayerBloc: Cleaning up');
    _positionTimer?.cancel();
    _autoSaveTimer?.cancel();
    _playerStateSubscription?.cancel();
    videoPlayerService.dispose();
  }

  @override
  Future<void> close() {
    _cleanup();
    return super.close();
  }
}
