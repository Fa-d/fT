import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart' as log_pkg;

/// Application logger wrapper
/// Provides centralized logging with different levels
class AppLogger {
  static final AppLogger _instance = AppLogger._internal();
  factory AppLogger() => _instance;

  late final log_pkg.Logger _logger;

  AppLogger._internal() {
    _logger = log_pkg.Logger(
      printer: log_pkg.PrettyPrinter(
        methodCount: 2,
        errorMethodCount: 8,
        lineLength: 120,
        colors: true,
        printEmojis: true,
        dateTimeFormat: log_pkg.DateTimeFormat.onlyTimeAndSinceStart,
      ),
      level: kDebugMode ? log_pkg.Level.debug : log_pkg.Level.info,
    );
  }

  void debug(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.d(message, error: error, stackTrace: stackTrace);
  }

  void info(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.i(message, error: error, stackTrace: stackTrace);
  }

  void warning(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.w(message, error: error, stackTrace: stackTrace);
  }

  void error(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.e(message, error: error, stackTrace: stackTrace);
  }

  void fatal(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.f(message, error: error, stackTrace: stackTrace);
  }
}
