import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/download_task_model.dart';
import '../models/playback_state_model.dart';
import '../models/media_item_model.dart';

/// Local data source for stream feature
/// Handles local storage of downloads, playback states, and cached data
abstract class StreamLocalDataSource {
  /// Save download task to local storage
  Future<void> saveDownloadTask(DownloadTaskModel task);

  /// Get download task by ID
  Future<DownloadTaskModel?> getDownloadTask(String taskId);

  /// Get all download tasks
  Future<List<DownloadTaskModel>> getAllDownloadTasks();

  /// Update download task
  Future<void> updateDownloadTask(DownloadTaskModel task);

  /// Delete download task
  Future<void> deleteDownloadTask(String taskId);

  /// Save playback state
  Future<void> savePlaybackState(PlaybackStateModel state);

  /// Get playback state by media item ID
  Future<PlaybackStateModel?> getPlaybackState(String mediaItemId);

  /// Get playback history
  Future<List<PlaybackStateModel>> getPlaybackHistory({int limit = 50});

  /// Cache media items
  Future<void> cacheMediaItems(List<MediaItemModel> items);

  /// Get cached media items
  Future<List<MediaItemModel>> getCachedMediaItems();
}

/// Implementation of StreamLocalDataSource using SharedPreferences
class StreamLocalDataSourceImpl implements StreamLocalDataSource {
  final SharedPreferences sharedPreferences;

  static const _downloadTasksKey = 'download_tasks';
  static const _playbackStatesKey = 'playback_states';
  static const _cachedMediaItemsKey = 'cached_media_items';

  StreamLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> saveDownloadTask(DownloadTaskModel task) async {
    final tasks = await getAllDownloadTasks();
    final index = tasks.indexWhere((t) => t.id == task.id);

    if (index != -1) {
      tasks[index] = task;
    } else {
      tasks.add(task);
    }

    final jsonList = tasks.map((t) => t.toJson()).toList();
    await sharedPreferences.setString(
      _downloadTasksKey,
      jsonEncode(jsonList),
    );
  }

  @override
  Future<DownloadTaskModel?> getDownloadTask(String taskId) async {
    final tasks = await getAllDownloadTasks();
    try {
      return tasks.firstWhere((t) => t.id == taskId);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<List<DownloadTaskModel>> getAllDownloadTasks() async {
    final jsonString = sharedPreferences.getString(_downloadTasksKey);
    if (jsonString == null) return [];

    final List<dynamic> jsonList = jsonDecode(jsonString);
    return jsonList
        .map((json) => DownloadTaskModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<void> updateDownloadTask(DownloadTaskModel task) async {
    await saveDownloadTask(task);
  }

  @override
  Future<void> deleteDownloadTask(String taskId) async {
    final tasks = await getAllDownloadTasks();
    tasks.removeWhere((t) => t.id == taskId);

    final jsonList = tasks.map((t) => t.toJson()).toList();
    await sharedPreferences.setString(
      _downloadTasksKey,
      jsonEncode(jsonList),
    );
  }

  @override
  Future<void> savePlaybackState(PlaybackStateModel state) async {
    final states = await getPlaybackHistory();
    final index = states.indexWhere((s) => s.mediaItemId == state.mediaItemId);

    if (index != -1) {
      states[index] = state;
    } else {
      states.insert(0, state); // Add to beginning
    }

    // Keep only the most recent 100 states
    final limitedStates = states.take(100).toList();

    final jsonList = limitedStates.map((s) => s.toJson()).toList();
    await sharedPreferences.setString(
      _playbackStatesKey,
      jsonEncode(jsonList),
    );
  }

  @override
  Future<PlaybackStateModel?> getPlaybackState(String mediaItemId) async {
    final states = await getPlaybackHistory();
    try {
      return states.firstWhere((s) => s.mediaItemId == mediaItemId);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<List<PlaybackStateModel>> getPlaybackHistory({int limit = 50}) async {
    final jsonString = sharedPreferences.getString(_playbackStatesKey);
    if (jsonString == null) return [];

    final List<dynamic> jsonList = jsonDecode(jsonString);
    final states = jsonList
        .map((json) =>
            PlaybackStateModel.fromJson(json as Map<String, dynamic>))
        .toList();

    return states.take(limit).toList();
  }

  @override
  Future<void> cacheMediaItems(List<MediaItemModel> items) async {
    final jsonList = items.map((item) => item.toJson()).toList();
    await sharedPreferences.setString(
      _cachedMediaItemsKey,
      jsonEncode(jsonList),
    );
  }

  @override
  Future<List<MediaItemModel>> getCachedMediaItems() async {
    final jsonString = sharedPreferences.getString(_cachedMediaItemsKey);
    if (jsonString == null) return [];

    final List<dynamic> jsonList = jsonDecode(jsonString);
    return jsonList
        .map((json) => MediaItemModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}
