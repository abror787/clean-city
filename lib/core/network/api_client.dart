import 'dart:developer' as developer;
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../constants/api_constants.dart';
import 'auth_interceptor.dart';

class ApiClient {
  final AuthInterceptor authInterceptor;

  ApiClient({required this.authInterceptor});

  Dio get dio {
    final dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    dio.interceptors.addAll([
      authInterceptor,
      // Custom logging interceptor for detailed API logs
      _ApiLoggerInterceptor(),
      // Pretty logger for console output (only in debug mode)
      if (kDebugMode)
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseHeader: false,
          responseBody: true,
          error: true,
          compact: false,
          maxWidth: 120,
        ),
    ]);

    return dio;
  }
}

/// Custom API Logger for detailed request/response logging
class _ApiLoggerInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final timestamp = DateTime.now().toIso8601String();
    developer.log(
      '📤 REQUEST [$timestamp]\n'
      '   Method: ${options.method}\n'
      '   URL: ${options.baseUrl}${options.path}\n'
      '   Headers: ${options.headers}\n'
      '   Data: ${options.data}\n'
      '   QueryParams: ${options.queryParameters}',
      name: 'API',
    );
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final timestamp = DateTime.now().toIso8601String();
    developer.log(
      '📥 RESPONSE [$timestamp]\n'
      '   Status: ${response.statusCode} ${response.statusMessage}\n'
      '   URL: ${response.requestOptions.baseUrl}${response.requestOptions.path}\n'
      '   Data: ${response.data}',
      name: 'API',
    );
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final timestamp = DateTime.now().toIso8601String();
    developer.log(
      '❌ ERROR [$timestamp]\n'
      '   Status: ${err.response?.statusCode}\n'
      '   URL: ${err.requestOptions.baseUrl}${err.requestOptions.path}\n'
      '   Message: ${err.message}\n'
      '   Response: ${err.response?.data}',
      name: 'API',
      error: err,
    );
    super.onError(err, handler);
  }
}
