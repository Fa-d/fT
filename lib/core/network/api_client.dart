import 'package:dio/dio.dart';

/// API Client wrapper around Dio
/// This provides a centralized place to configure network calls
class ApiClient {
  final Dio dio;

  ApiClient({required this.dio}) {
    _configureDio();
  }

  void _configureDio() {
    dio.options = BaseOptions(
      baseUrl: 'https://jsonplaceholder.typicode.com', // Example API
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );

    // Add interceptors for logging
    dio.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        error: true,
        request: true,
      ),
    );
  }

  /// GET request
  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    return await dio.get(path, queryParameters: queryParameters);
  }

  /// POST request
  Future<Response> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    return await dio.post(
      path,
      data: data,
      queryParameters: queryParameters,
    );
  }

  /// PUT request
  Future<Response> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    return await dio.put(
      path,
      data: data,
      queryParameters: queryParameters,
    );
  }

  /// DELETE request
  Future<Response> delete(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    return await dio.delete(path, queryParameters: queryParameters);
  }
}
