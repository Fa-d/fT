import 'package:dio/dio.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/pagination/pagination_params.dart';
import '../../../../core/pagination/paginated_response.dart';
import '../../../../core/utils/constants.dart';
import '../models/user_model.dart';

/// Contract for User Remote Data Source
abstract class UserRemoteDataSource {
  /// Fetch users from the API (non-paginated - legacy)
  Future<List<UserModel>> getUsers();

  /// Fetch paginated users from the API
  Future<PaginatedResponse<UserModel>> getUsersPaginated(
    PaginationParams params,
  );

  /// Fetch a single user by ID
  Future<UserModel> getUserById(int id);
}

/// Implementation using ApiClient (Dio)
class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final ApiClient apiClient;

  UserRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<List<UserModel>> getUsers() async {
    try {
      final response = await apiClient.get(AppConstants.usersEndpoint);

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = response.data as List<dynamic>;
        return jsonList
            .map((json) => UserModel.fromJson(json as Map<String, dynamic>))
            .toList();
      } else {
        throw ServerException('Failed to fetch users: ${response.statusCode}');
      }
    } on DioException catch (e) {
      // Handle different types of Dio exceptions
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
          // Check if it's actually a network issue
          if (e.error != null && e.error.toString().contains('SocketException')) {
            throw NetworkException('No internet connection available');
          }
          throw ServerException('Error: ${e.message ?? "Unknown error"}');
      }
    } catch (e) {
      // Don't catch our own exceptions
      if (e is NetworkException || e is ServerException) {
        rethrow;
      }
      throw ServerException('Unexpected error: $e');
    }
  }

  @override
  Future<PaginatedResponse<UserModel>> getUsersPaginated(
    PaginationParams params,
  ) async {
    try {
      final response = await apiClient.get(
        AppConstants.usersEndpoint,
        queryParameters: params.toQueryParams(),
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = response.data as List<dynamic>;
        final users = jsonList
            .map((json) => UserModel.fromJson(json as Map<String, dynamic>))
            .toList();

        // JSONPlaceholder has 10 total users, so we can calculate total from headers
        // In a real API, this would come from response headers like X-Total-Count
        final totalCountHeader = response.headers.value('x-total-count');
        final totalCount = totalCountHeader != null
            ? int.tryParse(totalCountHeader) ?? users.length
            : null;

        return PaginatedResponse.fromData(
          data: users,
          currentPage: params.page,
          requestedLimit: params.limit,
          totalItems: totalCount,
        );
      } else {
        throw ServerException('Failed to fetch users: ${response.statusCode}');
      }
    } on DioException catch (e) {
      // Handle different types of Dio exceptions
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
          // Check if it's actually a network issue
          if (e.error != null && e.error.toString().contains('SocketException')) {
            throw NetworkException('No internet connection available');
          }
          throw ServerException('Error: ${e.message ?? "Unknown error"}');
      }
    } catch (e) {
      // Don't catch our own exceptions
      if (e is NetworkException || e is ServerException) {
        rethrow;
      }
      throw ServerException('Unexpected error: $e');
    }
  }

  @override
  Future<UserModel> getUserById(int id) async {
    try {
      final response = await apiClient.get('${AppConstants.usersEndpoint}/$id');

      if (response.statusCode == 200) {
        return UserModel.fromJson(response.data as Map<String, dynamic>);
      } else {
        throw ServerException('Failed to fetch user: ${response.statusCode}');
      }
    } on DioException catch (e) {
      // Handle different types of Dio exceptions
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
          // Check if it's actually a network issue
          if (e.error != null && e.error.toString().contains('SocketException')) {
            throw NetworkException('No internet connection available');
          }
          throw ServerException('Error: ${e.message ?? "Unknown error"}');
      }
    } catch (e) {
      // Don't catch our own exceptions
      if (e is NetworkException || e is ServerException) {
        rethrow;
      }
      throw ServerException('Unexpected error: $e');
    }
  }
}
