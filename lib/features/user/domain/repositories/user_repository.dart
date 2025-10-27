import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/user_entity.dart';

/// User Repository Interface
/// Defines contracts for user-related operations
abstract class UserRepository {
  /// Get list of all users from remote API
  Future<Either<Failure, List<UserEntity>>> getUsers();

  /// Get a single user by ID
  Future<Either<Failure, UserEntity>> getUserById(int id);
}
