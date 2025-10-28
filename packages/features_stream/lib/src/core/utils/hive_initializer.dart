import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import '../constants/stream_constants.dart';
import 'logger.dart';

/// Hive initializer for the stream feature
/// Call this before using any Hive-based services
class HiveInitializer {
  static bool _isInitialized = false;

  /// Initialize Hive for the stream feature
  /// Should be called once during app startup
  static Future<void> initialize() async {
    if (_isInitialized) {
      Logger.warning('HiveInitializer: Already initialized');
      return;
    }

    try {
      Logger.info('HiveInitializer: Initializing Hive');

      // Initialize Hive with Flutter
      await Hive.initFlutter();

      // Get application documents directory for desktop/mobile
      try {
        final appDocDir = await getApplicationDocumentsDirectory();
        Hive.init(appDocDir.path);
        Logger.debug('HiveInitializer: Using app documents directory: ${appDocDir.path}');
      } catch (e) {
        Logger.warning('HiveInitializer: Could not get app documents directory, using default: $e');
      }

      // Open boxes
      await Future.wait([
        Hive.openBox(StreamConstants.mediaItemsBox),
        Hive.openBox(StreamConstants.playbackStatesBox),
        Hive.openBox(StreamConstants.downloadTasksBox),
      ]);

      _isInitialized = true;
      Logger.info('HiveInitializer: Initialization complete');
    } catch (e, stackTrace) {
      Logger.error('HiveInitializer: Initialization failed', e, stackTrace);
      rethrow;
    }
  }

  /// Close all Hive boxes
  /// Should be called during app shutdown
  static Future<void> close() async {
    try {
      Logger.info('HiveInitializer: Closing all boxes');
      await Hive.close();
      _isInitialized = false;
      Logger.info('HiveInitializer: All boxes closed');
    } catch (e) {
      Logger.warning('HiveInitializer: Error closing boxes: $e');
    }
  }

  /// Check if Hive is initialized
  static bool get isInitialized => _isInitialized;
}
