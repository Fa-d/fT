import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

/// Base class for all domain events in the system
/// Implements event sourcing pattern where all state changes are captured as events
abstract class DomainEvent extends Equatable {
  /// Unique identifier for this event
  final String eventId;

  /// Type of the event (used for deserialization)
  final String eventType;

  /// ID of the aggregate this event belongs to
  final String aggregateId;

  /// Version number for optimistic concurrency control
  final int aggregateVersion;

  /// Timestamp when the event occurred
  final DateTime timestamp;

  /// User or system that triggered this event
  final String? causedBy;

  /// Additional metadata for the event
  final Map<String, dynamic>? metadata;

  DomainEvent({
    String? eventId,
    required this.eventType,
    required this.aggregateId,
    required this.aggregateVersion,
    DateTime? timestamp,
    this.causedBy,
    this.metadata,
  })  : eventId = eventId ?? const Uuid().v4(),
        timestamp = timestamp ?? DateTime.now();

  /// Convert event to JSON for persistence
  Map<String, dynamic> toJson();

  /// Create event from JSON
  /// Must be implemented by concrete event types
  static DomainEvent fromJson(Map<String, dynamic> json) {
    throw UnimplementedError('fromJson must be implemented by concrete event types');
  }

  @override
  List<Object?> get props => [
        eventId,
        eventType,
        aggregateId,
        aggregateVersion,
        timestamp,
        causedBy,
        metadata,
      ];
}

/// Mixin for events that can be replayed to reconstruct state
mixin ReplayableEvent on DomainEvent {
  /// Apply this event to reconstruct state
  /// Returns the new state after applying the event
  dynamic applyTo(dynamic currentState);
}
