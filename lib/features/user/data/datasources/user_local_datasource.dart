import 'package:isar/isar.dart';
import '../../../../core/error/exceptions.dart';
import '../models/user_cache_model.dart';
import '../models/user_model.dart';

/// Contract for User Local Data Source
abstract class UserLocalDataSource {
  /// Get all cached users
  Future<List<UserModel>> getCachedUsers();

  /// Cache a list of users
  Future<void> cacheUsers(List<UserModel> users);

  /// Get a single cached user by ID
  Future<UserModel?> getCachedUserById(int id);

  /// Check if cache is stale (older than specified duration)
  Future<bool> isCacheStale(Duration maxAge);

  /// Clear all cached users
  Future<void> clearCache();
}

/// Implementation using Isar database
class UserLocalDataSourceImpl implements UserLocalDataSource {
  final Isar isar;

  UserLocalDataSourceImpl({required this.isar});

  @override
  Future<List<UserModel>> getCachedUsers() async {
    try {
      final cachedUsers = await isar.userCacheModels.where().findAll();

      if (cachedUsers.isEmpty) {
        throw CacheException('No cached users found');
      }

      // Convert cache models to user models
      return cachedUsers.map((cached) {
        final entity = cached.toEntity();
        return UserModel.fromEntity(entity);
      }).toList();
    } catch (e) {
      if (e is CacheException) rethrow;
      throw CacheException('Failed to get cached users: $e');
    }
  }

  @override
  Future<void> cacheUsers(List<UserModel> users) async {
    try {
      final cacheModels = users.map((user) {
        return UserCacheModel.fromUserModel(user);
      }).toList();

      await isar.writeTxn(() async {
        // Clear old data and insert new
        await isar.userCacheModels.clear();
        await isar.userCacheModels.putAll(cacheModels);
      });
    } catch (e) {
      throw CacheException('Failed to cache users: $e');
    }
  }

  @override
  Future<UserModel?> getCachedUserById(int id) async {
    try {
      final cached = await isar.userCacheModels
          .filter()
          .userIdEqualTo(id)
          .findFirst();

      if (cached == null) return null;

      final entity = cached.toEntity();
      return UserModel.fromEntity(entity);
    } catch (e) {
      throw CacheException('Failed to get cached user: $e');
    }
  }

  @override
  Future<bool> isCacheStale(Duration maxAge) async {
    try {
      final users = await isar.userCacheModels.where().findAll();

      if (users.isEmpty) return true;

      // Check the most recent cache timestamp
      final mostRecent = users
          .map((u) => u.cachedAt)
          .reduce((a, b) => a.isAfter(b) ? a : b);

      final age = DateTime.now().difference(mostRecent);
      return age > maxAge;
    } catch (e) {
      // If error, consider cache stale
      return true;
    }
  }

  @override
  Future<void> clearCache() async {
    try {
      await isar.writeTxn(() async {
        await isar.userCacheModels.clear();
      });
    } catch (e) {
      throw CacheException('Failed to clear cache: $e');
    }
  }
}
