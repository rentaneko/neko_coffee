import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:neko_coffee/common/helpers/is_dark_mode.dart';
import 'package:neko_coffee/common/widgets/app_bar/app_bar.dart';
import 'package:neko_coffee/common/widgets/buttons/basic_app_button.dart';
import 'package:neko_coffee/core/configs/assets/app_svg.dart';
import 'package:neko_coffee/core/configs/theme/app_colors.dart';
import 'package:neko_coffee/presentation/auth/pages/signin.screen.dart';
import 'package:neko_coffee/presentation/auth/pages/signup.screen.dart';

import '../../../core/configs/assets/app_images.dart';

class SignupOrSigninScreen extends StatelessWidget {
  const SignupOrSigninScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const BasicAppBar(),
          _buildBg(
            alignment: Alignment.topRight,
            child: SvgPicture.asset(AppSvg.topPattern),
          ),
          _buildBg(
            alignment: Alignment.bottomRight,
            child: SvgPicture.asset(AppSvg.bottomPattern),
          ),
          _buildBg(
            alignment: Alignment.bottomLeft,
            child: Image.asset(AppImages.authBg),
          ),
          _buildBodyColumn(context),
        ],
      ),
    );
  }

  Widget _buildBodyColumn(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(AppSvg.logo),
            SizedBox(height: 20.w),
            Text(
              'Enjoy Listen To Music',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: context.isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            SizedBox(height: 20.w),
            const Text(
              'Spotify is a proprietary Swedish audio streaming and media services provider ',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 13,
                color: AppColors.grey,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.w),
            _signUpOrSignin(context),
          ],
        ),
      ),
    );
  }

  Widget _buildBg({required Alignment alignment, required Widget child}) {
    return Align(
      alignment: alignment,
      child: child,
    );
  }

  Widget _signUpOrSignin(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: BasicAppButton(
            onPressed: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => const SignUpScreen())),
            title: 'Register',
            height: 55,
          ),
        ),
        SizedBox(width: 20.w),
        Expanded(
          flex: 1,
          child: TextButton(
            onPressed: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => const SigninScreen())),
            child: Text(
              'Sign in',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: context.isDarkMode ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
