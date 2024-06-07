import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:neko_coffee/core/theme/app_pallete.dart';

regularOswald(
        {Color? color, required double size, TextDecoration? textDecoration}) =>
    GoogleFonts.oswald(
      fontWeight: FontWeight.w400,
      color: color ?? AppPallete.dark,
      fontSize: size,
      decoration: textDecoration ?? TextDecoration.none,
    );

boldOswald({Color? color, required double size}) => GoogleFonts.oswald(
      fontWeight: FontWeight.w700,
      color: color ?? AppPallete.dark,
      fontSize: size,
    );

lightOswald({Color? color, required double size}) => GoogleFonts.oswald(
      fontWeight: FontWeight.w300,
      color: color ?? AppPallete.dark,
      fontSize: size,
    );

exlightOswald({Color? color, required double size}) => GoogleFonts.oswald(
      fontWeight: FontWeight.w200,
      color: color ?? AppPallete.dark,
      fontSize: size,
    );

mediumOswald({Color? color, required double size}) => GoogleFonts.oswald(
      fontWeight: FontWeight.w500,
      color: color ?? AppPallete.dark,
      fontSize: size,
    );
