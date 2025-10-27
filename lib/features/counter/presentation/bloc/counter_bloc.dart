import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/usecases/decrement_counter.dart';
import '../../domain/usecases/get_counter.dart';
import '../../domain/usecases/increment_counter.dart';
import '../../domain/usecases/reset_counter.dart';
import 'counter_event.dart';
import 'counter_state.dart';

/// BLoC: Business Logic Component
/// Handles business logic and state management
/// Takes Events as input and emits States as output
class CounterBloc extends Bloc<CounterEvent, CounterState> {
  final GetCounter getCounter;
  final IncrementCounter incrementCounter;
  final DecrementCounter decrementCounter;
  final ResetCounter resetCounter;

  CounterBloc({
    required this.getCounter,
    required this.incrementCounter,
    required this.decrementCounter,
    required this.resetCounter,
  }) : super(CounterInitial()) {
    // Register event handlers
    on<LoadCounterEvent>(_onLoadCounter);
    on<IncrementCounterEvent>(_onIncrementCounter);
    on<DecrementCounterEvent>(_onDecrementCounter);
    on<ResetCounterEvent>(_onResetCounter);
  }

  /// Handle LoadCounterEvent
  Future<void> _onLoadCounter(
    LoadCounterEvent event,
    Emitter<CounterState> emit,
  ) async {
    emit(CounterLoading());

    final result = await getCounter(NoParams());

    result.fold(
      (failure) => emit(CounterError(message: failure.message)),
      (counter) => emit(CounterLoaded(counter: counter)),
    );
  }

  /// Handle IncrementCounterEvent
  Future<void> _onIncrementCounter(
    IncrementCounterEvent event,
    Emitter<CounterState> emit,
  ) async {
    emit(CounterLoading());

    final result = await incrementCounter(NoParams());

    result.fold(
      (failure) => emit(CounterError(message: failure.message)),
      (counter) => emit(CounterLoaded(counter: counter)),
    );
  }

  /// Handle DecrementCounterEvent
  Future<void> _onDecrementCounter(
    DecrementCounterEvent event,
    Emitter<CounterState> emit,
  ) async {
    emit(CounterLoading());

    final result = await decrementCounter(NoParams());

    result.fold(
      (failure) => emit(CounterError(message: failure.message)),
      (counter) => emit(CounterLoaded(counter: counter)),
    );
  }

  /// Handle ResetCounterEvent
  Future<void> _onResetCounter(
    ResetCounterEvent event,
    Emitter<CounterState> emit,
  ) async {
    emit(CounterLoading());

    final result = await resetCounter(NoParams());

    result.fold(
      (failure) => emit(CounterError(message: failure.message)),
      (counter) => emit(CounterLoaded(counter: counter)),
    );
  }
}
