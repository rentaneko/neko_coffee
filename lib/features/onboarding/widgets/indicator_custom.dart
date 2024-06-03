import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/common/paint/background.paint.dart';
import '../../../core/theme/app_pallete.dart';
import '../../../core/utils/utils_common.dart';

Widget indicator(int pageIndex) {
  return Row(
    children: [
      Container(
        height: 4.w,
        width: 12.w,
        color: pageIndex == 0 ? AppPallete.coffeeBean : AppPallete.white,
      ),
      addHorizontalSpace(8.w),
      Container(
        height: 4.w,
        width: 12.w,
        color: pageIndex == 1 ? AppPallete.coffeeBean : AppPallete.white,
      ),
      addHorizontalSpace(8.w),
      Container(
        height: 4.w,
        width: 12.w,
        color: pageIndex == 2 ? AppPallete.coffeeBean : AppPallete.white,
      ),
    ],
  );
}

Widget backgroundBody({required String imgUrl, required Widget child}) {
  return Container(
    decoration: BoxDecoration(
      image: DecorationImage(image: AssetImage(imgUrl), fit: BoxFit.cover),
    ),
    child: CustomPaint(painter: BackgroundPainter(), child: child),
  );
}
