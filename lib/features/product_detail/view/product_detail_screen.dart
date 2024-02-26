import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neko_coffee/common/functions/calculation.dart';
import 'package:neko_coffee/common/widgets/failure.widget.dart';
import 'package:neko_coffee/common/widgets/loading.widget.dart';
import 'package:neko_coffee/features/cart/bloc/index.dart';
import 'package:neko_coffee/features/product_detail/bloc/index.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key, this.cartBloc, this.idProduct});
  final CartBloc? cartBloc;
  final String? idProduct;
  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final productDetailBloc = ProductDetailBloc(ProductDetailInitialState());

  @override
  void initState() {
    productDetailBloc
        .add(ProductDetailInitialEvent(idProduct: widget.idProduct!));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductDetailBloc, ProductDetailState>(
      bloc: productDetailBloc,
      builder: (context, state) {
        switch (state.runtimeType) {
          case ProductDetailErrorState:
            state as ProductDetailErrorState;
            return FailurePage(error: state.errorMsg);

          case ProductDetailLoadedState:
            state as ProductDetailLoadedState;
            return Scaffold(
              appBar: AppBar(
                title: const Text('PRODUCT DETAIL'),
                centerTitle: true,
                actions: [
                  InkWell(
                    onTap: () {},
                    child: Badge(
                      label: Text('${state.cart.length}'),
                      isLabelVisible: state.cart == [] ? false : true,
                      alignment: Alignment.bottomRight,
                      offset: const Offset(5, 4),
                      child: const Icon(CupertinoIcons.shopping_cart),
                    ),
                  ),
                  SizedBox(width: 10.w),
                ],
              ),
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.network(
                    '${state.product.imgUrl}',
                    height: 250.h,
                    width: double.infinity,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    '${state.product.name}',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16.sp,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    '${state.product.price} \$',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16.sp,
                      color: Colors.red.shade700,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Text('${state.product.desc}'),
                ],
              ),
              bottomNavigationBar: Container(
                height: 70.h,
                padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(width: 10.w),
                    Expanded(
                      flex: 1,
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.favorite, color: Colors.red.shade400),
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                            side: BorderSide(color: Colors.red.shade400),
                          ),
                          visualDensity: VisualDensity.comfortable,
                        ),
                      ),
                    ),
                    SizedBox(width: 30.w),
                    Expanded(
                      flex: 4,
                      child: getQuantityInCartById(
                                  productDetailBloc.product.id!,
                                  productDetailBloc.cart) ==
                              0
                          ? ElevatedButton(
                              onPressed: () {},
                              child: Text('Add to Cart'),
                            )
                          : Container(
                              padding: EdgeInsets.symmetric(
                                vertical: 4.h,
                                horizontal: 8.w,
                              ),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(
                                  color: const Color(0xffC68017),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  IconButton(
                                    onPressed: () {},
                                    icon:
                                        Icon(CupertinoIcons.minus_circle_fill),
                                  ),
                                  Text(
                                      '${getQuantityInCartById(productDetailBloc.product.id!, productDetailBloc.cart)}'),
                                  IconButton(
                                    onPressed: () {},
                                    icon:
                                        Icon(CupertinoIcons.add_circled_solid),
                                  ),
                                ],
                              ),
                            ),
                    ),
                  ],
                ),
              ),
            );
          default:
            return const LoadingPage();
        }
      },
    );
  }
}
