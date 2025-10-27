import 'package:equatable/equatable.dart';

/// System statistics entity
/// Demonstrates clean architecture domain entities
class SystemStats extends Equatable {
  final int eventCount;
  final int pendingSyncCount;
  final bool isOnline;
  final DateTime lastSyncTime;
  final String syncStatus;

  const SystemStats({
    required this.eventCount,
    required this.pendingSyncCount,
    required this.isOnline,
    required this.lastSyncTime,
    required this.syncStatus,
  });

  @override
  List<Object?> get props => [
        eventCount,
        pendingSyncCount,
        isOnline,
        lastSyncTime,
        syncStatus,
      ];
}
