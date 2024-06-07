import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neko_coffee/core/entities/product.dart';
import 'package:neko_coffee/core/utils/utils_common.dart';

import '../../../../core/theme/app_pallete.dart';
import '../../../../core/theme/app_style.dart';

class CustomWidget {
  static Widget iconButton(
      {required String label,
      required String iconName,
      required VoidCallback onPress}) {
    return ElevatedButton.icon(
      label: Text(label, style: mediumOswald(size: 16, color: AppPallete.dark)),
      onPressed: onPress,
      icon: Image.asset('assets/icons/$iconName.png'),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppPallete.brand50,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide.none,
        ),
        padding: EdgeInsets.symmetric(vertical: 8.w, horizontal: 12.w),
      ),
    );
  }

  static Widget cardProduct({required Product product}) {
    return Container(
      color: AppPallete.light,
      padding: EdgeInsets.symmetric(vertical: 8.w, horizontal: 12.w),
      child: Row(
        children: [
          Stack(
            children: [
              Container(
                height: 70.w,
                width: 66.w,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppPallete.disable,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.network(product.iconUrl),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 66.w * 0.15,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 4.w, horizontal: 8.w),
                  decoration: BoxDecoration(
                    color: AppPallete.light,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/icons/star.png',
                        color: AppPallete.rating,
                        height: 14.w,
                        width: 14.w,
                        fit: BoxFit.cover,
                      ),
                      addHorizontalSpace(4.w),
                      Text('4.9', style: boldOswald(size: 12)),
                    ],
                  ),
                ),
              ),
            ],
          ),
          addHorizontalSpace(12.w),
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(product.name,
                    style: mediumOswald(size: 14, color: AppPallete.dark)),
                addVerticalSpace(8.w),
                Text(product.ingredient,
                    style: regularOswald(size: 12, color: AppPallete.dark)),
              ],
            ),
          ),
          addHorizontalSpace(12.w),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('${product.price} \$',
                  style: mediumOswald(size: 14, color: AppPallete.dark)),
              addVerticalSpace(8.w),
              if (product.isPromo)
                Text(
                  '${product.discount} \$',
                  style: regularOswald(
                      size: 12,
                      color: AppPallete.dark,
                      textDecoration: TextDecoration.lineThrough),
                ),
            ],
          ),
        ],
      ),
    );
  }

  static Widget listCardProduct(
      {required List<Product> products, required String category}) {
    List<Product> result =
        products.where((element) => element.category == category).toList();
    return ListView.separated(
      shrinkWrap: true,
      itemCount: result.length,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) =>
          CustomWidget.cardProduct(product: result[index]),
      separatorBuilder: (context, index) => const Divider(
        color: AppPallete.dark,
        thickness: 0.5,
      ),
    );
  }
}
