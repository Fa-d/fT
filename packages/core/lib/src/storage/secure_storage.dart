import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:dartz/dartz.dart';
import '../error/failures.dart';

/// Secure storage wrapper for sensitive data
/// Uses platform-specific secure storage (Keychain on iOS, Keystore on Android)
class SecureStorage {
  final FlutterSecureStorage _storage;

  SecureStorage({FlutterSecureStorage? storage})
      : _storage = storage ??
            const FlutterSecureStorage(
              aOptions: AndroidOptions(
                encryptedSharedPreferences: true,
              ),
              iOptions: IOSOptions(
                accessibility: KeychainAccessibility.first_unlock,
              ),
            );

  /// Write a value securely
  Future<Either<Failure, Unit>> write(String key, String value) async {
    try {
      await _storage.write(key: key, value: value);
      return const Right(unit);
    } catch (e) {
      return Left(CacheFailure('Failed to write to secure storage: ${e.toString()}'));
    }
  }

  /// Read a value securely
  Future<Either<Failure, String?>> read(String key) async {
    try {
      final value = await _storage.read(key: key);
      return Right(value);
    } catch (e) {
      return Left(CacheFailure('Failed to read from secure storage: ${e.toString()}'));
    }
  }

  /// Delete a value
  Future<Either<Failure, Unit>> delete(String key) async {
    try {
      await _storage.delete(key: key);
      return const Right(unit);
    } catch (e) {
      return Left(CacheFailure('Failed to delete from secure storage: ${e.toString()}'));
    }
  }

  /// Delete all values
  Future<Either<Failure, Unit>> deleteAll() async {
    try {
      await _storage.deleteAll();
      return const Right(unit);
    } catch (e) {
      return Left(CacheFailure('Failed to clear secure storage: ${e.toString()}'));
    }
  }

  /// Check if a key exists
  Future<Either<Failure, bool>> containsKey(String key) async {
    try {
      final value = await _storage.containsKey(key: key);
      return Right(value);
    } catch (e) {
      return Left(CacheFailure('Failed to check key in secure storage: ${e.toString()}'));
    }
  }

  /// Read all values
  Future<Either<Failure, Map<String, String>>> readAll() async {
    try {
      final all = await _storage.readAll();
      return Right(all);
    } catch (e) {
      return Left(CacheFailure('Failed to read all from secure storage: ${e.toString()}'));
    }
  }
}
