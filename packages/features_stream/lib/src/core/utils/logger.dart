import 'dart:developer' as developer;

/// Simple logger utility for the stream feature
/// Provides structured logging for debugging and monitoring
class Logger {
  Logger._();

  static const String _tag = 'StreamFeature';

  /// Log debug message
  static void debug(String message, [Object? error, StackTrace? stackTrace]) {
    developer.log(
      message,
      name: _tag,
      level: 500, // DEBUG
      error: error,
      stackTrace: stackTrace,
    );
  }

  /// Log info message
  static void info(String message, [Object? error, StackTrace? stackTrace]) {
    developer.log(
      message,
      name: _tag,
      level: 800, // INFO
      error: error,
      stackTrace: stackTrace,
    );
  }

  /// Log warning message
  static void warning(String message, [Object? error, StackTrace? stackTrace]) {
    developer.log(
      message,
      name: _tag,
      level: 900, // WARNING
      error: error,
      stackTrace: stackTrace,
    );
  }

  /// Log error message
  static void error(String message, [Object? error, StackTrace? stackTrace]) {
    developer.log(
      message,
      name: _tag,
      level: 1000, // ERROR
      error: error,
      stackTrace: stackTrace,
    );
  }

  /// Log severe/critical message
  static void severe(String message, [Object? error, StackTrace? stackTrace]) {
    developer.log(
      message,
      name: _tag,
      level: 1200, // SHOUT
      error: error,
      stackTrace: stackTrace,
    );
  }
}
