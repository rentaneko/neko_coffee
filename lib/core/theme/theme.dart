import 'package:flutter/material.dart';
import 'package:neko_coffee/core/theme/app_pallete.dart';

class AppTheme {
  static _border([Color color = AppPallete.white]) => OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: color, width: 3),
      );

  static final _inputDecoration = InputDecorationTheme(
    enabledBorder: _border(),
    errorBorder: _border(AppPallete.error),
    focusedBorder: _border(AppPallete.transparent),
    contentPadding: const EdgeInsets.all(16),
  );

  static final darkThemeMode = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: AppPallete.backgroundColor,
    inputDecorationTheme: _inputDecoration,
    appBarTheme: const AppBarTheme(backgroundColor: AppPallete.backgroundColor),
  );

  static final lightThemeMode = ThemeData().copyWith(
    scaffoldBackgroundColor: AppPallete.sky50,
    inputDecorationTheme: _inputDecoration,
    appBarTheme: const AppBarTheme(backgroundColor: AppPallete.sky500),
    primaryColorLight: AppPallete.coffee,
  );
}
