import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neko_coffee/core/entities/enum.entity.dart';
import '../../theme/app_pallete.dart';
import '../../theme/app_style.dart';

Widget sliverTabar() {
  return SliverAppBar(
    automaticallyImplyLeading: false,
    backgroundColor: AppPallete.light,
    expandedHeight: 150.w,
    floating: true,
    pinned: true,
    flexibleSpace: FlexibleSpaceBar(
      background: Container(
          margin: EdgeInsets.only(bottom: 30.w),
          child: Image.asset('assets/images/promo.png')),
      collapseMode: CollapseMode.none,
    ),
    bottom: TabBar(
      labelStyle: mediumOswald(size: 16, color: AppPallete.brand),
      indicatorColor: AppPallete.brand,
      indicatorSize: TabBarIndicatorSize.tab,
      labelColor: AppPallete.brand,
      unselectedLabelColor: AppPallete.disable,
      dividerColor: AppPallete.light,
      tabs: [
        Tab(text: CategoryEnum.coffee.name),
        Tab(text: CategoryEnum.noncoffee.name),
        Tab(text: CategoryEnum.pastry.name),
      ],
    ),
  );
}
