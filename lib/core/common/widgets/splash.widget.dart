import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../theme/app_pallete.dart';

class SplashWidget extends StatelessWidget {
  const SplashWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/icons/coffee.png',
            height: 140.h,
            width: 160.w,
          ),
          SizedBox(height: 10.h),
          DefaultTextStyle(
            style: GoogleFonts.lato(
              color: AppPallete.coffee,
              fontWeight: FontWeight.w700,
              fontSize: 24,
            ),
            child: AnimatedTextKit(
              repeatForever: true,
              animatedTexts: [
                WavyAnimatedText('Coffee Time'),
              ],
              isRepeatingAnimation: true,
              onTap: null,
            ),
          )
        ],
      ),
    );
  }
}
