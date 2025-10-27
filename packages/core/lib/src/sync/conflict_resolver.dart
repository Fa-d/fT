import 'package:dartz/dartz.dart';
import '../error/failures.dart';
import '../utils/logger.dart';
import 'sync_manager.dart';

/// Conflict resolver for handling sync conflicts
/// Implements different conflict resolution strategies
class ConflictResolver {
  final AppLogger _logger = AppLogger();
  final ConflictResolutionStrategy _strategy;

  ConflictResolver({
    ConflictResolutionStrategy strategy = ConflictResolutionStrategy.lastWriteWins,
  }) : _strategy = strategy;

  /// Resolve a conflict between local and remote data
  Future<Either<Failure, SyncableEntity>> resolve({
    required SyncableEntity local,
    required SyncableEntity remote,
  }) async {
    _logger.info(
      'Resolving conflict for entity: ${local.entityId} using strategy: $_strategy',
    );

    try {
      switch (_strategy) {
        case ConflictResolutionStrategy.lastWriteWins:
          return _lastWriteWins(local, remote);

        case ConflictResolutionStrategy.localWins:
          return _localWins(local, remote);

        case ConflictResolutionStrategy.remoteWins:
          return _remoteWins(local, remote);

        case ConflictResolutionStrategy.merge:
          return _merge(local, remote);

        case ConflictResolutionStrategy.manual:
          return _requireManualResolution(local, remote);
      }
    } catch (e) {
      return Left(ConflictFailure('Failed to resolve conflict: ${e.toString()}'));
    }
  }

  /// Last write wins strategy
  /// The entity with the latest modification time wins
  Either<Failure, SyncableEntity> _lastWriteWins(
    SyncableEntity local,
    SyncableEntity remote,
  ) {
    if (local.modifiedAt.isAfter(remote.modifiedAt)) {
      _logger.info('Conflict resolved: local wins (last write)');
      return Right(local);
    } else {
      _logger.info('Conflict resolved: remote wins (last write)');
      return Right(remote);
    }
  }

  /// Local always wins strategy
  Either<Failure, SyncableEntity> _localWins(
    SyncableEntity local,
    SyncableEntity remote,
  ) {
    _logger.info('Conflict resolved: local wins (policy)');
    return Right(local);
  }

  /// Remote always wins strategy
  Either<Failure, SyncableEntity> _remoteWins(
    SyncableEntity local,
    SyncableEntity remote,
  ) {
    _logger.info('Conflict resolved: remote wins (policy)');
    return Right(remote);
  }

  /// Merge strategy
  /// Attempts to merge changes from both local and remote
  /// This is a simplified implementation - real merging would need domain knowledge
  Either<Failure, SyncableEntity> _merge(
    SyncableEntity local,
    SyncableEntity remote,
  ) {
    _logger.info('Conflict resolved: merged');
    // In a real implementation, this would intelligently merge the two entities
    // For now, we'll just use the remote version
    return Right(remote);
  }

  /// Require manual resolution
  /// Returns a failure that indicates manual intervention is needed
  Either<Failure, SyncableEntity> _requireManualResolution(
    SyncableEntity local,
    SyncableEntity remote,
  ) {
    _logger.warning('Conflict requires manual resolution');
    return Left(
      ConflictFailure(
        'Manual conflict resolution required for entity: ${local.entityId}',
      ),
    );
  }
}

/// Conflict resolution strategies
enum ConflictResolutionStrategy {
  /// Last write wins - entity with latest timestamp wins
  lastWriteWins,

  /// Local changes always win
  localWins,

  /// Remote changes always win
  remoteWins,

  /// Attempt to merge both changes
  merge,

  /// Require manual resolution
  manual,
}

/// Conflict information for UI display
class ConflictInfo {
  final String entityId;
  final String entityType;
  final SyncableEntity local;
  final SyncableEntity remote;
  final DateTime detectedAt;

  const ConflictInfo({
    required this.entityId,
    required this.entityType,
    required this.local,
    required this.remote,
    required this.detectedAt,
  });
}
