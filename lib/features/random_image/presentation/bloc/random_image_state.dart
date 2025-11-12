part of 'random_image_bloc.dart';

/// Status enum representing the different states of random image loading.
enum RandomImageStatus { initial, loading, success, failure }

/// State class for the random image bloc, holding the current image, background color, bookmark status, and error messages.
@freezed
class RandomImageState with _$RandomImageState {
  const factory RandomImageState({
    @Default(RandomImageStatus.initial) RandomImageStatus status,
    RandomImageEntity? image,
    Color? backgroundColor,
    String? errorMessage,
    @Default(false) bool isBookmarked,
  }) = _RandomImageState;

  const RandomImageState._();

  /// Convenience getter to check if the image is currently loading.
  bool get isLoading => status == RandomImageStatus.loading;
  
  /// Convenience getter to check if the image was successfully loaded.
  bool get isSuccess => status == RandomImageStatus.success;
  
  /// Convenience getter to check if image loading failed.
  bool get isFailure => status == RandomImageStatus.failure;
}

