import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neko_coffee/core/theme/app_style.dart';
import 'package:neko_coffee/core/utils/utils_common.dart';
import 'package:neko_coffee/features/onboarding/widgets/indicator_custom.dart';
import '../../../core/theme/app_pallete.dart';

class OnboardingFirstScreen extends StatelessWidget {
  static route() =>
      MaterialPageRoute(builder: (_) => const OnboardingFirstScreen());

  const OnboardingFirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: backgroundBody(
        imgUrl: 'assets/images/background-1.png',
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Choose and customize your Drinks',
              style: boldOswald(size: 20, color: AppPallete.light),
            ),
            addVerticalSpace(8.w),
            Text(
              'Customize your own drink exactly how you like it by adding any topping you like!!!',
              style: mediumOswald(size: 16, color: AppPallete.light),
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
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(100.w, 32.w),
                      backgroundColor: AppPallete.light,
                    ),
                    child: Text(
                      'Skip',
                      style: mediumOswald(size: 16, color: AppPallete.brand),
                    ),
                  ),
                  indicator(0),
                  ElevatedButton(
                    onPressed: () =>
                        Navigator.of(context).pushNamed('/onboarding-2'),
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(100.w, 32.w),
                      backgroundColor: AppPallete.light,
                    ),
                    child: Text(
                      'Next',
                      style: mediumOswald(size: 16, color: AppPallete.brand),
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
