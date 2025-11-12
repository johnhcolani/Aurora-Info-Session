import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'theme_state.dart';

/// Cubit managing app theme state, allowing toggling between light and dark modes.
class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(const ThemeState());

  /// Toggles between light and dark theme modes.
  void toggleTheme() {
    final current = state.themeMode;
    if (current == ThemeMode.dark) {
      emit(state.copyWith(themeMode: ThemeMode.light));
    } else {
      emit(state.copyWith(themeMode: ThemeMode.dark));
    }
  }

  /// Sets the theme mode to the specified value.
  void setTheme(ThemeMode mode) {
    emit(state.copyWith(themeMode: mode));
  }
}

