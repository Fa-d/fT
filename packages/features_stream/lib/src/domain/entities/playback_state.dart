import 'package:equatable/equatable.dart';

/// Playback state entity
/// Represents the current state of media playback
class PlaybackState extends Equatable {
  final String mediaItemId;
  final Duration position;
  final Duration duration;
  final bool isPlaying;
  final bool isBuffering;
  final double playbackSpeed;
  final String? currentQuality;
  final double volume;
  final bool isMuted;
  final bool isFullscreen;
  final DateTime lastUpdated;

  const PlaybackState({
    required this.mediaItemId,
    required this.position,
    required this.duration,
    required this.isPlaying,
    required this.isBuffering,
    this.playbackSpeed = 1.0,
    this.currentQuality,
    this.volume = 1.0,
    this.isMuted = false,
    this.isFullscreen = false,
    required this.lastUpdated,
  });

  /// Create initial playback state
  factory PlaybackState.initial(String mediaItemId) {
    return PlaybackState(
      mediaItemId: mediaItemId,
      position: Duration.zero,
      duration: Duration.zero,
      isPlaying: false,
      isBuffering: false,
      playbackSpeed: 1.0,
      volume: 1.0,
      isMuted: false,
      lastUpdated: DateTime.now(),
    );
  }

  /// Calculate progress percentage (0.0 to 1.0)
  double get progress {
    if (duration.inMilliseconds == 0) return 0.0;
    return position.inMilliseconds / duration.inMilliseconds;
  }

  /// Check if playback is complete
  bool get isCompleted {
    return position >= duration && duration.inMilliseconds > 0;
  }

  @override
  List<Object?> get props => [
        mediaItemId,
        position,
        duration,
        isPlaying,
        isBuffering,
        playbackSpeed,
        currentQuality,
        volume,
        isMuted,
        isFullscreen,
        lastUpdated,
      ];
}
