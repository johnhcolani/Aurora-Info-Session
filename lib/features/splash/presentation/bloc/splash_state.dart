part of 'splash_bloc.dart';

/// Status enum representing the different states of the splash screen.
enum SplashStatus { initial, loading, completed }

/// State class for the splash bloc, tracking the splash screen status.
@freezed
class SplashState with _$SplashState {
  const factory SplashState({
    @Default(SplashStatus.initial) SplashStatus status,
  }) = _SplashState;

  const SplashState._();

  /// Convenience getter to check if the splash screen has completed its delay sequence.
  bool get isCompleted => status == SplashStatus.completed;
}

