import 'package:connectivity_plus/connectivity_plus.dart';

/// Abstract interface for network information
abstract class NetworkInfo {
  /// Check if device is connected to the internet
  Future<bool> get isConnected;

  /// Stream of connectivity changes
  Stream<bool> get connectivityStream;
}

/// Implementation using connectivity_plus package
class NetworkInfoImpl implements NetworkInfo {
  final Connectivity connectivity;

  NetworkInfoImpl(this.connectivity);

  @override
  Future<bool> get isConnected async {
    final result = await connectivity.checkConnectivity();
    return _isConnectedResult(result);
  }

  @override
  Stream<bool> get connectivityStream {
    return connectivity.onConnectivityChanged.map(_isConnectedResult);
  }

  /// Helper method to determine if connectivity result means connected
  bool _isConnectedResult(ConnectivityResult result) {
    // Device is connected if result is not 'none'
    return result != ConnectivityResult.none;
  }
}
