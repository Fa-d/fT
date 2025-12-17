part of 'connectivity_bloc.dart';

/// Base connectivity event
abstract class ConnectivityEvent {
  @override
  bool operator ==(Object other) => false;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// Event to manually check connectivity status
class ConnectivityCheck extends ConnectivityEvent {}

/// Event when connectivity status changes
class ConnectivityChanged extends ConnectivityEvent {
  final bool isConnected;

  ConnectivityChanged(this.isConnected);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ConnectivityChanged &&
          runtimeType == other.runtimeType &&
          isConnected == other.isConnected;

  @override
  int get hashCode => isConnected.hashCode;
}