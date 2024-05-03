import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget pickImg({required VoidCallback onPress}) {
  return InkWell(
    onTap: onPress,
    child: Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.w),
      width: double.infinity,
      height: 120.h,
      child: DottedBorder(
        borderType: BorderType.RRect,
        radius: const Radius.circular(4),
        strokeWidth: 2,
        color: Colors.white,
        dashPattern: const [20, 6],
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(CupertinoIcons.photo),
              Text(
                'Select your photo',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
