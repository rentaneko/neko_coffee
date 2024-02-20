import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neko_coffee/features/home/index.dart';
import 'package:neko_coffee/models/category.model.dart';
import 'package:neko_coffee/models/product.model.dart';

class HomeWidget {
  static Widget unAuthenticatedScreen({required List<ProductModel> products}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: GridView.builder(
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12.w,
          childAspectRatio: 3 / 4,
          mainAxisSpacing: 16.h,
        ),
        itemCount: products.length,
        itemBuilder: (BuildContext context, int index) {
          return productCart(product: products[index]);
        },
      ),
    );
  }

  static Widget authenticatedScreen({required List<ProductModel> products}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: GridView.builder(
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12.w,
          childAspectRatio: 3 / 4,
          mainAxisSpacing: 16.h,
        ),
        itemCount: products.length,
        itemBuilder: (BuildContext context, int index) {
          return productCart(product: products[index]);
        },
      ),
    );
  }

  static Widget drawer(
      BuildContext context, List<CategoryModel> cates, HomeBloc homeBloc) {
    return Drawer(
      backgroundColor: Colors.white,
      elevation: 1,
      width: ScreenUtil.defaultSize.width / 2,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(child: Text('MENU')),
            ListTile(
              leading: Text('All'),
              onTap: () {
                homeBloc.add(HomeMenuClickedEvent(cates, idCate: 'All'));
                Navigator.of(context).pop();
              },
            ),
            ListView.builder(
              itemCount: cates.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: Text('${cates[index].name}'),
                  onTap: () {
                    homeBloc.add(
                        HomeMenuClickedEvent(cates, idCate: cates[index].id!));
                    Navigator.of(context).pop();
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  static Widget productCart({required ProductModel product}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(4),
          topRight: Radius.circular(4),
        ),
        border: Border.all(width: 0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Image.network(
                '${product.imgUrl}',
                height: 150.h,
                width: double.infinity,
                fit: BoxFit.contain,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Text(
              '${product.name}',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
              textAlign: TextAlign.start,
            ),
          ),
          SizedBox(height: 8.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Text(
              '${product.desc}',
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: TextStyle(fontSize: 12.sp),
            ),
          ),
          SizedBox(height: 16.h),
          ListTile(
            minLeadingWidth: 0,
            horizontalTitleGap: 0,
            contentPadding: EdgeInsets.symmetric(horizontal: 8.w),
            minVerticalPadding: 0,
            leading: Text(
              '${product.price}\$',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w700),
            ),
            trailing: IconButton(
              onPressed: () {},
              icon: Icon(
                CupertinoIcons.cart_fill_badge_plus,
                color: Colors.white,
                size: 20.h,
              ),
              style: IconButton.styleFrom(
                backgroundColor: const Color(0xffC68017),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
