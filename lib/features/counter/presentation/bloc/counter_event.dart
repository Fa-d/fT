part of 'counter_bloc.dart';

/// Base class for Counter Events
/// Events represent user actions or triggers
abstract class CounterEvent {
  const CounterEvent();
}

/// Event: Load the counter value
class LoadCounterEvent extends CounterEvent {}

/// Event: Increment the counter
class IncrementCounterEvent extends CounterEvent {}

/// Event: Decrement the counter
class DecrementCounterEvent extends CounterEvent {}

/// Event: Reset the counter to zero
class ResetCounterEvent extends CounterEvent {}
