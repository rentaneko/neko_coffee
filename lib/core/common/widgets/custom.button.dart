import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../theme/app_pallete.dart';
import '../../theme/app_style.dart';

Widget primaryButton(
    {required VoidCallback? onPress, double? size, required String label}) {
  return ElevatedButton(
    onPressed: onPress,
    style: ButtonStyle(
      shape: MaterialStateProperty.resolveWith<RoundedRectangleBorder>(
        (states) => RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      backgroundColor: MaterialStateProperty.resolveWith<Color>(
        (states) {
          if (states.contains(MaterialState.disabled)) {
            return AppPallete.disable;
          }
          return AppPallete.brand;
        },
      ),
      padding: MaterialStateProperty.resolveWith<EdgeInsets>(
        (states) => EdgeInsets.symmetric(vertical: 12.w, horizontal: 24.w),
      ),
      fixedSize: MaterialStateProperty.resolveWith<Size>(
        (states) => Size(size ?? 156.w, 48.w),
      ),
      iconColor: MaterialStateProperty.resolveWith<Color?>(
          (states) => AppPallete.light),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: mediumOswald(size: 16, color: AppPallete.light),
          textAlign: TextAlign.center,
        ),
        Icon(Icons.favorite_border, size: 20.w),
      ],
    ),
  );
}

Widget smallButton(
    {required VoidCallback? onPress, double? size, required String label}) {
  return ElevatedButton(
    onPressed: onPress,
    style: ButtonStyle(
      shape: MaterialStateProperty.resolveWith<RoundedRectangleBorder>(
        (states) => RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
      ),
      backgroundColor: MaterialStateProperty.resolveWith<Color>(
        (states) {
          if (states.contains(MaterialState.disabled)) {
            return AppPallete.disable;
          }
          return AppPallete.brand;
        },
      ),
      padding: MaterialStateProperty.resolveWith<EdgeInsets>(
        (states) => EdgeInsets.symmetric(vertical: 8.w, horizontal: 24.w),
      ),
      fixedSize: MaterialStateProperty.resolveWith<Size>(
        (states) => Size(size ?? 156.w, 36.w),
      ),
      iconColor: MaterialStateProperty.resolveWith<Color?>(
          (states) => AppPallete.light),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: mediumOswald(size: 14, color: AppPallete.light),
          textAlign: TextAlign.center,
        ),
        Icon(Icons.favorite_border, size: 16.w, color: AppPallete.light),
      ],
    ),
  );
}

Widget outlinedButton(
    {required VoidCallback? onPress, double? size, required String label}) {
  return OutlinedButton(
    onPressed: onPress,
    style: ButtonStyle(
      shape: MaterialStateProperty.resolveWith<RoundedRectangleBorder>(
        (states) =>
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      side: MaterialStateProperty.resolveWith(
          (states) => const BorderSide(color: AppPallete.brand, width: 1.5)),
      backgroundColor: MaterialStateProperty.resolveWith<Color>(
        (states) {
          if (states.contains(MaterialState.disabled)) {
            return AppPallete.disable.withOpacity(0.2);
          }
          return AppPallete.light;
        },
      ),
      padding: MaterialStateProperty.resolveWith<EdgeInsets>(
        (states) => EdgeInsets.symmetric(vertical: 12.w, horizontal: 24.w),
      ),
      fixedSize: MaterialStateProperty.resolveWith<Size>(
        (states) => Size(size ?? 156.w, 48.w),
      ),
      foregroundColor: MaterialStateProperty.resolveWith<Color?>((states) {
        if (states.contains(MaterialState.disabled)) {
          return AppPallete.dark.withOpacity(0.3);
        }
        return AppPallete.dark;
      }),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: mediumOswald(
            size: 16,
            color: onPress == null
                ? AppPallete.dark.withOpacity(0.3)
                : AppPallete.dark,
          ),
        ),
        Icon(Icons.favorite_border, size: 16.w),
      ],
    ),
  );
}

Widget smallOutlined(
    {required VoidCallback? onPress, double? size, required String label}) {
  return OutlinedButton(
    onPressed: onPress,
    style: ButtonStyle(
      shape: MaterialStateProperty.resolveWith<RoundedRectangleBorder>(
        (states) => RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
      ),
      side: MaterialStateProperty.resolveWith(
          (states) => const BorderSide(color: AppPallete.brand, width: 1.5)),
      backgroundColor: MaterialStateProperty.resolveWith<Color>(
        (states) {
          if (states.contains(MaterialState.disabled)) {
            return AppPallete.disable.withOpacity(0.2);
          }
          return AppPallete.light;
        },
      ),
      padding: MaterialStateProperty.resolveWith<EdgeInsets>(
        (states) => EdgeInsets.symmetric(vertical: 8.w, horizontal: 24.w),
      ),
      fixedSize: MaterialStateProperty.resolveWith<Size>(
        (states) => Size(size ?? 156.w, 36.w),
      ),
      foregroundColor: MaterialStateProperty.resolveWith<Color?>((states) {
        if (states.contains(MaterialState.disabled)) {
          return AppPallete.dark.withOpacity(0.3);
        }
        return AppPallete.dark;
      }),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: mediumOswald(
            size: 14,
            color: onPress == null
                ? AppPallete.dark.withOpacity(0.3)
                : AppPallete.dark,
          ),
        ),
        Icon(Icons.favorite_border, size: 16.w),
      ],
    ),
  );
}

Widget searchBar() {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(50),
      border: Border.all(color: AppPallete.brand100, width: 4),
    ),
    child: TextFormField(
      decoration: InputDecoration(
        hintText: 'Search',
        hintStyle: regularOswald(size: 16, color: AppPallete.hint),
        suffixIcon: Image.asset(
          'assets/icons/search.png',
          color: AppPallete.hint,
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 8.w, horizontal: 16.w),
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
      ),
    ),
  );
}

Widget appButton(
    {required VoidCallback? onPress, double? size, required String label}) {
  return ElevatedButton(
    onPressed: onPress,
    style: ButtonStyle(
      shape: MaterialStateProperty.resolveWith<RoundedRectangleBorder>(
        (states) => RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      backgroundColor: MaterialStateProperty.resolveWith<Color>(
        (states) {
          if (states.contains(MaterialState.disabled)) {
            return AppPallete.disable;
          }
          return AppPallete.brand;
        },
      ),
      padding: MaterialStateProperty.resolveWith<EdgeInsets>(
        (states) => EdgeInsets.symmetric(vertical: 12.w, horizontal: 24.w),
      ),
      fixedSize: MaterialStateProperty.resolveWith<Size>(
        (states) => Size(size ?? 156.w, 48.w),
      ),
    ),
    child: Text(
      label,
      style: mediumOswald(size: 16, color: AppPallete.light),
      textAlign: TextAlign.center,
    ),
  );
}
