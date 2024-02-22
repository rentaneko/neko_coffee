import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotLoggedWidget extends StatelessWidget {
  const NotLoggedWidget({super.key, required this.onPress});
  final VoidCallback onPress;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.network(
            'https://media.mktg.workday.com/is/image/workday/illustration-people-login?fmt=png-alpha&wid=1000',
            height: 300.h,
            width: 280.w,
          ),
          SizedBox(height: 12.h),
          Text(
            'You has not logged into system',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 28.sp,
                color: Colors.grey.shade600),
          ),
          SizedBox(height: 12.h),
          ElevatedButton(
            onPressed: onPress,
            child: Text('Go to Login'),
          ),
        ],
      ),
    );
  }
}
