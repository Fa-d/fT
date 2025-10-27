import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'dashboard_event.dart';
import 'dashboard_state.dart';
import '../../domain/usecases/get_system_stats.dart';
import 'package:core/core.dart';

/// Dashboard BLoC demonstrating advanced patterns:
/// - Event transformers for debouncing and throttling
/// - Stream transformation with RxDart
/// - Proper error handling
/// - Loading states
class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final GetSystemStats _getSystemStats;

  DashboardBloc({
    required GetSystemStats getSystemStats,
  })  : _getSystemStats = getSystemStats,
        super(const DashboardState.initial()) {
    on<DashboardEvent>(
      _onEvent,
      // Apply debouncing to refresh events
      transformer: (events, mapper) {
        return events
            .debounceTime(const Duration(milliseconds: 500))
            .switchMap(mapper);
      },
    );
  }

  Future<void> _onEvent(
    DashboardEvent event,
    Emitter<DashboardState> emit,
  ) async {
    await event.when(
      started: () => _onStarted(emit),
      refreshRequested: () => _onRefreshRequested(emit),
      syncRequested: () => _onSyncRequested(emit),
    );
  }

  Future<void> _onStarted(Emitter<DashboardState> emit) async {
    emit(const DashboardState.loading());

    final result = await _getSystemStats(NoParams());

    result.fold(
      (failure) => emit(DashboardState.error(failure.message)),
      (stats) => emit(DashboardState.loaded(stats)),
    );
  }

  Future<void> _onRefreshRequested(Emitter<DashboardState> emit) async {
    final result = await _getSystemStats(NoParams());

    result.fold(
      (failure) => emit(DashboardState.error(failure.message)),
      (stats) => emit(DashboardState.loaded(stats)),
    );
  }

  Future<void> _onSyncRequested(Emitter<DashboardState> emit) async {
    // Trigger background sync
    // This would use the SyncManager from core
    // For now, just reload stats
    final result = await _getSystemStats(NoParams());

    result.fold(
      (failure) => emit(DashboardState.error(failure.message)),
      (stats) => emit(DashboardState.loaded(stats)),
    );
  }
}
