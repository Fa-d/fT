import 'dart:async';

/// Video player state
/// Represents the current state of the video player
class VideoPlayerServiceState {
  final bool isInitialized;
  final bool isPlaying;
  final bool isBuffering;
  final Duration position;
  final Duration duration;
  final double playbackSpeed;
  final double volume;
  final double aspectRatio;
  final String? errorMessage;

  const VideoPlayerServiceState({
    this.isInitialized = false,
    this.isPlaying = false,
    this.isBuffering = false,
    this.position = Duration.zero,
    this.duration = Duration.zero,
    this.playbackSpeed = 1.0,
    this.volume = 1.0,
    this.aspectRatio = 16 / 9,
    this.errorMessage,
  });

  VideoPlayerServiceState copyWith({
    bool? isInitialized,
    bool? isPlaying,
    bool? isBuffering,
    Duration? position,
    Duration? duration,
    double? playbackSpeed,
    double? volume,
    double? aspectRatio,
    String? errorMessage,
  }) {
    return VideoPlayerServiceState(
      isInitialized: isInitialized ?? this.isInitialized,
      isPlaying: isPlaying ?? this.isPlaying,
      isBuffering: isBuffering ?? this.isBuffering,
      position: position ?? this.position,
      duration: duration ?? this.duration,
      playbackSpeed: playbackSpeed ?? this.playbackSpeed,
      volume: volume ?? this.volume,
      aspectRatio: aspectRatio ?? this.aspectRatio,
      errorMessage: errorMessage,
    );
  }

  bool get hasError => errorMessage != null;
}

/// Video player service interface
/// Abstracts video player functionality from infrastructure concerns
/// This allows the domain/presentation layer to be independent of the video player implementation
abstract class VideoPlayerService {
  /// Get the current state stream
  Stream<VideoPlayerServiceState> get stateStream;

  /// Get the current state
  VideoPlayerServiceState get currentState;

  /// Initialize the player with a video URL
  Future<void> initialize(String videoUrl);

  /// Play the video
  Future<void> play();

  /// Pause the video
  Future<void> pause();

  /// Seek to a specific position
  Future<void> seekTo(Duration position);

  /// Set playback speed
  Future<void> setPlaybackSpeed(double speed);

  /// Set volume (0.0 to 1.0)
  Future<void> setVolume(double volume);

  /// Check if the player is initialized
  bool get isInitialized;

  /// Get the controller (for VideoPlayer widget)
  /// This is a temporary coupling until we create a custom video widget
  dynamic get nativeController;

  /// Dispose the player
  Future<void> dispose();
}
