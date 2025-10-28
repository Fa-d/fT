import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import '../../domain/entities/media_item.dart';
import '../../domain/entities/playlist.dart';
import '../../domain/entities/download_task.dart';
import '../../domain/entities/playback_state.dart';
import '../../domain/repositories/stream_repository.dart';
import '../datasources/stream_local_data_source.dart';
import '../datasources/stream_remote_data_source.dart';
import '../models/download_task_model.dart';
import '../models/playback_state_model.dart';
import '../../core/utils/logger.dart';

/// Implementation of StreamRepository
/// Demonstrates clean architecture repository pattern with offline-first approach
class StreamRepositoryImpl implements StreamRepository {
  final StreamRemoteDataSource remoteDataSource;
  final StreamLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  final StreamController<DownloadTask> _downloadProgressController =
      StreamController<DownloadTask>.broadcast();

  bool _isDisposed = false;

  StreamRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, MediaItem>> getMediaItem(String id) async {
    try {
      if (await networkInfo.isConnected) {
        final remoteMediaItem = await remoteDataSource.getMediaItem(id);
        return Right(remoteMediaItem.toEntity());
      } else {
        // Try to get from cache
        final cachedItems = await localDataSource.getCachedMediaItems();
        final cachedItem = cachedItems.where((item) => item.id == id).firstOrNull;
        if (cachedItem != null) {
          return Right(cachedItem.toEntity());
        }
        return Left(NetworkFailure('No internet connection'));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<MediaItem>>> getMediaItems({
    int page = 1,
    int limit = 20,
    MediaType? type,
  }) async {
    try {
      if (await networkInfo.isConnected) {
        final remoteItems = await remoteDataSource.getMediaItems(
          page: page,
          limit: limit,
          type: type,
        );

        // Cache the items
        await localDataSource.cacheMediaItems(remoteItems);

        return Right(remoteItems.map((item) => item.toEntity()).toList());
      } else {
        // Return cached items
        final cachedItems = await localDataSource.getCachedMediaItems();
        return Right(cachedItems.map((item) => item.toEntity()).toList());
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<MediaItem>>> searchMediaItems(
      String query) async {
    try {
      if (await networkInfo.isConnected) {
        final results = await remoteDataSource.searchMediaItems(query);
        return Right(results.map((item) => item.toEntity()).toList());
      } else {
        return Left(NetworkFailure('No internet connection'));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Playlist>> getPlaylist(String id) async {
    try {
      if (await networkInfo.isConnected) {
        final playlist = await remoteDataSource.getPlaylist(id);
        return Right(playlist.toEntity());
      } else {
        return Left(NetworkFailure('No internet connection'));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Playlist>>> getUserPlaylists() async {
    try {
      if (await networkInfo.isConnected) {
        final playlists = await remoteDataSource.getUserPlaylists();
        return Right(playlists.map((p) => p.toEntity()).toList());
      } else {
        return Left(NetworkFailure('No internet connection'));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Playlist>> createPlaylist({
    required String name,
    required String description,
  }) async {
    try {
      if (await networkInfo.isConnected) {
        final playlist = await remoteDataSource.createPlaylist(
          name: name,
          description: description,
        );
        return Right(playlist.toEntity());
      } else {
        return Left(NetworkFailure('No internet connection'));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> addToPlaylist({
    required String playlistId,
    required String mediaItemId,
  }) async {
    try {
      if (await networkInfo.isConnected) {
        await remoteDataSource.addToPlaylist(
          playlistId: playlistId,
          mediaItemId: mediaItemId,
        );
        return const Right(unit);
      } else {
        return Left(NetworkFailure('No internet connection'));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, DownloadTask>> startDownload({
    required MediaItem mediaItem,
    required String quality,
  }) async {
    try {
      final task = DownloadTask.create(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        mediaItem: mediaItem,
        quality: quality,
      );

      final taskModel = DownloadTaskModel.fromEntity(task);
      await localDataSource.saveDownloadTask(taskModel);

      // TODO: Integrate with flutter_downloader to start actual download
      // For now, just return the task
      return Right(task);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> pauseDownload(String taskId) async {
    try {
      // TODO: Integrate with flutter_downloader
      return const Right(unit);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> resumeDownload(String taskId) async {
    try {
      // TODO: Integrate with flutter_downloader
      return const Right(unit);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> cancelDownload(String taskId) async {
    try {
      // TODO: Integrate with flutter_downloader
      await localDataSource.deleteDownloadTask(taskId);
      return const Right(unit);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteDownload(String taskId) async {
    try {
      await localDataSource.deleteDownloadTask(taskId);
      // TODO: Delete the actual file from storage
      return const Right(unit);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<DownloadTask>>> getDownloads() async {
    try {
      final tasks = await localDataSource.getAllDownloadTasks();
      return Right(tasks.map((t) => t.toEntity()).toList());
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, DownloadTask>> getDownloadTask(String taskId) async {
    try {
      final task = await localDataSource.getDownloadTask(taskId);
      if (task != null) {
        return Right(task.toEntity());
      } else {
        return Left(CacheFailure('Download task not found'));
      }
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Stream<DownloadTask> watchDownloadProgress(String taskId) {
    return _downloadProgressController.stream
        .where((task) => task.id == taskId);
  }

  @override
  Future<Either<Failure, Unit>> savePlaybackState(PlaybackState state) async {
    try {
      final stateModel = PlaybackStateModel.fromEntity(state);
      await localDataSource.savePlaybackState(stateModel);
      return const Right(unit);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, PlaybackState?>> getPlaybackState(
      String mediaItemId) async {
    try {
      final stateModel = await localDataSource.getPlaybackState(mediaItemId);
      if (stateModel != null) {
        return Right(stateModel.toEntity());
      } else {
        return const Right(null);
      }
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<PlaybackState>>> getPlaybackHistory({
    int limit = 50,
  }) async {
    try {
      final states = await localDataSource.getPlaybackHistory(limit: limit);
      return Right(states.map((s) => s.toEntity()).toList());
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  /// Dispose repository resources
  /// This should be called when the repository is no longer needed
  /// to prevent memory leaks
  Future<void> dispose() async {
    if (_isDisposed) {
      Logger.warning('StreamRepository: Already disposed');
      return;
    }

    Logger.info('StreamRepository: Disposing');
    _isDisposed = true;

    await _downloadProgressController.close();
  }

  /// Check if repository is disposed
  bool get isDisposed => _isDisposed;
}
