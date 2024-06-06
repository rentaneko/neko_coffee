import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neko_coffee/core/common/widgets/custom.tabbar.dart';
import 'package:neko_coffee/core/theme/app_pallete.dart';
import 'package:neko_coffee/core/theme/app_style.dart';
import '../../../../core/common/widgets/custom.button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPallete.light,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Container(
          margin: EdgeInsets.only(top: 8.w),
          height: 40.w,
          child: searchBar(),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.only(top: 8.w),
            child: IconButton(
              onPressed: () {},
              icon:
                  Image.asset('assets/icons/bell.png', color: AppPallete.brand),
            ),
          ),
        ],
      ),
      body: DefaultTabController(
        length: 3,
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              sliverTabar(),
            ];
          },
          body: TabBarView(
            children: [
              buildImage(),
              buildImage(),
              buildImage(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildImage() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 30,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => Text(
        'data ============ $index',
        style: mediumOswald(
          size: 24,
          color: AppPallete.brand400,
        ),
      ),
    );
  }
}
