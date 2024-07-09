import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../core/configs/theme/app_colors.dart';

class ChooseModeButton extends StatelessWidget {
  final String svgUrl;
  final String title;
  final VoidCallback onTap;
  const ChooseModeButton(
      {super.key,
      required this.svgUrl,
      required this.title,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          _circleWidget(),
          SizedBox(height: 12.w),
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 13,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _circleWidget() {
    return ClipOval(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          height: 50.w,
          width: 50.w,
          decoration: BoxDecoration(
            color: AppColors.imgBlur.withOpacity(0.5),
            shape: BoxShape.circle,
          ),
          child: SvgPicture.asset(
            svgUrl,
            fit: BoxFit.scaleDown,
          ),
        ),
      ),
    );
  }
}
