import 'dart:async';
import 'package:video_player/video_player.dart';
import '../../domain/services/video_player_service.dart';
import '../../core/exceptions/stream_exceptions.dart';
import '../../core/utils/logger.dart';

/// Implementation of VideoPlayerService using the video_player package
/// This isolates the video_player dependency to the data layer
class VideoPlayerServiceImpl implements VideoPlayerService {
  VideoPlayerController? _controller;
  final StreamController<VideoPlayerServiceState> _stateController =
      StreamController<VideoPlayerServiceState>.broadcast();

  VideoPlayerServiceState _currentState = const VideoPlayerServiceState();

  @override
  Stream<VideoPlayerServiceState> get stateStream => _stateController.stream;

  @override
  VideoPlayerServiceState get currentState => _currentState;

  @override
  bool get isInitialized => _controller?.value.isInitialized ?? false;

  @override
  dynamic get nativeController => _controller;

  @override
  Future<void> initialize(String videoUrl) async {
    try {
      Logger.info('VideoPlayerService: Initializing with URL: $videoUrl');

      // Validate URL
      if (videoUrl.isEmpty) {
        throw const InvalidUrlException('', 'Video URL cannot be empty');
      }

      final uri = Uri.tryParse(videoUrl);
      if (uri == null || (!uri.hasScheme || (uri.scheme != 'http' && uri.scheme != 'https'))) {
        throw InvalidUrlException(videoUrl, 'Invalid video URL format');
      }

      // Dispose previous controller if exists
      await _controller?.dispose();

      // Create new controller
      _controller = VideoPlayerController.networkUrl(uri);

      // Add listener for state changes
      _controller!.addListener(_onControllerUpdate);

      // Initialize the controller
      await _controller!.initialize();

      // Update state
      _updateState(VideoPlayerServiceState(
        isInitialized: true,
        duration: _controller!.value.duration,
        aspectRatio: _controller!.value.aspectRatio,
        isPlaying: false,
        isBuffering: false,
        position: Duration.zero,
        playbackSpeed: 1.0,
        volume: 1.0,
      ));

      Logger.info('VideoPlayerService: Initialization successful');
    } catch (e) {
      Logger.error('VideoPlayerService: Initialization failed', e);
      _updateState(VideoPlayerServiceState(
        isInitialized: false,
        errorMessage: e.toString(),
      ));
      throw PlayerInitializationException('Failed to initialize player', e);
    }
  }

  @override
  Future<void> play() async {
    try {
      if (_controller == null || !_controller!.value.isInitialized) {
        throw const PlayerInitializationException('Player not initialized');
      }

      Logger.debug('VideoPlayerService: Playing');
      await _controller!.play();

      _updateState(_currentState.copyWith(
        isPlaying: true,
        isBuffering: false,
      ));
    } catch (e) {
      Logger.error('VideoPlayerService: Play failed', e);
      rethrow;
    }
  }

  @override
  Future<void> pause() async {
    try {
      if (_controller == null || !_controller!.value.isInitialized) {
        throw const PlayerInitializationException('Player not initialized');
      }

      Logger.debug('VideoPlayerService: Pausing');
      await _controller!.pause();

      _updateState(_currentState.copyWith(
        isPlaying: false,
        isBuffering: false,
        position: _controller!.value.position,
      ));
    } catch (e) {
      Logger.error('VideoPlayerService: Pause failed', e);
      rethrow;
    }
  }

  @override
  Future<void> seekTo(Duration position) async {
    try {
      if (_controller == null || !_controller!.value.isInitialized) {
        throw const PlayerInitializationException('Player not initialized');
      }

      // Validate position
      if (position.isNegative) {
        throw SeekException(position, 'Position cannot be negative');
      }

      if (position > _controller!.value.duration) {
        throw SeekException(position, 'Position exceeds video duration');
      }

      Logger.debug('VideoPlayerService: Seeking to $position');
      await _controller!.seekTo(position);

      _updateState(_currentState.copyWith(
        position: position,
      ));
    } catch (e) {
      Logger.error('VideoPlayerService: Seek failed', e);
      if (e is SeekException) rethrow;
      throw SeekException(position, 'Failed to seek', e);
    }
  }

  @override
  Future<void> setPlaybackSpeed(double speed) async {
    try {
      if (_controller == null || !_controller!.value.isInitialized) {
        throw const PlayerInitializationException('Player not initialized');
      }

      // Validate speed
      if (speed <= 0 || speed > 2.0) {
        throw PlayerInitializationException('Invalid playback speed: $speed (must be between 0 and 2.0)');
      }

      Logger.debug('VideoPlayerService: Setting playback speed to $speed');
      await _controller!.setPlaybackSpeed(speed);

      _updateState(_currentState.copyWith(
        playbackSpeed: speed,
      ));
    } catch (e) {
      Logger.error('VideoPlayerService: Set playback speed failed', e);
      rethrow;
    }
  }

  @override
  Future<void> setVolume(double volume) async {
    try {
      if (_controller == null || !_controller!.value.isInitialized) {
        throw const PlayerInitializationException('Player not initialized');
      }

      // Validate volume
      if (volume < 0 || volume > 1.0) {
        throw PlayerInitializationException('Invalid volume: $volume (must be between 0.0 and 1.0)');
      }

      Logger.debug('VideoPlayerService: Setting volume to $volume');
      await _controller!.setVolume(volume);

      _updateState(_currentState.copyWith(
        volume: volume,
      ));
    } catch (e) {
      Logger.error('VideoPlayerService: Set volume failed', e);
      rethrow;
    }
  }

  @override
  Future<void> dispose() async {
    Logger.info('VideoPlayerService: Disposing');
    await _controller?.dispose();
    _controller = null;
    await _stateController.close();
  }

  /// Handle controller updates
  void _onControllerUpdate() {
    if (_controller == null) return;

    final value = _controller!.value;

    // Update state based on controller changes
    _updateState(_currentState.copyWith(
      isPlaying: value.isPlaying,
      isBuffering: value.isBuffering,
      position: value.position,
      duration: value.duration,
      errorMessage: value.hasError ? value.errorDescription : null,
    ));
  }

  /// Update state and emit to stream
  void _updateState(VideoPlayerServiceState newState) {
    _currentState = newState;
    if (!_stateController.isClosed) {
      _stateController.add(newState);
    }
  }
}
