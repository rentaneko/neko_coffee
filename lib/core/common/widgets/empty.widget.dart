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
            'assets/warning/empty-image.png',
            height: 120.h,
            width: 120.w,
          ),
          SizedBox(height: 8.h),
          Text(
            desciption ?? 'Không có dữ liệu',
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: Colors.grey.shade400),
          )
        ],
      ),
    );
  }
}
