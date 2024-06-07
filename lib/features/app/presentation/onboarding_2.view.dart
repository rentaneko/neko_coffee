import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neko_coffee/features/app/widgets/indicator_custom.dart';
import '../../../core/theme/app_pallete.dart';
import '../../../core/theme/app_style.dart';
import '../../../core/utils/utils_common.dart';

class OnboardingSecondScreen extends StatelessWidget {
  const OnboardingSecondScreen({super.key});

  static route() =>
      MaterialPageRoute(builder: (_) => const OnboardingSecondScreen());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: backgroundBody(
        imgUrl: 'assets/images/background-2.png',
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              'Quickly and easly',
              style: boldOswald(size: 20, color: AppPallete.light),
              textAlign: TextAlign.center,
            ),
            addVerticalSpace(8.w),
            Text(
              'You can place your order quickly and easly without wasting time. You can also schedule orders via your smarthphone.',
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
                      'Previous',
                      style: mediumOswald(size: 16, color: AppPallete.brand),
                    ),
                  ),
                  indicator(1),
                  ElevatedButton(
                    onPressed: () =>
                        Navigator.of(context).pushNamed('/onboarding-3'),
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
