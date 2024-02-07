import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<void> showFlashDialog(
  BuildContext mainContext, {
  required String title,
  void Function()? onPressed,
}) async {
  await showGeneralDialog(
    context: mainContext,
    barrierLabel: 'Barrier',
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.5),
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (context, __, ___) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(20.h),
          margin: EdgeInsets.only(top: 20.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                title,
                // style: mediumLato(gradient4, 16.sp),
              ),
              SizedBox(height: 16.h),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: onPressed,
                      child: Text(
                        'OK',
                        // style: mediumLato(infor01, 16.sp),
                      ),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        'Hủy bỏ',
                        // style: mediumLato(infor01, 16.sp),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
    transitionBuilder: (_, anim, __, child) {
      Tween<Offset> tween;
      if (anim.status == AnimationStatus.reverse) {
        tween = Tween(
          begin: const Offset(-1, 0),
          end: Offset.zero,
        );
      } else {
        tween = Tween(
          begin: const Offset(1, 0),
          end: Offset.zero,
        );
      }

      return SlideTransition(
        position: tween.animate(anim),
        child: FadeTransition(
          opacity: anim,
          child: child,
        ),
      );
    },
  );
}

Future<void> showSuccessDialog(
  BuildContext context, {
  required String title,
}) async {
  await showGeneralDialog(
    context: context,
    barrierLabel: 'Barrier',
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.5),
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (context, __, ___) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Container(
          width: double.infinity,
          height: 120.h,
          padding: EdgeInsets.all(20.h),
          margin: EdgeInsets.only(top: 20.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                title,
                // style: mediumLato(gradient4, 16.sp),
              ),
              SizedBox(height: 16.h),
              Expanded(
                child: ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('OK'),
                ),
              ),
            ],
          ),
        ),
      );
    },
    transitionBuilder: (_, anim, __, child) {
      Tween<Offset> tween;
      if (anim.status == AnimationStatus.reverse) {
        tween = Tween(
          begin: const Offset(0, 0),
          end: Offset.zero,
        );
      } else {
        tween = Tween(
          begin: const Offset(0, 1),
          end: Offset.zero,
        );
      }

      return SlideTransition(
        position: tween.animate(anim),
        child: FadeTransition(
          opacity: anim,
          child: child,
        ),
      );
    },
  );
}

Future<void> showLoadingDialog(BuildContext context) async {
  await showGeneralDialog(
    context: context,
    barrierLabel: 'Barrier',
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.5),
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (context, __, ___) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(20.h),
          margin: EdgeInsets.only(top: 20.h),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.8),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('Loading...'),
              SizedBox(height: 16.h),
            ],
          ),
        ),
      );
    },
    transitionBuilder: (_, anim, __, child) {
      Tween<Offset> tween;
      if (anim.status == AnimationStatus.reverse) {
        tween = Tween(
          begin: const Offset(-1, 0),
          end: Offset.zero,
        );
      } else {
        tween = Tween(
          begin: const Offset(1, 0),
          end: Offset.zero,
        );
      }

      return SlideTransition(
        position: tween.animate(anim),
        child: FadeTransition(
          opacity: anim,
          child: child,
        ),
      );
    },
  );
}
