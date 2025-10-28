import 'package:hive_flutter/hive_flutter.dart';
import '../models/download_task_model.dart';
import '../models/playback_state_model.dart';
import '../models/media_item_model.dart';
import '../../core/constants/stream_constants.dart';
import '../../core/exceptions/stream_exceptions.dart';
import '../../core/utils/logger.dart';
import 'stream_local_data_source.dart';

/// Hive-based implementation of StreamLocalDataSource
/// Uses Hive for better performance and type safety compared to SharedPreferences
class StreamLocalDataSourceHive implements StreamLocalDataSource {
  late Box<dynamic> _mediaItemsBox;
  late Box<dynamic> _playbackStatesBox;
  late Box<dynamic> _downloadTasksBox;

  bool _isInitialized = false;

  /// Initialize Hive boxes
  Future<void> init() async {
    if (_isInitialized) {
      Logger.warning('StreamLocalDataSourceHive: Already initialized');
      return;
    }

    try {
      Logger.info('StreamLocalDataSourceHive: Initializing Hive boxes');

      // Initialize Hive (should be done in main.dart, but ensure it's called)
      if (!Hive.isBoxOpen(StreamConstants.mediaItemsBox)) {
        _mediaItemsBox = await Hive.openBox(StreamConstants.mediaItemsBox);
      } else {
        _mediaItemsBox = Hive.box(StreamConstants.mediaItemsBox);
      }

      if (!Hive.isBoxOpen(StreamConstants.playbackStatesBox)) {
        _playbackStatesBox = await Hive.openBox(StreamConstants.playbackStatesBox);
      } else {
        _playbackStatesBox = Hive.box(StreamConstants.playbackStatesBox);
      }

      if (!Hive.isBoxOpen(StreamConstants.downloadTasksBox)) {
        _downloadTasksBox = await Hive.openBox(StreamConstants.downloadTasksBox);
      } else {
        _downloadTasksBox = Hive.box(StreamConstants.downloadTasksBox);
      }

      _isInitialized = true;
      Logger.info('StreamLocalDataSourceHive: Initialization complete');
    } catch (e, stackTrace) {
      Logger.error('StreamLocalDataSourceHive: Initialization failed', e, stackTrace);
      throw StorageException('init', 'Failed to initialize Hive boxes', e);
    }
  }

  void _ensureInitialized() {
    if (!_isInitialized) {
      throw const StorageException('operation', 'Hive boxes not initialized. Call init() first');
    }
  }

  @override
  Future<void> saveDownloadTask(DownloadTaskModel task) async {
    try {
      _ensureInitialized();
      Logger.debug('StreamLocalDataSourceHive: Saving download task ${task.id}');
      await _downloadTasksBox.put(task.id, task.toJson());
    } catch (e, stackTrace) {
      Logger.error('StreamLocalDataSourceHive: Failed to save download task', e, stackTrace);
      throw StorageException('saveDownloadTask', 'Failed to save download task', e);
    }
  }

  @override
  Future<DownloadTaskModel?> getDownloadTask(String taskId) async {
    try {
      _ensureInitialized();
      Logger.debug('StreamLocalDataSourceHive: Getting download task $taskId');

      final json = _downloadTasksBox.get(taskId);
      if (json == null) return null;

      return DownloadTaskModel.fromJson(Map<String, dynamic>.from(json as Map));
    } catch (e, stackTrace) {
      Logger.error('StreamLocalDataSourceHive: Failed to get download task', e, stackTrace);
      throw StorageException('getDownloadTask', 'Failed to get download task', e);
    }
  }

  @override
  Future<List<DownloadTaskModel>> getAllDownloadTasks() async {
    try {
      _ensureInitialized();
      Logger.debug('StreamLocalDataSourceHive: Getting all download tasks');

      return _downloadTasksBox.values
          .map((json) => DownloadTaskModel.fromJson(Map<String, dynamic>.from(json as Map)))
          .toList();
    } catch (e, stackTrace) {
      Logger.error('StreamLocalDataSourceHive: Failed to get all download tasks', e, stackTrace);
      return [];
    }
  }

  @override
  Future<void> updateDownloadTask(DownloadTaskModel task) async {
    await saveDownloadTask(task);
  }

  @override
  Future<void> deleteDownloadTask(String taskId) async {
    try {
      _ensureInitialized();
      Logger.debug('StreamLocalDataSourceHive: Deleting download task $taskId');
      await _downloadTasksBox.delete(taskId);
    } catch (e, stackTrace) {
      Logger.error('StreamLocalDataSourceHive: Failed to delete download task', e, stackTrace);
      throw StorageException('deleteDownloadTask', 'Failed to delete download task', e);
    }
  }

  @override
  Future<void> savePlaybackState(PlaybackStateModel state) async {
    try {
      _ensureInitialized();
      Logger.debug('StreamLocalDataSourceHive: Saving playback state for ${state.mediaItemId}');

      // Store with timestamp to maintain order
      final key = '${state.mediaItemId}_${state.lastUpdated}';
      await _playbackStatesBox.put(key, state.toJson());

      // Clean up old states (keep only last N)
      await _cleanupOldPlaybackStates();
    } catch (e, stackTrace) {
      Logger.error('StreamLocalDataSourceHive: Failed to save playback state', e, stackTrace);
      throw StorageException('savePlaybackState', 'Failed to save playback state', e);
    }
  }

  @override
  Future<PlaybackStateModel?> getPlaybackState(String mediaItemId) async {
    try {
      _ensureInitialized();
      Logger.debug('StreamLocalDataSourceHive: Getting playback state for $mediaItemId');

      // Find the latest state for this media item
      final states = await getPlaybackHistory();
      return states.where((s) => s.mediaItemId == mediaItemId).firstOrNull;
    } catch (e, stackTrace) {
      Logger.error('StreamLocalDataSourceHive: Failed to get playback state', e, stackTrace);
      return null;
    }
  }

  @override
  Future<List<PlaybackStateModel>> getPlaybackHistory({int limit = 50}) async {
    try {
      _ensureInitialized();
      Logger.debug('StreamLocalDataSourceHive: Getting playback history (limit: $limit)');

      final states = _playbackStatesBox.values
          .map((json) => PlaybackStateModel.fromJson(Map<String, dynamic>.from(json as Map)))
          .toList();

      // Sort by lastUpdated descending
      states.sort((a, b) => DateTime.parse(b.lastUpdated).compareTo(DateTime.parse(a.lastUpdated)));

      return states.take(limit).toList();
    } catch (e, stackTrace) {
      Logger.error('StreamLocalDataSourceHive: Failed to get playback history', e, stackTrace);
      return [];
    }
  }

  @override
  Future<void> cacheMediaItems(List<MediaItemModel> items) async {
    try {
      _ensureInitialized();
      Logger.debug('StreamLocalDataSourceHive: Caching ${items.length} media items');

      for (final item in items) {
        await _mediaItemsBox.put(item.id, item.toJson());
      }

      // Clean up if too many items
      if (_mediaItemsBox.length > StreamConstants.maxCachedMediaItems) {
        await _cleanupOldMediaItems();
      }
    } catch (e, stackTrace) {
      Logger.error('StreamLocalDataSourceHive: Failed to cache media items', e, stackTrace);
      throw StorageException('cacheMediaItems', 'Failed to cache media items', e);
    }
  }

  @override
  Future<List<MediaItemModel>> getCachedMediaItems() async {
    try {
      _ensureInitialized();
      Logger.debug('StreamLocalDataSourceHive: Getting cached media items');

      return _mediaItemsBox.values
          .map((json) => MediaItemModel.fromJson(Map<String, dynamic>.from(json as Map)))
          .toList();
    } catch (e, stackTrace) {
      Logger.error('StreamLocalDataSourceHive: Failed to get cached media items', e, stackTrace);
      return [];
    }
  }

  /// Clean up old playback states to keep storage size manageable
  Future<void> _cleanupOldPlaybackStates() async {
    try {
      if (_playbackStatesBox.length > StreamConstants.maxPlaybackHistory) {
        final states = await getPlaybackHistory(limit: _playbackStatesBox.length);

        // Keep only the most recent N states
        final statesToKeep = states.take(StreamConstants.maxPlaybackHistory).toList();
        final keysToKeep = statesToKeep
            .map((s) => '${s.mediaItemId}_${s.lastUpdated}')
            .toSet();

        // Delete old states
        final keysToDelete = _playbackStatesBox.keys.where((key) => !keysToKeep.contains(key));
        await _playbackStatesBox.deleteAll(keysToDelete);

        Logger.debug('StreamLocalDataSourceHive: Cleaned up ${keysToDelete.length} old playback states');
      }
    } catch (e) {
      Logger.warning('StreamLocalDataSourceHive: Failed to cleanup playback states: $e');
    }
  }

  /// Clean up old media items to keep storage size manageable
  Future<void> _cleanupOldMediaItems() async {
    try {
      // Keep only the most recent items (simple FIFO)
      final excess = _mediaItemsBox.length - StreamConstants.maxCachedMediaItems;
      if (excess > 0) {
        final keysToDelete = _mediaItemsBox.keys.take(excess);
        await _mediaItemsBox.deleteAll(keysToDelete);

        Logger.debug('StreamLocalDataSourceHive: Cleaned up $excess old media items');
      }
    } catch (e) {
      Logger.warning('StreamLocalDataSourceHive: Failed to cleanup media items: $e');
    }
  }

  /// Close all Hive boxes
  Future<void> close() async {
    try {
      Logger.info('StreamLocalDataSourceHive: Closing Hive boxes');

      await _mediaItemsBox.close();
      await _playbackStatesBox.close();
      await _downloadTasksBox.close();

      _isInitialized = false;
    } catch (e) {
      Logger.warning('StreamLocalDataSourceHive: Error closing boxes: $e');
    }
  }
}
