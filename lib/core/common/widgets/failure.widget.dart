import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:neko_coffee/core/theme/app_pallete.dart';
import 'package:neko_coffee/core/theme/app_style.dart';
import 'package:neko_coffee/core/utils/utils_common.dart';
import '../../error/server_error.dart';

class FailurePage extends StatelessWidget {
  const FailurePage({
    super.key,
    required this.error,
    this.padding,
    this.onPressed,
  });
  final ServerError error;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        alignment: Alignment.topCenter,
        height: 150.w,
        child: FailureContent(
          description: error.message,
          image: 'assets/svg/network.svg',
          onPressed: onPressed,
        ),
      ),
    );
  }
}

class FailureWidget extends StatelessWidget {
  const FailureWidget({
    super.key,
    required this.error,
    this.padding,
    this.onPressed,
  });
  final ServerError error;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      alignment: Alignment.topCenter,
      child: FailureContent(
        description: error.message,
        image: 'assets/svg/notFound.svg',
        onPressed: onPressed,
      ),
    );
  }
}

class FailureContent extends StatelessWidget {
  const FailureContent({
    super.key,
    required this.description,
    this.image,
    this.onPressed,
  });
  final String description;
  final String? image;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (image != null) ...[
          SvgPicture.asset(
            image!,
            fit: BoxFit.fitWidth,
            height: 150.w,
          ),
        ],
        Text(
          description,
          style: mediumOswald(size: 16, color: AppPallete.error),
          textAlign: TextAlign.center,
        ),
        addVerticalSpace(12),
        if (onPressed != null)
          ElevatedButton(
            onPressed: onPressed,
            child: const Text(
              'Thử lại',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          )
      ],
    );
  }
}
