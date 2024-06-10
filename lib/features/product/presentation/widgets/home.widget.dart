import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neko_coffee/core/entities/enum.entity.dart';
import 'package:neko_coffee/core/entities/product.dart';
import 'package:neko_coffee/core/utils/utils_common.dart';
import 'package:neko_coffee/features/product/bloc/product_bloc.dart';
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

// filter row
class FilterWidget extends StatefulWidget {
  const FilterWidget({super.key, required this.products});
  final List<Product> products;

  @override
  State<FilterWidget> createState() => _FilterWidgetState();
}

class _FilterWidgetState extends State<FilterWidget> {
  bool isPromo = false;
  bool isFilter = false;
  bool isPrice = false;
  SortType sortType = SortType.none;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36.w,
      child: Row(
        children: [
          addHorizontalSpace(8.w),
          ElevatedButton.icon(
            label: Text(
              'Filter',
              style: mediumOswald(
                size: 16,
                color: !isFilter ? AppPallete.dark : AppPallete.light,
              ),
            ),
            onPressed: () {
              setState(() => (
                    isFilter = false,
                    isPrice = false,
                    isPromo = false,
                    sortType = SortType.none
                  ));
              context
                  .read<ProductBloc>()
                  .add(ResetFilter(products: widget.products));
            },
            icon: Image.asset(
              'assets/icons/filter.png',
              height: 16.w,
              color: !isFilter ? AppPallete.dark : AppPallete.light,
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  !isFilter ? AppPallete.brand50 : AppPallete.brand,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide.none,
              ),
              padding: EdgeInsets.symmetric(vertical: 8.w, horizontal: 12.w),
            ),
          ),
          addHorizontalSpace(8.w),
          Expanded(
            child: ListView(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              children: [
                _promoButton(),
                addHorizontalSpace(8.w),
                _priceButton(),
                addHorizontalSpace(8.w),
              ],
            ),
          ),
          addHorizontalSpace(8.w),
        ],
      ),
    );
  }

  Widget _promoButton() {
    return ElevatedButton.icon(
      label: Text(
        'Promo',
        style: mediumOswald(
          size: 16,
          color: !isPromo ? AppPallete.dark : AppPallete.light,
        ),
      ),
      onPressed: () {
        if (isFilter == false) {
          setState(() => (isFilter = true, isPromo = true, isPrice = false));
          context.read<ProductBloc>().add(
                FilterProduct(products: widget.products, isPromo: true),
              );
        } else {
          if (isPromo == false) {
            setState(() =>
                (isPromo = true, isPrice = false, sortType = SortType.none));
            context.read<ProductBloc>().add(
                  FilterProduct(products: widget.products, isPromo: true),
                );
          } else {
            setState(() => (isPromo = false, isFilter = false));
            context
                .read<ProductBloc>()
                .add(ResetFilter(products: widget.products));
          }
        }
      },
      icon: Image.asset(
        'assets/icons/promo.png',
        height: 16.w,
        color: !isPromo ? AppPallete.dark : AppPallete.light,
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: !isPromo ? AppPallete.brand50 : AppPallete.brand,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide.none,
        ),
        padding: EdgeInsets.symmetric(vertical: 8.w, horizontal: 12.w),
      ),
    );
  }

  Widget _priceButton() {
    return ElevatedButton.icon(
      label: sortType == SortType.none
          ? Text(
              'Price',
              style: mediumOswald(
                size: 16,
                color: !isPrice ? AppPallete.dark : AppPallete.light,
              ),
            )
          : Row(
              children: [
                Text(
                  'Price',
                  style: mediumOswald(
                    size: 16,
                    color: !isPrice ? AppPallete.dark : AppPallete.light,
                  ),
                ),
                sortType == SortType.ascending
                    ? Image.asset(
                        'assets/icons/sort-ascending.png',
                        color: AppPallete.light,
                        height: 16.w,
                      )
                    : Image.asset(
                        'assets/icons/sort-descending.png',
                        color: AppPallete.light,
                        height: 16.w,
                      )
              ],
            ),
      onPressed: () {
        if (isFilter == false) {
          setState(() => (
                isFilter = true,
                isPromo = false,
                isPrice = true,
                sortType = SortType.ascending,
              ));
          context
              .read<ProductBloc>()
              .add(FilterProduct(products: widget.products, price: sortType));
        } else {
          if (sortType == SortType.none) {
            setState(() => (
                  isPromo = false,
                  isPrice = true,
                  sortType = SortType.ascending,
                ));
            context.read<ProductBloc>().add(
                  FilterProduct(products: widget.products, price: sortType),
                );
          } else if (sortType == SortType.ascending) {
            setState(() => (
                  isPromo = false,
                  isPrice = true,
                  sortType = SortType.descending,
                ));
            context
                .read<ProductBloc>()
                .add(FilterProduct(products: widget.products, price: sortType));
          } else if (sortType == SortType.descending) {
            setState(() => (
                  isPromo = false,
                  isPrice = false,
                  isFilter = false,
                  sortType = SortType.none,
                ));
            context
                .read<ProductBloc>()
                .add(ResetFilter(products: widget.products));
          }
        }
      },
      icon: Image.asset(
        'assets/icons/dollar-sign.png',
        height: 16.w,
        color: !isPrice ? AppPallete.dark : AppPallete.light,
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: !isPrice ? AppPallete.brand50 : AppPallete.brand,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide.none,
        ),
        padding: EdgeInsets.symmetric(vertical: 8.w, horizontal: 12.w),
      ),
    );
  }
}
