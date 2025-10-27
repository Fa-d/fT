import 'domain_event.dart';

/// Base class for aggregate roots in event sourcing
/// Aggregates are consistency boundaries that encapsulate business rules
abstract class AggregateRoot<T> {
  /// Unique identifier for this aggregate
  final String id;

  /// Current version number for optimistic concurrency control
  int version;

  /// Uncommitted events that need to be persisted
  final List<DomainEvent> _uncommittedEvents = [];

  AggregateRoot({
    required this.id,
    this.version = 0,
  });

  /// Get uncommitted events
  List<DomainEvent> get uncommittedEvents => List.unmodifiable(_uncommittedEvents);

  /// Mark all events as committed
  void markEventsAsCommitted() {
    _uncommittedEvents.clear();
  }

  /// Apply an event and add it to uncommitted events
  /// This method is called when creating new events
  void applyChange(DomainEvent event) {
    // Apply the event to update internal state
    applyEvent(event);

    // Add to uncommitted events
    _uncommittedEvents.add(event);

    // Increment version
    version++;
  }

  /// Load aggregate from historical events
  /// This reconstructs the aggregate state from event history
  void loadFromHistory(List<DomainEvent> history) {
    for (final event in history) {
      applyEvent(event);
      version = event.aggregateVersion;
    }
  }

  /// Apply an event to update internal state
  /// Must be implemented by concrete aggregate classes
  /// This should contain the business logic for state transitions
  void applyEvent(DomainEvent event);

  /// Get the current state of the aggregate
  /// Must be implemented to return the current state representation
  T getState();
}

/// Mixin for aggregates that support snapshots
mixin Snapshotable<T> on AggregateRoot<T> {
  /// Create a snapshot of the current state
  Map<String, dynamic> createSnapshot();

  /// Restore state from a snapshot
  void restoreFromSnapshot(Map<String, dynamic> snapshot);

  /// Determine if a snapshot should be created
  /// Override to implement custom snapshot strategy
  /// Default: Create snapshot every 10 events
  bool shouldCreateSnapshot() {
    return version % 10 == 0;
  }
}
