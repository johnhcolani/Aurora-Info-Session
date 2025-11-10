part of 'random_image_bloc.dart';

enum RandomImageStatus { initial, loading, success, failure }

@freezed
class RandomImageState with _$RandomImageState {
  const factory RandomImageState({
    @Default(RandomImageStatus.initial) RandomImageStatus status,
    RandomImageEntity? image,
    Color? backgroundColor,
    String? errorMessage,
  }) = _RandomImageState;

  const RandomImageState._();

  bool get isLoading => status == RandomImageStatus.loading;
  bool get isSuccess => status == RandomImageStatus.success;
  bool get isFailure => status == RandomImageStatus.failure;
}

