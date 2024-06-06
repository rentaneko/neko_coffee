import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../theme/app_pallete.dart';
import '../../utils/utils_common.dart';

class PlaceholderScreen extends StatefulWidget {
  const PlaceholderScreen({super.key});

  @override
  State<PlaceholderScreen> createState() => _PlaceholderScreenState();
}

class _PlaceholderScreenState extends State<PlaceholderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPallete.light,
      body: Shimmer.fromColors(
        baseColor: AppPallete.border,
        highlightColor: AppPallete.light,
        child: body(),
      ),
    );
  }

  Widget body() {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      physics: const NeverScrollableScrollPhysics(),
      children: [
        addVerticalSpace(20.w),
        Row(
          children: [
            placeholderWidget(
              width: MediaQuery.of(context).size.width * 4.5 / 6,
              height: 44.w,
            ),
            addHorizontalSpace(12.w),
            placeholderWidget(width: 35.w, height: 35.w),
          ],
        ),
        addVerticalSpace(12.w),
        placeholderWidget(
          width: double.infinity,
          height: MediaQuery.of(context).size.width * 0.3,
        ),
        addVerticalSpace(16.w),
        Row(
          children: [
            placeholderWidget(
              width: (MediaQuery.of(context).size.width - 48.w) / 3,
              height: 45.w,
            ),
            addHorizontalSpace(8.w),
            placeholderWidget(
              width: (MediaQuery.of(context).size.width - 48.w) / 3,
              height: 45.w,
            ),
            addHorizontalSpace(8.w),
            placeholderWidget(
              width: (MediaQuery.of(context).size.width - 48.w) / 3,
              height: 45.w,
            ),
          ],
        ),
        addVerticalSpace(16.w),
        placeholderWidget(width: double.infinity, height: 45.w),
        addVerticalSpace(16.w),
        placeholderWidget(
          width: double.infinity,
          height: MediaQuery.of(context).size.width * 0.3,
        ),
        addVerticalSpace(20.w),
        placeholderWidget(
          width: double.infinity,
          height: MediaQuery.of(context).size.width * 0.3,
        ),
        addVerticalSpace(20.w),
        placeholderWidget(
          width: double.infinity,
          height: MediaQuery.of(context).size.width * 0.3,
        ),
        addVerticalSpace(20.w),
      ],
    );
  }

  Widget placeholderWidget({required double width, required double height}) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: AppPallete.medium,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(style: BorderStyle.none),
      ),
    );
  }
}
