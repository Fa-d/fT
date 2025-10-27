import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:dartz/dartz.dart';
import '../error/failures.dart';

/// Advanced cache manager using Hive
/// Provides TTL (Time To Live) based caching with automatic expiration
class CacheManager {
  static const String _cacheBoxName = 'app_cache';
  Box<CacheEntry>? _cacheBox;

  /// Initialize the cache manager
  Future<void> initialize() async {
    await Hive.initFlutter();

    if (!Hive.isAdapterRegistered(CacheEntryAdapter().typeId)) {
      Hive.registerAdapter(CacheEntryAdapter());
    }

    _cacheBox = await Hive.openBox<CacheEntry>(_cacheBoxName);
  }

  /// Cache a value with optional TTL (Time To Live)
  Future<Either<Failure, Unit>> cache<T>(
    String key,
    T value, {
    Duration? ttl,
  }) async {
    try {
      final box = _cacheBox;
      if (box == null) {
        return Left(CacheFailure('Cache not initialized'));
      }

      final entry = CacheEntry(
        value: json.encode(value),
        cachedAt: DateTime.now(),
        expiresAt: ttl != null ? DateTime.now().add(ttl) : null,
      );

      await box.put(key, entry);
      return const Right(unit);
    } catch (e) {
      return Left(CacheFailure('Failed to cache value: ${e.toString()}'));
    }
  }

  /// Get a cached value
  Future<Either<Failure, T?>> get<T>(
    String key,
    T Function(Map<String, dynamic>) fromJson,
  ) async {
    try {
      final box = _cacheBox;
      if (box == null) {
        return Left(CacheFailure('Cache not initialized'));
      }

      final entry = box.get(key);
      if (entry == null) {
        return const Right(null);
      }

      // Check if expired
      if (entry.expiresAt != null && DateTime.now().isAfter(entry.expiresAt!)) {
        await box.delete(key);
        return const Right(null);
      }

      final decoded = json.decode(entry.value) as Map<String, dynamic>;
      return Right(fromJson(decoded));
    } catch (e) {
      return Left(CacheFailure('Failed to get cached value: ${e.toString()}'));
    }
  }

  /// Get a cached value as JSON
  Future<Either<Failure, Map<String, dynamic>?>> getJson(String key) async {
    try {
      final box = _cacheBox;
      if (box == null) {
        return Left(CacheFailure('Cache not initialized'));
      }

      final entry = box.get(key);
      if (entry == null) {
        return const Right(null);
      }

      // Check if expired
      if (entry.expiresAt != null && DateTime.now().isAfter(entry.expiresAt!)) {
        await box.delete(key);
        return const Right(null);
      }

      return Right(json.decode(entry.value) as Map<String, dynamic>);
    } catch (e) {
      return Left(CacheFailure('Failed to get cached JSON: ${e.toString()}'));
    }
  }

  /// Remove a cached value
  Future<Either<Failure, Unit>> remove(String key) async {
    try {
      final box = _cacheBox;
      if (box == null) {
        return Left(CacheFailure('Cache not initialized'));
      }

      await box.delete(key);
      return const Right(unit);
    } catch (e) {
      return Left(CacheFailure('Failed to remove cached value: ${e.toString()}'));
    }
  }

  /// Clear all cache
  Future<Either<Failure, Unit>> clear() async {
    try {
      final box = _cacheBox;
      if (box == null) {
        return Left(CacheFailure('Cache not initialized'));
      }

      await box.clear();
      return const Right(unit);
    } catch (e) {
      return Left(CacheFailure('Failed to clear cache: ${e.toString()}'));
    }
  }

  /// Remove expired entries
  Future<Either<Failure, int>> cleanExpired() async {
    try {
      final box = _cacheBox;
      if (box == null) {
        return Left(CacheFailure('Cache not initialized'));
      }

      final now = DateTime.now();
      final keysToDelete = <String>[];

      for (final key in box.keys) {
        final entry = box.get(key);
        if (entry?.expiresAt != null && now.isAfter(entry!.expiresAt!)) {
          keysToDelete.add(key as String);
        }
      }

      await box.deleteAll(keysToDelete);
      return Right(keysToDelete.length);
    } catch (e) {
      return Left(CacheFailure('Failed to clean expired cache: ${e.toString()}'));
    }
  }

  /// Close the cache
  Future<void> close() async {
    await _cacheBox?.close();
    _cacheBox = null;
  }
}

/// Cache entry model
class CacheEntry {
  final String value;
  final DateTime cachedAt;
  final DateTime? expiresAt;

  CacheEntry({
    required this.value,
    required this.cachedAt,
    this.expiresAt,
  });
}

/// Hive adapter for CacheEntry
class CacheEntryAdapter extends TypeAdapter<CacheEntry> {
  @override
  final typeId = 0;

  @override
  CacheEntry read(BinaryReader reader) {
    return CacheEntry(
      value: reader.readString(),
      cachedAt: DateTime.fromMillisecondsSinceEpoch(reader.readInt()),
      expiresAt: reader.readBool() ? DateTime.fromMillisecondsSinceEpoch(reader.readInt()) : null,
    );
  }

  @override
  void write(BinaryWriter writer, CacheEntry obj) {
    writer.writeString(obj.value);
    writer.writeInt(obj.cachedAt.millisecondsSinceEpoch);
    writer.writeBool(obj.expiresAt != null);
    if (obj.expiresAt != null) {
      writer.writeInt(obj.expiresAt!.millisecondsSinceEpoch);
    }
  }
}
