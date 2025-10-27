import 'package:equatable/equatable.dart';
import '../../domain/entities/counter_entity.dart';

/// Base class for Counter States
/// States represent the UI state at any given time
abstract class CounterState extends Equatable {
  const CounterState();

  @override
  List<Object?> get props => [];
}

/// Initial state before any action
class CounterInitial extends CounterState {}

/// State while loading
class CounterLoading extends CounterState {}

/// State when counter is successfully loaded
class CounterLoaded extends CounterState {
  final CounterEntity counter;

  const CounterLoaded({required this.counter});

  @override
  List<Object?> get props => [counter];
}

/// State when an error occurs
class CounterError extends CounterState {
  final String message;

  const CounterError({required this.message});

  @override
  List<Object?> get props => [message];
}
