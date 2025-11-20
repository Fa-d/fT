import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/user_entity.dart';
import '../repositories/user_repository.dart';

/// Use Case: Get all users
/// Supports offline-first with optional force refresh
class GetUsers implements UseCase<List<UserEntity>, GetUsersParams> {
  final UserRepository repository;

  GetUsers(this.repository);

  @override
  Future<Either<Failure, List<UserEntity>>> call(GetUsersParams params) async {
    return await repository.getUsers(forceRefresh: params.forceRefresh);
  }
}

/// Parameters for GetUsers use case
class GetUsersParams extends Equatable {
  final bool forceRefresh;

  const GetUsersParams({this.forceRefresh = false});

  @override
  List<Object?> get props => [forceRefresh];
}
