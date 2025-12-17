import 'package:flutter/foundation.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

// Import all Isar collection models here
import '../../features/user/data/models/user_cache_model.dart';

/// Database service for managing Isar database
///
/// This service provides centralized access to the Isar database instance
/// and handles initialization and lifecycle management.
class DatabaseService {
  static Isar? _isar;
  static String? _dbPath;
  static bool _isInitializing = false;

  /// Initialize the Isar database
  ///
  /// Should be called once during app startup before accessing the database.
  /// Returns the initialized Isar instance.
  /// Safe to call multiple times - will return existing instance if already initialized.
  static Future<Isar> initialize() async {
    // If we have an existing instance, verify it's valid
    if (_isar != null) {
      try {
        // Try to access the instance to verify it's valid
        if (_isar!.isOpen) {
          debugPrint('📦 Database already initialized and open');
          return _isar!;
        }
      } catch (e) {
        debugPrint('⚠️ Existing database instance invalid: $e');
        // Instance is invalid, clean up
        _isar = null;
      }
    }

    // Prevent concurrent initialization
    if (_isInitializing) {
      debugPrint('⏳ Database initialization already in progress, waiting...');
      // Wait for the other initialization to complete
      while (_isInitializing) {
        await Future.delayed(const Duration(milliseconds: 100));
      }
      if (_isar != null && _isar!.isOpen) {
        return _isar!;
      }
    }

    _isInitializing = true;

    try {
      debugPrint('🔧 Initializing database...');

      // Get the database directory
      final dir = await getApplicationDocumentsDirectory();
      _dbPath = dir.path;

      debugPrint('📁 Database path: $_dbPath');

      // Open a fresh instance
      // Isar will handle reopening an existing database file correctly
      _isar = await Isar.open(
        [
          UserCacheModelSchema,
        ],
        directory: _dbPath!,
        inspector: true, // Enable Isar Inspector in debug mode
      );

      debugPrint('✅ Database initialized successfully');
      return _isar!;
    } catch (e, stackTrace) {
      debugPrint('❌ Database initialization failed: $e');
      debugPrint('Stack trace: $stackTrace');
      _isar = null;
      rethrow;
    } finally {
      _isInitializing = false;
    }
  }

  /// Get the database instance
  ///
  /// Throws an exception if the database hasn't been initialized yet.
  static Isar get instance {
    if (_isar == null || !_isar!.isOpen) {
      throw Exception(
        'Database not initialized. Call DatabaseService.initialize() first.',
      );
    }
    return _isar!;
  }

  /// Close the database
  ///
  /// Should be called when the app is shutting down.
  static Future<void> close() async {
    if (_isar != null && _isar!.isOpen) {
      await _isar!.close(deleteFromDisk: false);
      _isar = null;
    }
  }

  /// Clear all data from the database
  ///
  /// Useful for testing or logout scenarios.
  static Future<void> clearAll() async {
    if (_isar != null && _isar!.isOpen) {
      await _isar!.writeTxn(() async {
        await _isar!.clear();
      });
    }
  }
}
