import 'package:flutter/material.dart';
import 'package:neko_coffee/core/theme/app_pallete.dart';
import 'package:neko_coffee/core/theme/app_style.dart';

OutlineInputBorder borderEnable() => OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(color: AppPallete.border, width: 1),
    );

OutlineInputBorder borderFocus() => OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(color: AppPallete.brand, width: 1),
    );

OutlineInputBorder borderError() => OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(color: AppPallete.error, width: 1),
    );

// static elevateTheme() => ElevatedButton
InputDecorationTheme _inputDecoration() => InputDecorationTheme(
      enabledBorder: borderEnable(),
      errorBorder: borderError(),
      focusedBorder: borderFocus(),
      contentPadding: const EdgeInsets.all(16),
    );

ThemeData darkThemeMode = ThemeData.dark().copyWith(
  scaffoldBackgroundColor: AppPallete.backgroundColor,
  inputDecorationTheme: _inputDecoration(),
  appBarTheme: const AppBarTheme(backgroundColor: AppPallete.backgroundColor),
);

ThemeData lightThemeMode = ThemeData().copyWith(
  scaffoldBackgroundColor: AppPallete.sky50,
  inputDecorationTheme: _inputDecoration(),
  appBarTheme: const AppBarTheme(backgroundColor: AppPallete.sky500),
  primaryColorLight: AppPallete.brand,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
        if (states.contains(MaterialState.disabled)) {
          return AppPallete.disable;
        }
        if (states.contains(MaterialState.hovered)) {
          return AppPallete.brand600;
        }

        if (states.contains(MaterialState.pressed)) {
          return AppPallete.brand200;
        }

        return AppPallete.brand;
      }),
      fixedSize: MaterialStateProperty.all<Size>(const Size(395, 55)),
      textStyle: MaterialStateProperty.all<TextStyle>(
        mediumOswald(size: 14, color: AppPallete.light),
      ),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    ),
  ),
);
