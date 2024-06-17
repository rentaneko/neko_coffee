import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neko_coffee/core/common/widgets/chip.widget.dart';
import 'package:neko_coffee/core/common/widgets/failure.widget.dart';
import 'package:neko_coffee/core/common/widgets/loading.widget.dart';
import 'package:neko_coffee/core/entities/category.dart';
import 'package:neko_coffee/core/entities/product.dart';
import 'package:neko_coffee/core/theme/app_pallete.dart';
import 'package:neko_coffee/core/theme/app_style.dart';
import 'package:neko_coffee/core/utils/utils_common.dart';
import '../../bloc/product_detail/product_detail_bloc.dart';

class DetailProduct extends StatefulWidget {
  const DetailProduct({super.key, required this.product});
  final Product product;
  @override
  State<DetailProduct> createState() => _DetailProductState();
}

class _DetailProductState extends State<DetailProduct> {
  @override
  void initState() {
    context.read<ProductDetailBloc>().add(
        FindCategoryById(id: widget.product.category, product: widget.product));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppPallete.light,
        body: BlocBuilder<ProductDetailBloc, ProductDetailState>(
          builder: (context, state) {
            if (state is DisplayPoductDetailState) {
              Product product = state.product;
              Category category = state.category;
              return _body(product: product, category: category);
            }
            if (state is ErrorPoductDetailState) {
              return FailurePage(error: state.error);
            }
            return const LoadingPage();
          },
        ));
  }

  Widget _body({required Product product, required Category category}) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            children: [
              Container(height: MediaQuery.of(context).size.height * .44),
              SizedBox(
                height: MediaQuery.of(context).size.height * .32,
                width: MediaQuery.of(context).size.width,
                child: Image.network(
                  widget.product.iconUrl,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 120.w,
                left: 16.w,
                child: _detailCard(product: product, category: category),
              ),
            ],
          ),
          _selectionNote(),
        ],
      ),
    );
  }

  Widget _selectionNote() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.w, horizontal: 12.w),
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: AppPallete.light,
        border: Border.all(color: AppPallete.border, width: 1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListView(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        children: [
          Text('Customize', style: boldOswald(size: 16)),
          addVerticalSpace(16.w),
          rowSelectionNote(label: 'Variant', type: 'variant'),
          rowSelectionNote(label: 'Size', type: 'size'),
          rowSelectionNote(label: 'Sugar', type: 'sugar'),
          rowSelectionNote(label: 'Ice', type: 'ice'),
        ],
      ),
    );
  }

  Widget rowSelectionNote({required String label, required String type}) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Text(label, style: regularOswald(size: 14)),
        ),
        Expanded(
          flex: 4,
          child: ChipSelection(selection: type),
        ),
      ],
    );
  }

  Widget _detailCard({required Product product, required Category category}) {
    return Container(
      width: MediaQuery.of(context).size.width * .9,
      padding: EdgeInsets.symmetric(vertical: 16.w),
      decoration: BoxDecoration(
        color: AppPallete.light,
        border: Border.all(color: AppPallete.border, width: 1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Text(
              category.name,
              style: boldOswald(size: 16, color: AppPallete.brand),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  product.name,
                  style: mediumOswald(size: 18, color: AppPallete.dark),
                ),
                Text(
                  '${product.price} \$',
                  style: mediumOswald(size: 18, color: AppPallete.dark),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Padding(
                  padding: EdgeInsets.only(left: 12.w, right: 12.w),
                  child: Text(
                    product.ingredient,
                    style: regularOswald(size: 13, color: AppPallete.dark),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              // Container(
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(16),
              //   ),
              //   child: Row(
              //     children: [
              //       IconButton(
              //         onPressed: () {},
              //         icon: Image.asset(
              //           'assets/icons/minus.png',
              //           height: 12.w,
              //           color: AppPallete.light,
              //         ),
              //         style: IconButton.styleFrom(
              //           backgroundColor: AppPallete.brand,
              //           shape: const RoundedRectangleBorder(
              //             borderRadius: BorderRadius.only(
              //               bottomLeft: Radius.circular(6),
              //               topLeft: Radius.circular(6),
              //             ),
              //           ),
              //           minimumSize: Size(24.w, 24.w),
              //         ),
              //       ),
              //       Container(
              //         decoration: const BoxDecoration(color: AppPallete.light),
              //         padding: EdgeInsets.all(2.w),
              //         child: Text(
              //           '200',
              //           style: boldOswald(size: 16, color: AppPallete.dark),
              //         ),
              //       ),
              //       IconButton(
              //         onPressed: () {},
              //         icon: Image.asset(
              //           'assets/icons/add.png',
              //           height: 12.w,
              //           color: AppPallete.light,
              //         ),
              //         style: IconButton.styleFrom(
              //           backgroundColor: AppPallete.brand,
              //           shape: const RoundedRectangleBorder(
              //             borderRadius: BorderRadius.only(
              //               bottomRight: Radius.circular(6),
              //               topRight: Radius.circular(6),
              //             ),
              //           ),
              //           minimumSize: Size(24.w, 24.w),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/icons/star.png',
                        color: AppPallete.rating,
                        height: 14.w,
                      ),
                      addHorizontalSpace(4.w),
                      Text('4.9', style: boldOswald(size: 12)),
                      addHorizontalSpace(6.w),
                      Text('(23)', style: regularOswald(size: 14)),
                    ],
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    'Rating and Reviews',
                    style: mediumOswald(size: 14),
                  ),
                ),
                const Icon(Icons.arrow_forward_ios),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
