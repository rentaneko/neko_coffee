import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neko_coffee/features/onboarding/widgets/indicator_custom.dart';
import '../../../core/theme/app_pallete.dart';
import '../../../core/theme/app_style.dart';
import '../../../core/utils/utils_common.dart';

class OnboardingThirdScreen extends StatelessWidget {
  const OnboardingThirdScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: backgroundBody(
        imgUrl: 'assets/images/background-3.png',
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              'Get and Redeem Voucher',
              style: boldOswald(size: 20, color: AppPallete.white),
              textAlign: TextAlign.center,
            ),
            addVerticalSpace(8.w),
            Text(
              'Exciting prizes await you! Redeem yours by collecting all the points after purchase in the app!',
              style: mediumOswald(size: 16, color: AppPallete.white),
              textAlign: TextAlign.center,
            ),
            addVerticalSpace(16.w),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: ElevatedButton.styleFrom(),
                    child: Text(
                      'Previous',
                      style: mediumOswald(size: 16, color: AppPallete.bean),
                    ),
                  ),
                  indicator(2),
                  ElevatedButton(
                    onPressed: () => Navigator.of(context)
                        .pushNamedAndRemoveUntil('/login', (route) => false),
                    style: ElevatedButton.styleFrom(),
                    child: Text(
                      'Login/Register',
                      style: mediumOswald(size: 16, color: AppPallete.bean),
                    ),
                  ),
                ],
              ),
            ),
            addVerticalSpace(12.w),
          ],
        ),
      ),
    );
  }
}
