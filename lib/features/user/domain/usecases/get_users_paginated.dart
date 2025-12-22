import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/pagination/pagination_params.dart';
import '../../../../core/pagination/paginated_response.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/user_entity.dart';
import '../repositories/user_repository.dart';

/// Use Case: Get paginated users
/// Supports fetching users page by page with optional force refresh
class GetUsersPaginated
    implements UseCase<PaginatedResponse<UserEntity>, GetUsersPaginatedParams> {
  final UserRepository repository;

  GetUsersPaginated(this.repository);

  @override
  Future<Either<Failure, PaginatedResponse<UserEntity>>> call(
    GetUsersPaginatedParams params,
  ) async {
    return await repository.getUsersPaginated(
      params: params.paginationParams,
      forceRefresh: params.forceRefresh,
    );
  }
}

/// Parameters for GetUsersPaginated use case
class GetUsersPaginatedParams extends Equatable {
  final PaginationParams paginationParams;
  final bool forceRefresh;

  const GetUsersPaginatedParams({
    required this.paginationParams,
    this.forceRefresh = false,
  });

  /// Create params for initial page
  const GetUsersPaginatedParams.initial()
      : paginationParams = const PaginationParams.initial(),
        forceRefresh = false;

  /// Create params for next page
  GetUsersPaginatedParams nextPage() {
    return GetUsersPaginatedParams(
      paginationParams: paginationParams.nextPage(),
      forceRefresh: forceRefresh,
    );
  }

  @override
  List<Object?> get props => [paginationParams, forceRefresh];
}
