/// Constants for the stream feature
/// Centralizes all configuration values for better maintainability
class StreamConstants {
  StreamConstants._();

  // Player Settings
  static const Duration playbackStateSaveInterval = Duration(seconds: 10);
  static const Duration skipDuration = Duration(seconds: 10);
  static const Duration controlsHideDelay = Duration(seconds: 3);
  static const Duration seekCompleteDelay = Duration(milliseconds: 300);
  static const Duration positionUpdateInterval = Duration(seconds: 1);

  // Storage Settings
  static const int maxPlaybackHistory = 100;
  static const int maxCachedMediaItems = 200;
  static const int defaultPageSize = 20;

  // Playback Settings
  static const double defaultPlaybackSpeed = 1.0;
  static const double defaultVolume = 1.0;
  static const bool defaultMuteState = false;

  static const List<double> availablePlaybackSpeeds = [
    0.5,
    0.75,
    1.0,
    1.25,
    1.5,
    2.0,
  ];

  // Quality Settings
  static const String defaultQuality = 'Auto';

  // Download Settings
  static const int maxConcurrentDownloads = 3;
  static const Duration downloadRetryDelay = Duration(seconds: 5);
  static const int maxDownloadRetries = 3;

  // Cache Settings
  static const String cachedMediaItemsKey = 'cached_media_items';
  static const String playbackStatesKey = 'playback_states';
  static const String downloadTasksKey = 'download_tasks';

  // Hive Box Names
  static const String mediaItemsBox = 'media_items';
  static const String playbackStatesBox = 'playback_states';
  static const String downloadTasksBox = 'download_tasks';

  // Error Messages
  static const String networkErrorMessage = 'No internet connection';
  static const String downloadNotFoundMessage = 'Download task not found';
  static const String playbackErrorMessage = 'Failed to initialize player';
  static const String qualitySwitchErrorMessage = 'Failed to switch quality';

  // Validation
  static const int minTitleLength = 1;
  static const int maxTitleLength = 500;
  static const int minDescriptionLength = 0;
  static const int maxDescriptionLength = 5000;
}
