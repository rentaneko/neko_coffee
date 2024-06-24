import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neko_coffee/core/common/widgets/custom.tabbar.dart';
import 'package:neko_coffee/core/common/widgets/failure.widget.dart';
import 'package:neko_coffee/core/common/widgets/placeholder.widget.dart';
import 'package:neko_coffee/core/entities/enum.entity.dart';
import 'package:neko_coffee/core/theme/app_pallete.dart';
import 'package:neko_coffee/core/utils/utils_common.dart';
import 'package:neko_coffee/features/product/bloc/product_bloc.dart';
import 'package:neko_coffee/features/product/presentation/widgets/home.widget.dart';
import '../../../../core/common/widgets/custom.button.dart';
import '../../../../core/entities/product.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    context.read<ProductBloc>().add(FetchAllProduct());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      bloc: context.read<ProductBloc>(),
      builder: (context, state) {
        if (state is ProductLoading) {
          return const PlaceholderScreen();
        }
        if (state is ProductFailure) {
          return FailurePage(error: state.error);
        }
        if (state is ProductDisplaySuccess) {
          return Scaffold(
            backgroundColor: AppPallete.light,
            appBar: appbar(),
            body: body(products: state.products),
          );
        }

        return Container();
      },
    );
  }

  AppBar appbar() {
    return AppBar(
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
            icon: Image.asset('assets/icons/bell.png', color: AppPallete.brand),
          ),
        ),
      ],
    );
  }

  Widget body({required List<Product> products}) {
    return DefaultTabController(
      length: 3,
      child: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [sliverTabar()],
        body: Column(
          children: [
            addVerticalSpace(4.w),
            FilterWidget(products: products),
            addVerticalSpace(4.w),
            tabarView(products),
          ],
        ),
      ),
    );
  }

  Widget tabarView(List<Product> products) {
    return Expanded(
      child: TabBarView(
        children: [
          CustomWidget.listCardProduct(
            products: products,
            category: CategoryEnum.coffee.id,
          ),
          CustomWidget.listCardProduct(
            products: products,
            category: CategoryEnum.noncoffee.id,
          ),
          CustomWidget.listCardProduct(
            products: products,
            category: CategoryEnum.pastry.id,
          ),
        ],
      ),
    );
  }
}
