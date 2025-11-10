import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:palette_generator/palette_generator.dart';

import '../../../../core/resources/data_state.dart';
import '../../../../core/usecase/use_case.dart';
import '../../domain/entities/random_image_entity.dart';
import '../../domain/usecases/get_random_image_usecase.dart';

part 'random_image_bloc.freezed.dart';
part 'random_image_event.dart';
part 'random_image_state.dart';

class RandomImageBloc extends Bloc<RandomImageEvent, RandomImageState> {
  RandomImageBloc(this._getRandomImageUseCase)
      : super(const RandomImageState()) {
    on<_Started>(_onStarted);
    on<_RefreshRequested>(_onRefreshRequested);
  }

  final GetRandomImageUseCase _getRandomImageUseCase;

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
      final image = result.data;

      if (image == null || image.url.isEmpty) {
        emit(
          state.copyWith(
            status: RandomImageStatus.failure,
            errorMessage: 'No image received from the server.',
          ),
        );
        return;
      }

      final backgroundColor = await _resolveDominantColor(image.url);

      emit(
        state.copyWith(
          status: RandomImageStatus.success,
          image: image,
          backgroundColor: backgroundColor,
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        status: RandomImageStatus.failure,
        errorMessage: result.error ?? 'Failed to load image.',
      ),
    );
  }

  Future<Color> _resolveDominantColor(String url) async {
    try {
      final palette = await PaletteGenerator.fromImageProvider(
        NetworkImage(url),
        maximumColorCount: 16,
      );
      final dominant = palette.dominantColor?.color;
      if (dominant == null) {
        return const Color(0xFF111111);
      }
      return _adjustForContrast(dominant);
    } catch (_) {
      return const Color(0xFF111111);
    }
  }

  Color _adjustForContrast(Color color) {
    final luminance = color.computeLuminance();
    if (luminance < 0.1) {
      return Color.lerp(color, Colors.white, 0.15) ?? color;
    }
    if (luminance > 0.8) {
      return Color.lerp(color, Colors.black, 0.2) ?? color;
    }
    return color;
  }
}

