/// Application-wide constants
library;

class AppConstants {
  // API Constants
  static const String apiBaseUrl = 'https://api.example.com';
  static const int apiTimeout = 30000;

  // Cache Constants
  static const String cacheKeyPrefix = 'app_cache_';
  static const int cacheMaxAge = 86400; // 24 hours in seconds

  // Storage Keys
  static const String tokenKey = 'auth_token';
  static const String refreshTokenKey = 'refresh_token';
  static const String userIdKey = 'user_id';

  // Event Store Constants
  static const int snapshotInterval = 10; // Create snapshot every 10 events

  // Sync Constants
  static const int syncBatchSize = 50;
  static const int syncRetryAttempts = 3;
  static const int syncRetryDelay = 1000; // milliseconds

  // WebSocket Constants
  static const int wsReconnectDelay = 3000; // milliseconds
  static const int wsMaxReconnectAttempts = 5;
  static const int wsPingInterval = 30000; // milliseconds

  // Pagination Constants
  static const int defaultPageSize = 20;
  static const int maxPageSize = 100;

  // Media Constants
  static const int maxImageSize = 10485760; // 10 MB
  static const int maxVideoSize = 104857600; // 100 MB
  static const List<String> supportedImageFormats = ['jpg', 'jpeg', 'png', 'gif', 'webp'];
  static const List<String> supportedVideoFormats = ['mp4', 'mov', 'avi', 'mkv'];

  // Performance Constants
  static const int imageMemoryCacheSize = 100; // Number of images to cache in memory
  static const int listPreloadThreshold = 5; // Items before end of list to trigger load more
}
