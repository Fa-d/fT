import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../network/network_info.dart';

part 'connectivity_event.dart';
part 'connectivity_state.dart';

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