import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../utils/logger.dart';
import 'certificate_pinning.dart';

/// Advanced API client with interceptors and certificate pinning
class ApiClient {
  final Dio _dio;
  final AppLogger _logger = AppLogger();

  ApiClient({
    required Dio dio,
    String? baseUrl,
    bool enableCertificatePinning = false,
    Map<String, String>? pinnedCertificates,
  }) : _dio = dio {
    _dio.options = BaseOptions(
      baseUrl: baseUrl ?? 'https://api.example.com',
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );

    // Add interceptors
    _dio.interceptors.add(LogInterceptor(
      request: kDebugMode,
      requestBody: kDebugMode,
      requestHeader: kDebugMode,
      responseBody: kDebugMode,
      responseHeader: kDebugMode,
      error: true,
      logPrint: (obj) => _logger.debug(obj.toString()),
    ));

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: _onRequest,
        onResponse: _onResponse,
        onError: _onError,
      ),
    );

    // Add certificate pinning if enabled
    if (enableCertificatePinning && pinnedCertificates != null) {
      _dio.httpClientAdapter = CertificatePinningAdapter(
        pinnedCertificates: pinnedCertificates,
      );
    }
  }

  void _onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    _logger.info('Request: ${options.method} ${options.uri}');
    // Add auth token if available
    // This would typically come from a token manager
    // options.headers['Authorization'] = 'Bearer $token';
    handler.next(options);
  }

  void _onResponse(Response response, ResponseInterceptorHandler handler) {
    _logger.info('Response: ${response.statusCode} ${response.requestOptions.uri}');
    handler.next(response);
  }

  void _onError(DioException error, ErrorInterceptorHandler handler) {
    _logger.error('Error: ${error.message}', error);
    handler.next(error);
  }

  /// Perform GET request
  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    return _dio.get<T>(
      path,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
  }

  /// Perform POST request
  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    return _dio.post<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
  }

  /// Perform PUT request
  Future<Response<T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    return _dio.put<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
  }

  /// Perform PATCH request
  Future<Response<T>> patch<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    return _dio.patch<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
  }

  /// Perform DELETE request
  Future<Response<T>> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    return _dio.delete<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
  }

  /// Download file
  Future<Response> download(
    String urlPath,
    String savePath, {
    ProgressCallback? onReceiveProgress,
    CancelToken? cancelToken,
  }) async {
    return _dio.download(
      urlPath,
      savePath,
      onReceiveProgress: onReceiveProgress,
      cancelToken: cancelToken,
    );
  }

  /// Upload file
  Future<Response<T>> upload<T>(
    String path,
    FormData formData, {
    ProgressCallback? onSendProgress,
    CancelToken? cancelToken,
  }) async {
    return _dio.post<T>(
      path,
      data: formData,
      onSendProgress: onSendProgress,
      cancelToken: cancelToken,
    );
  }
}
