import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../network/network_info.dart';

// ==================== Events ====================

/// Base connectivity event
abstract class ConnectivityEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

/// Event to manually check connectivity status
class ConnectivityCheck extends ConnectivityEvent {}

/// Event when connectivity status changes
class ConnectivityChanged extends ConnectivityEvent {
  final bool isConnected;

  ConnectivityChanged(this.isConnected);

  @override
  List<Object?> get props => [isConnected];
}

// ==================== States ====================

/// Base connectivity state
abstract class ConnectivityState extends Equatable {
  @override
  List<Object?> get props => [];
}

/// Initial state before any connectivity check
class ConnectivityInitial extends ConnectivityState {}

/// Device is connected to internet
class ConnectivityOnline extends ConnectivityState {}

/// Device is offline (no internet connection)
class ConnectivityOffline extends ConnectivityState {}

// ==================== BLoC ====================

/// BLoC for monitoring network connectivity
///
/// Automatically monitors connectivity changes and emits states.
/// Can be used app-wide to show offline indicators or disable features.
class ConnectivityBloc extends Bloc<ConnectivityEvent, ConnectivityState> {
  final NetworkInfo networkInfo;
  StreamSubscription<bool>? _connectivitySubscription;

  ConnectivityBloc({required this.networkInfo})
      : super(ConnectivityInitial()) {
    on<ConnectivityCheck>(_onConnectivityCheck);
    on<ConnectivityChanged>(_onConnectivityChanged);

    // Listen to connectivity changes
    _connectivitySubscription =
        networkInfo.connectivityStream.listen((isConnected) {
      add(ConnectivityChanged(isConnected));
    });

    // Initial check
    add(ConnectivityCheck());
  }

  /// Handle manual connectivity check
  Future<void> _onConnectivityCheck(
    ConnectivityCheck event,
    Emitter<ConnectivityState> emit,
  ) async {
    final isConnected = await networkInfo.isConnected;
    emit(isConnected ? ConnectivityOnline() : ConnectivityOffline());
  }

  /// Handle connectivity status change
  void _onConnectivityChanged(
    ConnectivityChanged event,
    Emitter<ConnectivityState> emit,
  ) {
    emit(event.isConnected ? ConnectivityOnline() : ConnectivityOffline());
  }

  @override
  Future<void> close() {
    _connectivitySubscription?.cancel();
    return super.close();
  }
}
