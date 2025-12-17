part of 'connectivity_bloc.dart';

/// Base connectivity state
abstract class ConnectivityState {
  @override
  bool operator ==(Object other) => false;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// Initial state before any connectivity check
class ConnectivityInitial extends ConnectivityState {}

/// Device is connected to internet
class ConnectivityOnline extends ConnectivityState {}

/// Device is offline (no internet connection)
class ConnectivityOffline extends ConnectivityState {}