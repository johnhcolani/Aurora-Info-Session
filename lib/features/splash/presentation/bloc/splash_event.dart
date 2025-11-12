part of 'splash_bloc.dart';

/// Events for the splash bloc.
@freezed
class SplashEvent with _$SplashEvent {
  /// Event to start the splash screen delay sequence.
  const factory SplashEvent.started() = _SplashStarted;
}

