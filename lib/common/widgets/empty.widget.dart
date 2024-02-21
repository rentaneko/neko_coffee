import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({super.key, this.desciption});
  final String? desciption;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/empty-image.png',
            height: 300.h,
            width: 280.w,
          ),
          SizedBox(height: 12.h),
          Text(
            desciption ?? 'Không có dữ liệu',
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 28.sp,
                color: Colors.grey.shade400),
          )
        ],
      ),
    );
  }
}
