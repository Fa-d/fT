part of 'counter_bloc.dart';

/// Base class for Counter States
/// States represent the UI state at any given time
abstract class CounterState {
  const CounterState();
}

/// Initial state before any action
class CounterInitial extends CounterState {}

/// State while loading
class CounterLoading extends CounterState {}

/// State when counter is successfully loaded
class CounterLoaded extends CounterState {
  final dynamic counter;

  const CounterLoaded({required this.counter});
}

/// State when an error occurs
class CounterError extends CounterState {
  final String message;

  const CounterError({required this.message});
}
