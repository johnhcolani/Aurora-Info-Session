part of 'splash_bloc.dart';

enum SplashStatus { initial, loading, completed }

@freezed
class SplashState with _$SplashState {
  const factory SplashState({
    @Default(SplashStatus.initial) SplashStatus status,
  }) = _SplashState;

  const SplashState._();

  bool get isCompleted => status == SplashStatus.completed;
}

