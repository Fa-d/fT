import 'package:dio/dio.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/pagination/pagination_params.dart';
import '../../../../core/pagination/paginated_response.dart';
import '../../../../core/utils/constants.dart';
import '../models/character_model.dart';

/// Contract for Character Remote Data Source
abstract class CharacterRemoteDataSource {
  /// Fetch paginated characters from Rick and Morty API
  Future<PaginatedResponse<CharacterModel>> getCharactersPaginated(
    PaginationParams params,
  );

  /// Fetch a single character by ID
  Future<CharacterModel> getCharacterById(int id);
}

/// Implementation using Dio directly (Rick and Morty API uses different base URL)
class CharacterRemoteDataSourceImpl implements CharacterRemoteDataSource {
  final Dio dio;

  CharacterRemoteDataSourceImpl({required this.dio});

  @override
  Future<PaginatedResponse<CharacterModel>> getCharactersPaginated(
    PaginationParams params,
  ) async {
    try {
      // Rick and Morty API uses ?page= parameter (not _page)
      final response = await dio.get(
        '${AppConstants.rickAndMortyBaseUrl}${AppConstants.charactersEndpoint}',
        queryParameters: {
          'page': params.page,
        },
      );

      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;

        // Extract pagination info
        final info = data['info'] as Map<String, dynamic>;
        final results = data['results'] as List<dynamic>;

        final characters = results
            .map((json) => CharacterModel.fromJson(json as Map<String, dynamic>))
            .toList();

        // Rick and Morty API provides total count and pages in info object
        return PaginatedResponse(
          data: characters,
          currentPage: params.page,
          totalItems: info['count'] as int,
          hasMore: info['next'] != null, // Has more if next URL exists
        );
      } else {
        throw ServerException('Failed to fetch characters: ${response.statusCode}');
      }
    } on DioException catch (e) {
      switch (e.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          throw NetworkException('Connection timeout. Please try again.');
        case DioExceptionType.badResponse:
          throw ServerException(
            'Server error: ${e.response?.statusCode ?? "Unknown"}',
          );
        case DioExceptionType.cancel:
          throw ServerException('Request cancelled');
        case DioExceptionType.connectionError:
          throw NetworkException(
            'Network error. Please check your internet connection.',
          );
        case DioExceptionType.badCertificate:
          throw NetworkException('SSL certificate error');
        case DioExceptionType.unknown:
          if (e.error != null && e.error.toString().contains('SocketException')) {
            throw NetworkException('No internet connection available');
          }
          throw ServerException('Error: ${e.message ?? "Unknown error"}');
      }
    } catch (e) {
      if (e is NetworkException || e is ServerException) {
        rethrow;
      }
      throw ServerException('Unexpected error: $e');
    }
  }

  @override
  Future<CharacterModel> getCharacterById(int id) async {
    try {
      final response = await dio.get(
        '${AppConstants.rickAndMortyBaseUrl}${AppConstants.charactersEndpoint}/$id',
      );

      if (response.statusCode == 200) {
        return CharacterModel.fromJson(response.data as Map<String, dynamic>);
      } else {
        throw ServerException('Failed to fetch character: ${response.statusCode}');
      }
    } on DioException catch (e) {
      switch (e.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          throw NetworkException('Connection timeout. Please try again.');
        case DioExceptionType.badResponse:
          throw ServerException(
            'Server error: ${e.response?.statusCode ?? "Unknown"}',
          );
        case DioExceptionType.cancel:
          throw ServerException('Request cancelled');
        case DioExceptionType.connectionError:
          throw NetworkException(
            'Network error. Please check your internet connection.',
          );
        case DioExceptionType.badCertificate:
          throw NetworkException('SSL certificate error');
        case DioExceptionType.unknown:
          if (e.error != null && e.error.toString().contains('SocketException')) {
            throw NetworkException('No internet connection available');
          }
          throw ServerException('Error: ${e.message ?? "Unknown error"}');
      }
    } catch (e) {
      if (e is NetworkException || e is ServerException) {
        rethrow;
      }
      throw ServerException('Unexpected error: $e');
    }
  }
}
