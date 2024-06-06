import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:neko_coffee/core/theme/app_pallete.dart';
import '../../../../core/common/cubit/app_user_cubit.dart';
import '../../../blog/presentation/page/blog.screen.dart';
import 'login.screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPallete.light,
      body: AnimatedSplashScreen(
        splash: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo-horizontal.png',
              height: 70.w,
            ),
            Lottie.asset(
              'assets/animation/splash_animation.json',
              repeat: true,
              height: 100.w,
            ),
          ],
        ),
        splashIconSize: 250,
        duration: 3000,
        nextScreen: BlocSelector<AppUserCubit, AppUserState, bool>(
          selector: (state) {
            return state is AppUserLoggedIn;
          },
          builder: (context, isLoggedIn) {
            if (isLoggedIn) {
              return const BlogScreen();
            } else {
              return const LoginScreen();
            }
          },
        ),
      ),
    );
  }
}
