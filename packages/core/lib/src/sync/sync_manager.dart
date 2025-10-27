import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:rxdart/rxdart.dart';
import '../error/failures.dart';
import '../network/network_info.dart';
import '../utils/logger.dart';
import 'conflict_resolver.dart';

/// Sync manager for offline-first architecture
/// Handles background synchronization of local changes to the server
class SyncManager {
  final NetworkInfo _networkInfo;
  final ConflictResolver _conflictResolver;
  final AppLogger _logger = AppLogger();

  final _syncStateController = BehaviorSubject<SyncState>.seeded(
    const SyncState.idle(),
  );

  Stream<SyncState> get syncState => _syncStateController.stream;
  SyncState get currentState => _syncStateController.value;

  Timer? _periodicSyncTimer;
  StreamSubscription? _networkSubscription;

  final List<SyncableEntity> _pendingChanges = [];
  bool _isSyncing = false;

  SyncManager({
    required NetworkInfo networkInfo,
    required ConflictResolver conflictResolver,
  })  : _networkInfo = networkInfo,
        _conflictResolver = conflictResolver;

  /// Initialize the sync manager
  Future<void> initialize({
    Duration periodicSyncInterval = const Duration(minutes: 5),
    bool syncOnNetworkChange = true,
  }) async {
    // Set up periodic sync
    _periodicSyncTimer = Timer.periodic(periodicSyncInterval, (_) {
      sync();
    });

    // Set up network change listener
    if (syncOnNetworkChange) {
      _networkSubscription = _networkInfo.onConnectivityChanged.listen((isConnected) {
        if (isConnected) {
          _logger.info('Network connected, triggering sync');
          sync();
        }
      });
    }

    // Initial sync if online
    final isOnline = await _networkInfo.isConnected;
    if (isOnline) {
      sync();
    }
  }

  /// Queue a change for synchronization
  void queueChange(SyncableEntity entity) {
    _pendingChanges.add(entity);
    _logger.info('Queued change: ${entity.entityType} ${entity.entityId}');

    // Trigger sync if online
    _networkInfo.isConnected.then((isConnected) {
      if (isConnected) {
        sync();
      }
    });
  }

  /// Perform synchronization
  Future<Either<Failure, Unit>> sync() async {
    if (_isSyncing) {
      _logger.info('Sync already in progress');
      return const Right(unit);
    }

    final isOnline = await _networkInfo.isConnected;
    if (!isOnline) {
      _logger.info('Device offline, skipping sync');
      return Left(NetworkFailure('Device is offline'));
    }

    if (_pendingChanges.isEmpty) {
      _logger.info('No pending changes to sync');
      return const Right(unit);
    }

    _isSyncing = true;
    _syncStateController.add(
      SyncState.syncing(progress: 0, total: _pendingChanges.length),
    );

    try {
      int synced = 0;

      // Process changes in batches
      const batchSize = 10;
      for (var i = 0; i < _pendingChanges.length; i += batchSize) {
        final batch = _pendingChanges.skip(i).take(batchSize).toList();

        for (final entity in batch) {
          final result = await _syncEntity(entity);

          result.fold(
            (failure) {
              _logger.error('Failed to sync entity: ${entity.entityId}', failure);
              _syncStateController.add(
                SyncState.error(message: failure.message),
              );
            },
            (_) {
              synced++;
              _syncStateController.add(
                SyncState.syncing(progress: synced, total: _pendingChanges.length),
              );
            },
          );
        }
      }

      // Clear synced changes
      _pendingChanges.clear();

      _syncStateController.add(const SyncState.completed());
      _logger.info('Sync completed: $synced entities synced');

      return const Right(unit);
    } catch (e) {
      _logger.error('Sync failed', e);
      _syncStateController.add(SyncState.error(message: e.toString()));
      return Left(SyncFailure('Sync failed: ${e.toString()}'));
    } finally {
      _isSyncing = false;
    }
  }

  /// Sync a single entity
  Future<Either<Failure, Unit>> _syncEntity(SyncableEntity entity) async {
    try {
      // This is where you would:
      // 1. Send the entity to the server
      // 2. Handle conflicts using the conflict resolver
      // 3. Update local state based on server response

      // Placeholder implementation
      await Future.delayed(const Duration(milliseconds: 100));

      // Simulate conflict detection
      if (entity.version != null) {
        final serverVersion = entity.version! + 1; // Simulated server version
        if (serverVersion > entity.version!) {
          // Conflict detected, resolve it
          final resolution = await _conflictResolver.resolve(
            local: entity,
            remote: entity, // Would be actual server data
          );

          return resolution.fold(
            (failure) => Left(failure),
            (resolved) {
              _logger.info('Conflict resolved for entity: ${entity.entityId}');
              return const Right(unit);
            },
          );
        }
      }

      return const Right(unit);
    } catch (e) {
      return Left(SyncFailure('Failed to sync entity: ${e.toString()}'));
    }
  }

  /// Force immediate sync
  Future<Either<Failure, Unit>> forceSyncNow() async {
    _logger.info('Force sync triggered');
    return sync();
  }

  /// Get pending changes count
  int get pendingChangesCount => _pendingChanges.length;

  /// Dispose the sync manager
  void dispose() {
    _periodicSyncTimer?.cancel();
    _networkSubscription?.cancel();
    _syncStateController.close();
  }
}

/// Syncable entity interface
abstract class SyncableEntity {
  String get entityId;
  String get entityType;
  int? get version;
  DateTime get modifiedAt;
  SyncOperation get operation;
}

/// Sync operations
enum SyncOperation {
  create,
  update,
  delete,
}

/// Sync state
class SyncState {
  final SyncStatus status;
  final int? progress;
  final int? total;
  final String? message;

  const SyncState({
    required this.status,
    this.progress,
    this.total,
    this.message,
  });

  const SyncState.idle() : this(status: SyncStatus.idle);

  const SyncState.syncing({required int progress, required int total})
      : this(
          status: SyncStatus.syncing,
          progress: progress,
          total: total,
        );

  const SyncState.completed() : this(status: SyncStatus.completed);

  const SyncState.error({required String message})
      : this(
          status: SyncStatus.error,
          message: message,
        );

  double? get progressPercentage {
    if (progress != null && total != null && total! > 0) {
      return progress! / total!;
    }
    return null;
  }
}

enum SyncStatus {
  idle,
  syncing,
  completed,
  error,
}
