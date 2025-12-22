import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/pagination/pagination_params.dart';
import '../../../../core/pagination/paginated_response.dart';
import '../entities/character_entity.dart';

/// Character Repository Interface
/// Defines contracts for character-related operations
abstract class CharacterRepository {
  /// Get paginated list of characters from Rick and Morty API
  Future<Either<Failure, PaginatedResponse<CharacterEntity>>> getCharactersPaginated({
    required PaginationParams params,
  });

  /// Get a single character by ID
  Future<Either<Failure, CharacterEntity>> getCharacterById(int id);
}
