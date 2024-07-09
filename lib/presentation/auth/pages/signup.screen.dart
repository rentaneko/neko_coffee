import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:neko_coffee/common/helpers/is_dark_mode.dart';
import 'package:neko_coffee/common/widgets/app_bar/app_bar.dart';
import 'package:neko_coffee/common/widgets/buttons/basic_app_button.dart';
import 'package:neko_coffee/core/configs/assets/app_svg.dart';
import 'package:neko_coffee/core/configs/theme/app_colors.dart';
import 'package:neko_coffee/presentation/auth/pages/signin.screen.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(title: SvgPicture.asset(AppSvg.logo)),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: _navigateToSignIn(context),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 30.w),
        child: Column(
          children: [
            _registerHeader(),
            SizedBox(height: 30.w),
            _fullnameField(context),
            SizedBox(height: 20.w),
            _emailField(context),
            SizedBox(height: 20.w),
            _passwordField(context),
            SizedBox(height: 20.w),
            BasicAppButton(
              onPressed: () {},
              title: 'Create Account',
              height: 55,
            ),
          ],
        ),
      ),
    );
  }

  Widget _registerHeader() {
    return const Text(
      'Register',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 25,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _fullnameField(BuildContext context) {
    return TextFormField(
      decoration: const InputDecoration(hintText: 'Full Name')
          .applyDefaults(Theme.of(context).inputDecorationTheme),
    );
  }

  Widget _emailField(BuildContext context) {
    return TextFormField(
      decoration: const InputDecoration(hintText: 'Enter Email')
          .applyDefaults(Theme.of(context).inputDecorationTheme),
    );
  }

  Widget _passwordField(BuildContext context) {
    return TextFormField(
      decoration: const InputDecoration(
        hintText: 'Enter Password',
      ).applyDefaults(Theme.of(context).inputDecorationTheme),
    );
  }

  Widget _navigateToSignIn(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Do you have an account? ',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 14,
            color: context.isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const SigninScreen()),
          ),
          child: const Text(
            'Sign In',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: AppColors.blue,
            ),
          ),
        ),
      ],
    );
  }
}
