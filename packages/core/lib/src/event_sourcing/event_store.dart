import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../error/failures.dart';
import 'domain_event.dart';

/// Event Store implementation using SQLite
/// Stores all domain events for event sourcing pattern
/// Provides querying, filtering, and projection capabilities
class EventStore {
  static const String _tableName = 'events';
  static const String _snapshotsTable = 'snapshots';
  Database? _database;

  /// Initialize the event store database
  Future<void> initialize() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'event_store.db');

    _database = await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    // Events table
    await db.execute('''
      CREATE TABLE $_tableName (
        event_id TEXT PRIMARY KEY,
        event_type TEXT NOT NULL,
        aggregate_id TEXT NOT NULL,
        aggregate_type TEXT NOT NULL,
        aggregate_version INTEGER NOT NULL,
        timestamp INTEGER NOT NULL,
        caused_by TEXT,
        metadata TEXT,
        payload TEXT NOT NULL,
        created_at INTEGER NOT NULL,
        UNIQUE(aggregate_id, aggregate_version)
      )
    ''');

    // Create indexes for efficient querying
    await db.execute('''
      CREATE INDEX idx_aggregate_id ON $_tableName(aggregate_id)
    ''');
    await db.execute('''
      CREATE INDEX idx_aggregate_type ON $_tableName(aggregate_type)
    ''');
    await db.execute('''
      CREATE INDEX idx_timestamp ON $_tableName(timestamp)
    ''');

    // Snapshots table for performance optimization
    await db.execute('''
      CREATE TABLE $_snapshotsTable (
        aggregate_id TEXT PRIMARY KEY,
        aggregate_type TEXT NOT NULL,
        version INTEGER NOT NULL,
        state TEXT NOT NULL,
        created_at INTEGER NOT NULL
      )
    ''');
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    // Handle database migrations here
  }

  /// Append a new event to the event store
  /// Returns a Failure if the event conflicts with existing version
  Future<Either<Failure, Unit>> appendEvent(
    DomainEvent event, {
    required String aggregateType,
  }) async {
    try {
      final db = _database;
      if (db == null) {
        return Left(CacheFailure('Event store not initialized'));
      }

      final eventData = {
        'event_id': event.eventId,
        'event_type': event.eventType,
        'aggregate_id': event.aggregateId,
        'aggregate_type': aggregateType,
        'aggregate_version': event.aggregateVersion,
        'timestamp': event.timestamp.millisecondsSinceEpoch,
        'caused_by': event.causedBy,
        'metadata': event.metadata != null ? json.encode(event.metadata) : null,
        'payload': json.encode(event.toJson()),
        'created_at': DateTime.now().millisecondsSinceEpoch,
      };

      await db.insert(
        _tableName,
        eventData,
        conflictAlgorithm: ConflictAlgorithm.fail,
      );

      return const Right(unit);
    } on DatabaseException catch (e) {
      if (e.isUniqueConstraintError()) {
        return Left(CacheFailure('Version conflict: Event version already exists'));
      }
      return Left(CacheFailure('Failed to append event: ${e.toString()}'));
    } catch (e) {
      return Left(CacheFailure('Unexpected error: ${e.toString()}'));
    }
  }

  /// Append multiple events atomically
  Future<Either<Failure, Unit>> appendEvents(
    List<DomainEvent> events, {
    required String aggregateType,
  }) async {
    try {
      final db = _database;
      if (db == null) {
        return Left(CacheFailure('Event store not initialized'));
      }

      await db.transaction((txn) async {
        for (final event in events) {
          final eventData = {
            'event_id': event.eventId,
            'event_type': event.eventType,
            'aggregate_id': event.aggregateId,
            'aggregate_type': aggregateType,
            'aggregate_version': event.aggregateVersion,
            'timestamp': event.timestamp.millisecondsSinceEpoch,
            'caused_by': event.causedBy,
            'metadata': event.metadata != null ? json.encode(event.metadata) : null,
            'payload': json.encode(event.toJson()),
            'created_at': DateTime.now().millisecondsSinceEpoch,
          };

          await txn.insert(
            _tableName,
            eventData,
            conflictAlgorithm: ConflictAlgorithm.fail,
          );
        }
      });

      return const Right(unit);
    } catch (e) {
      return Left(CacheFailure('Failed to append events: ${e.toString()}'));
    }
  }

  /// Get all events for a specific aggregate
  Future<Either<Failure, List<Map<String, dynamic>>>> getEventsForAggregate(
    String aggregateId, {
    int? fromVersion,
  }) async {
    try {
      final db = _database;
      if (db == null) {
        return Left(CacheFailure('Event store not initialized'));
      }

      final where = fromVersion != null
          ? 'aggregate_id = ? AND aggregate_version >= ?'
          : 'aggregate_id = ?';
      final whereArgs = fromVersion != null ? [aggregateId, fromVersion] : [aggregateId];

      final results = await db.query(
        _tableName,
        where: where,
        whereArgs: whereArgs,
        orderBy: 'aggregate_version ASC',
      );

      return Right(results);
    } catch (e) {
      return Left(CacheFailure('Failed to get events: ${e.toString()}'));
    }
  }

  /// Get events by type
  Future<Either<Failure, List<Map<String, dynamic>>>> getEventsByType(
    String eventType, {
    int? limit,
  }) async {
    try {
      final db = _database;
      if (db == null) {
        return Left(CacheFailure('Event store not initialized'));
      }

      final results = await db.query(
        _tableName,
        where: 'event_type = ?',
        whereArgs: [eventType],
        orderBy: 'timestamp DESC',
        limit: limit,
      );

      return Right(results);
    } catch (e) {
      return Left(CacheFailure('Failed to get events by type: ${e.toString()}'));
    }
  }

  /// Get all events in a time range
  Future<Either<Failure, List<Map<String, dynamic>>>> getEventsInRange(
    DateTime start,
    DateTime end,
  ) async {
    try {
      final db = _database;
      if (db == null) {
        return Left(CacheFailure('Event store not initialized'));
      }

      final results = await db.query(
        _tableName,
        where: 'timestamp >= ? AND timestamp <= ?',
        whereArgs: [
          start.millisecondsSinceEpoch,
          end.millisecondsSinceEpoch,
        ],
        orderBy: 'timestamp ASC',
      );

      return Right(results);
    } catch (e) {
      return Left(CacheFailure('Failed to get events in range: ${e.toString()}'));
    }
  }

  /// Save a snapshot of aggregate state for performance optimization
  Future<Either<Failure, Unit>> saveSnapshot(
    String aggregateId,
    String aggregateType,
    int version,
    Map<String, dynamic> state,
  ) async {
    try {
      final db = _database;
      if (db == null) {
        return Left(CacheFailure('Event store not initialized'));
      }

      await db.insert(
        _snapshotsTable,
        {
          'aggregate_id': aggregateId,
          'aggregate_type': aggregateType,
          'version': version,
          'state': json.encode(state),
          'created_at': DateTime.now().millisecondsSinceEpoch,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      return const Right(unit);
    } catch (e) {
      return Left(CacheFailure('Failed to save snapshot: ${e.toString()}'));
    }
  }

  /// Get the latest snapshot for an aggregate
  Future<Either<Failure, Map<String, dynamic>?>> getSnapshot(
    String aggregateId,
  ) async {
    try {
      final db = _database;
      if (db == null) {
        return Left(CacheFailure('Event store not initialized'));
      }

      final results = await db.query(
        _snapshotsTable,
        where: 'aggregate_id = ?',
        whereArgs: [aggregateId],
      );

      if (results.isEmpty) {
        return const Right(null);
      }

      return Right(results.first);
    } catch (e) {
      return Left(CacheFailure('Failed to get snapshot: ${e.toString()}'));
    }
  }

  /// Clear all events (use with caution!)
  Future<void> clearAll() async {
    final db = _database;
    if (db != null) {
      await db.delete(_tableName);
      await db.delete(_snapshotsTable);
    }
  }

  /// Close the database
  Future<void> close() async {
    await _database?.close();
    _database = null;
  }
}
