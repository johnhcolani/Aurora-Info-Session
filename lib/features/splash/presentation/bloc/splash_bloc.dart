import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'splash_bloc.freezed.dart';
part 'splash_event.dart';
part 'splash_state.dart';

/// BLoC managing splash screen state, delaying for a specified duration before marking completion.
class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc({Duration? delay})
      : _delay = delay ?? const Duration(seconds: 2),
        super(const SplashState()) {
    on<_SplashStarted>(_onStarted);
  }

  final Duration _delay;

  /// Handles the splash started event, waits for the delay duration, then marks splash as completed.
  Future<void> _onStarted(
    _SplashStarted event,
    Emitter<SplashState> emit,
  ) async {
    emit(state.copyWith(status: SplashStatus.loading));
    await Future<void>.delayed(_delay);
    emit(state.copyWith(status: SplashStatus.completed));
  }
}

