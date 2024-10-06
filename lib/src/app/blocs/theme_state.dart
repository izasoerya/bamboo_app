import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class ThemeEvent {}

class ToggleThemeEvent extends ThemeEvent {}

class ThemeState {
  final ThemeMode themeMode;

  ThemeState({required this.themeMode});
}

class ThemeStateBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeStateBloc() : super(ThemeState(themeMode: ThemeMode.system)) {
    on<ToggleThemeEvent>((event, emit) {
      emit(ThemeState(
        themeMode: state.themeMode == ThemeMode.light
            ? ThemeMode.dark
            : ThemeMode.light,
      ));
    });
  }
}
