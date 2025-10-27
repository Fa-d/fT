import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import '../../domain/entities/system_stats.dart';
import '../../domain/repositories/dashboard_repository.dart';

/// Dashboard repository implementation
/// Demonstrates repository pattern with multiple data sources
class DashboardRepositoryImpl implements DashboardRepository {
  final EventStore eventStore;
  final SyncManager syncManager;

  DashboardRepositoryImpl({
    required this.eventStore,
    required this.syncManager,
  });

  @override
  Future<Either<Failure, SystemStats>> getSystemStats() async {
    try {
      // Get event count from event store
      // This is a placeholder - in real implementation would query the event store
      final eventCount = 42;

      // Get sync stats from sync manager
      final pendingSyncCount = syncManager.pendingChangesCount;
      final syncStatus = syncManager.currentState.status.toString();

      // Get network status
      final isOnline = true; // Would come from NetworkInfo

      final stats = SystemStats(
        eventCount: eventCount,
        pendingSyncCount: pendingSyncCount,
        isOnline: isOnline,
        lastSyncTime: DateTime.now().subtract(const Duration(minutes: 5)),
        syncStatus: syncStatus,
      );

      return Right(stats);
    } catch (e) {
      return Left(UnexpectedFailure('Failed to get system stats: ${e.toString()}'));
    }
  }
}
