// 🟡 This is the updated BLoC code using Isolate (`compute`) for image color extraction
import 'dart:io';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image/image.dart' as img;

import '../../../../core/resources/data_state.dart';
import '../../../../core/usecase/use_case.dart';
import '../../domain/entities/random_image_entity.dart';
import '../../domain/usecases/get_random_image_usecase.dart';

part 'random_image_bloc.freezed.dart';
part 'random_image_event.dart';
part 'random_image_state.dart';

typedef DominantColorLoader = Future<Color?> Function(String imageUrl);

class RandomImageBloc extends Bloc<RandomImageEvent, RandomImageState> {
  RandomImageBloc(
    this._getRandomImageUseCase, {
    DominantColorLoader? loadDominantColor,
  })  : _loadDominantColor =
            loadDominantColor ?? _defaultDominantColorLoader,
        super(const RandomImageState()) {
    on<_Started>(_onStarted);
    on<_RefreshRequested>(_onRefreshRequested);
  }

  final GetRandomImageUseCase _getRandomImageUseCase;
  final DominantColorLoader _loadDominantColor;

  Future<void> _onStarted(
      _Started event,
      Emitter<RandomImageState> emit,
      ) async {
    await _fetchImage(emit);
  }

  Future<void> _onRefreshRequested(
      _RefreshRequested event,
      Emitter<RandomImageState> emit,
      ) async {
    await _fetchImage(emit);
  }

  Future<void> _fetchImage(Emitter<RandomImageState> emit) async {
    emit(
      state.copyWith(
        status: RandomImageStatus.loading,
        errorMessage: null,
      ),
    );

    final result = await _getRandomImageUseCase(NoParams());

    if (result is DataSuccess<RandomImageEntity>) {
      final fetchedImage = result.data;

      if (fetchedImage == null || fetchedImage.url.isEmpty) {
        emit(
          state.copyWith(
            status: RandomImageStatus.failure,
            errorMessage: 'Image data is empty',
          ),
        );
        return;
      }

      // 🌈 Get dominant color using compute (Isolate)
      Color? dominantColor;
      try {
        dominantColor = await _loadDominantColor(fetchedImage.url);
      } catch (_) {
        dominantColor = null;
      }

      emit(
        state.copyWith(
          image: fetchedImage,
          backgroundColor: dominantColor,
          status: RandomImageStatus.success,
        ),
      );
    } else {
      emit(
        state.copyWith(
          status: RandomImageStatus.failure,
          errorMessage: result.error,
        ),
      );
    }
  }
}

Future<Color?> _defaultDominantColorLoader(String imageUrl) {
  return compute<String, Color?>(_getDominantColorFromUrl, imageUrl);
}

// 🧠 This function runs inside the Isolate
Future<Color?> _getDominantColorFromUrl(String imageUrl) async {
  final uri = Uri.tryParse(imageUrl);
  if (uri == null) {
    return null;
  }

  final client = HttpClient()..connectionTimeout = const Duration(seconds: 10);
  try {
    final request = await client.getUrl(uri);
    final response = await request.close();

    if (response.statusCode != HttpStatus.ok) {
      return null;
    }

    final bytes = await consolidateHttpClientResponseBytes(response);
    final decoded = img.decodeImage(bytes);
    if (decoded == null) {
      return null;
    }

    final resized = img.copyResize(
      decoded,
      width: 64,
      height: 64,
      interpolation: img.Interpolation.average,
    );

    final rgbBytes = resized.getBytes(order: img.ChannelOrder.rgb);
    if (rgbBytes.isEmpty) {
      return null;
    }

    int r = 0, g = 0, b = 0, pixelCount = 0;
    for (var i = 0; i < rgbBytes.length; i += 3) {
      r += rgbBytes[i];
      g += rgbBytes[i + 1];
      b += rgbBytes[i + 2];
      pixelCount++;
    }

    if (pixelCount == 0) {
      return null;
    }

    return Color.fromARGB(
      0xFF,
      (r / pixelCount).round(),
      (g / pixelCount).round(),
      (b / pixelCount).round(),
    );
  } on SocketException {
    return null;
  } on HttpException {
    return null;
  } on FormatException {
    return null;
  } finally {
    client.close(force: true);
  }
}
