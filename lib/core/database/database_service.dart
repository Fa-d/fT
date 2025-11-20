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

  /// Initialize the Isar database
  ///
  /// Should be called once during app startup before accessing the database.
  /// Returns the initialized Isar instance.
  static Future<Isar> initialize() async {
    if (_isar != null && _isar!.isOpen) {
      return _isar!;
    }

    final dir = await getApplicationDocumentsDirectory();

    _isar = await Isar.open(
      [
        UserCacheModelSchema,
      ],
      directory: dir.path,
      inspector: true, // Enable Isar Inspector in debug mode
    );

    return _isar!;
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
    await _isar?.close();
    _isar = null;
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
