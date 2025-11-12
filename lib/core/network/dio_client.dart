import 'package:dio/dio.dart';

import '../constants/constants.dart';

/// Configures the shared Dio HTTP client with base options and logging.
///
/// The `LogInterceptor` outputs full request/response details, which helps
/// diagnose API issues during development. Consider guarding or adjusting it
/// for production builds if verbose logging is undesirable.
class DioClient {
  DioClient()
      : _dio = Dio(
          BaseOptions(
            baseUrl: AppConstants.baseUrl,
            connectTimeout: const Duration(seconds: 10),
            receiveTimeout: const Duration(seconds: 10),
          ),
        )..interceptors.add(
            LogInterceptor(
              requestBody: true,
              responseBody: true,
            ),
          );

  final Dio _dio;

  /// Expose the configured Dio instance for dependency injection.
  Dio get dio => _dio;
}

