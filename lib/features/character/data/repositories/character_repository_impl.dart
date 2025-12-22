import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/pagination/pagination_params.dart';
import '../../../../core/pagination/paginated_response.dart';
import '../../domain/entities/character_entity.dart';
import '../../domain/repositories/character_repository.dart';
import '../datasources/character_remote_datasource.dart';

/// Implementation of CharacterRepository
class CharacterRepositoryImpl implements CharacterRepository {
  final CharacterRemoteDataSource remoteDataSource;

  CharacterRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, PaginatedResponse<CharacterEntity>>> getCharactersPaginated({
    required PaginationParams params,
  }) async {
    try {
      final paginatedResponse = await remoteDataSource.getCharactersPaginated(params);
      return Right(paginatedResponse);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Unexpected error: $e'));
    }
  }

  @override
  Future<Either<Failure, CharacterEntity>> getCharacterById(int id) async {
    try {
      final character = await remoteDataSource.getCharacterById(id);
      return Right(character);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Unexpected error: $e'));
    }
  }
}
