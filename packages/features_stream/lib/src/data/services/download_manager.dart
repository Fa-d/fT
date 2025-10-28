import 'dart:isolate';
import 'dart:ui';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import '../../domain/entities/download_task.dart';

/// Download manager service
/// Handles actual file downloads using flutter_downloader
class DownloadManager {
  static const _portName = 'downloader_send_port';

  /// Initialize the download manager
  static Future<void> initialize() async {
    await FlutterDownloader.initialize(
      debug: true,
      ignoreSsl: false,
    );

    // Register callback
    FlutterDownloader.registerCallback(downloadCallback);
  }

  /// Download callback
  @pragma('vm:entry-point')
  static void downloadCallback(
    String id,
    int status,
    int progress,
  ) {
    final SendPort? send = IsolateNameServer.lookupPortByName(_portName);
    send?.send([id, status, progress]);
  }

  /// Start a download
  Future<String?> startDownload({
    required String url,
    required String fileName,
    required String quality,
  }) async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final savedDir = '${dir.path}/videos';

      final taskId = await FlutterDownloader.enqueue(
        url: url,
        savedDir: savedDir,
        fileName: fileName,
        showNotification: true,
        openFileFromNotification: false,
        saveInPublicStorage: false,
      );

      return taskId;
    } catch (e) {
      // Log error for debugging
      // In production, use a proper logging framework
      // ignore: avoid_print
      print('Download error: $e');
      return null;
    }
  }

  /// Pause a download
  Future<void> pauseDownload(String taskId) async {
    await FlutterDownloader.pause(taskId: taskId);
  }

  /// Resume a download
  Future<void> resumeDownload(String taskId) async {
    final newTaskId = await FlutterDownloader.resume(taskId: taskId);
    // Log for debugging
    // ignore: avoid_print
    print('Resumed with new task ID: $newTaskId');
  }

  /// Cancel a download
  Future<void> cancelDownload(String taskId) async {
    await FlutterDownloader.cancel(taskId: taskId);
  }

  /// Remove a download
  Future<void> removeDownload(String taskId) async {
    await FlutterDownloader.remove(taskId: taskId, shouldDeleteContent: true);
  }

  /// Get download status
  Future<DownloadStatus> getDownloadStatus(String taskId) async {
    final tasks = await FlutterDownloader.loadTasksWithRawQuery(
      query: 'SELECT * FROM task WHERE task_id = "$taskId"',
    );

    if (tasks == null || tasks.isEmpty) {
      return DownloadStatus.pending;
    }

    return _mapStatus(tasks.first.status);
  }

  /// Map flutter_downloader status to domain status
  DownloadStatus _mapStatus(DownloadTaskStatus status) {
    switch (status) {
      case DownloadTaskStatus.enqueued:
      case DownloadTaskStatus.undefined:
        return DownloadStatus.pending;
      case DownloadTaskStatus.running:
        return DownloadStatus.downloading;
      case DownloadTaskStatus.paused:
        return DownloadStatus.paused;
      case DownloadTaskStatus.complete:
        return DownloadStatus.completed;
      case DownloadTaskStatus.failed:
        return DownloadStatus.failed;
      case DownloadTaskStatus.canceled:
        return DownloadStatus.cancelled;
    }
  }

  /// Listen to download progress
  ReceivePort setupProgressListener(Function(String, int, int) onProgress) {
    final port = ReceivePort();
    IsolateNameServer.removePortNameMapping(_portName);
    IsolateNameServer.registerPortWithName(port.sendPort, _portName);

    port.listen((dynamic data) {
      if (data is List && data.length == 3) {
        final String id = data[0];
        final int status = data[1];
        final int progress = data[2];
        onProgress(id, status, progress);
      }
    });

    return port;
  }
}
