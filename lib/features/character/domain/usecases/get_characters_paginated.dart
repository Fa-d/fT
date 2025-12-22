import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/pagination/pagination_params.dart';
import '../../../../core/pagination/paginated_response.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/character_entity.dart';
import '../repositories/character_repository.dart';

/// Use Case: Get paginated characters from Rick and Morty API
class GetCharactersPaginated
    implements
        UseCase<PaginatedResponse<CharacterEntity>,
            GetCharactersPaginatedParams> {
  final CharacterRepository repository;

  GetCharactersPaginated(this.repository);

  @override
  Future<Either<Failure, PaginatedResponse<CharacterEntity>>> call(
    GetCharactersPaginatedParams params,
  ) async {
    return await repository.getCharactersPaginated(
      params: params.paginationParams,
    );
  }
}

/// Parameters for GetCharactersPaginated use case
class GetCharactersPaginatedParams extends Equatable {
  final PaginationParams paginationParams;

  const GetCharactersPaginatedParams({
    required this.paginationParams,
  });

  /// Create params for initial page (20 items per page - Rick and Morty API default)
  const GetCharactersPaginatedParams.initial()
      : paginationParams = const PaginationParams(page: 1, limit: 20);

  /// Create params for next page
  GetCharactersPaginatedParams nextPage() {
    return GetCharactersPaginatedParams(
      paginationParams: paginationParams.nextPage(),
    );
  }

  @override
  List<Object?> get props => [paginationParams];
}
