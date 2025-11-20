import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/user_entity.dart';

/// User Repository Interface
/// Defines contracts for user-related operations
abstract class UserRepository {
  /// Get list of all users
  ///
  /// [forceRefresh]: If true, bypass cache and fetch from network
  /// Returns cached data if available, otherwise fetches from network
  Future<Either<Failure, List<UserEntity>>> getUsers({
    bool forceRefresh = false,
  });

  /// Get a single user by ID
  /// Returns cached data if available, otherwise fetches from network
  Future<Either<Failure, UserEntity>> getUserById(int id);
}
