import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:neko_coffee/common/widgets/buttons/basic_app_button.dart';
import 'package:neko_coffee/common/widgets/buttons/choose_mode_button.dart';
import 'package:neko_coffee/presentation/choose_mode/bloc/theme_cubit.dart';

import '../../../core/configs/assets/app_svg.dart';
import '../../../core/configs/assets/app_images.dart';
import '../../auth/pages/signup_or_signin.screen.dart';

class ChooseModeScreen extends StatelessWidget {
  const ChooseModeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage(AppImages.chooseModeBg),
              ),
            ),
            child: Column(
              children: [
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.topCenter,
                  child: SvgPicture.asset(AppSvg.logo),
                ),
                const Spacer(),
                const Text(
                  'Choose Mode',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ChooseModeButton(
                      svgUrl: AppSvg.moon,
                      title: 'Dark Mode',
                      onTap: () {
                        context.read<ThemeCubit>().updateTheme(ThemeMode.dark);
                      },
                    ),
                    SizedBox(width: 20.w),
                    ChooseModeButton(
                      svgUrl: AppSvg.sun,
                      title: 'Light Mode',
                      onTap: () {
                        context.read<ThemeCubit>().updateTheme(ThemeMode.light);
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                BasicAppButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => const SignupOrSigninScreen()));
                    },
                    title: 'Continue',
                    height: 55),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
