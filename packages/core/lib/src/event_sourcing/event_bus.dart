import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'domain_event.dart';

/// Event Bus for publishing and subscribing to domain events
/// Implements publish-subscribe pattern for event-driven architecture
class EventBus {
  static final EventBus _instance = EventBus._internal();
  factory EventBus() => _instance;
  EventBus._internal();

  final _eventController = PublishSubject<DomainEvent>();

  /// Stream of all events
  Stream<DomainEvent> get events => _eventController.stream;

  /// Publish an event to all subscribers
  void publish(DomainEvent event) {
    _eventController.add(event);
  }

  /// Subscribe to events of a specific type
  Stream<T> on<T extends DomainEvent>() {
    return _eventController.stream.whereType<T>();
  }

  /// Subscribe to events matching a predicate
  Stream<DomainEvent> where(bool Function(DomainEvent event) test) {
    return _eventController.stream.where(test);
  }

  /// Dispose the event bus
  void dispose() {
    _eventController.close();
  }
}
