import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/constants/constants.dart';

/// Abstract interface for fetching random images from a remote API.
abstract class RandomImageRemoteDataSource {
  Future<RemoteImagePayload> getRandomImage();
}

/// Implementation that fetches random images using Dio client, running the network call in an isolate via compute.
class RandomImageRemoteDataSourceImpl implements RandomImageRemoteDataSource {
  RandomImageRemoteDataSourceImpl(this._client);

  final Dio _client;

  @override
  Future<RemoteImagePayload> getRandomImage() async {
    final options = _client.options;
    final result = await compute<Map<String, dynamic>, Map<String, dynamic>>(
      _fetchRandomImage,
      <String, dynamic>{
        'baseUrl': options.baseUrl.isEmpty
            ? AppConstants.baseUrl
            : options.baseUrl,
        'path': AppConstants.randomImagePath,
        'connectTimeout': options.connectTimeout?.inMilliseconds,
        'receiveTimeout': options.receiveTimeout?.inMilliseconds,
        'headers': options.headers,
      },
    );
    return RemoteImagePayload.fromMap(result);
  }
}

/// Data class representing the response payload from the random image API.
class RemoteImagePayload {
  const RemoteImagePayload({
    required this.data,
    required this.statusCode,
    required this.statusMessage,
    required this.errorMessage,
  });

  final Map<String, dynamic>? data;
  final int? statusCode;
  final String? statusMessage;
  final String? errorMessage;

  factory RemoteImagePayload.fromMap(Map<String, dynamic> map) {
    return RemoteImagePayload(
      data: map['data'] as Map<String, dynamic>?,
      statusCode: map['statusCode'] as int?,
      statusMessage: map['statusMessage'] as String?,
      errorMessage: map['error'] as String?,
    );
  }
}

/// Fetches random image data in an isolate to avoid blocking the main thread.
/// This function is designed to be used with Flutter's compute() for background execution.
Future<Map<String, dynamic>> _fetchRandomImage(
  Map<String, dynamic> config,
) async {
  final dio = Dio(
    BaseOptions(
      baseUrl: config['baseUrl'] as String,
      connectTimeout: _durationFromMillis(config['connectTimeout']),
      receiveTimeout: _durationFromMillis(config['receiveTimeout']),
      headers: (config['headers'] as Map?)?.cast<String, dynamic>(),
    ),
  );

  try {
    final response = await dio.get<Map<String, dynamic>>(
      config['path'] as String,
    );

    return <String, dynamic>{
      'data': response.data,
      'statusCode': response.statusCode,
      'statusMessage': response.statusMessage,
    };
  } on DioException catch (error) {
    return <String, dynamic>{
      'error': error.message ?? 'Network error fetching image metadata.',
    };
  } catch (error) {
    return <String, dynamic>{
      'error': error.toString(),
    };
  }
}

Duration? _durationFromMillis(Object? value) {
  if (value is int) {
    return Duration(milliseconds: value);
  }
  return null;
}

