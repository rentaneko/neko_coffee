import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neko_coffee/common/widgets/failure.widget.dart';
import 'package:neko_coffee/common/widgets/loading.widget.dart';
import 'package:neko_coffee/features/cart/bloc/cart_bloc.dart';
import 'package:neko_coffee/features/cart/bloc/cart_event.dart';
import 'package:neko_coffee/features/cart/bloc/cart_state.dart';
import 'package:neko_coffee/features/home/bloc/home_bloc.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key, this.homeBloc});
  final HomeBloc? homeBloc;

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final cartBloc = CartBloc(InitialCartState());

  @override
  void initState() {
    cartBloc.add(InitialCartEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartBloc, CartState>(
      bloc: cartBloc,
      listener: (context, state) {},
      listenWhen: (previous, current) => current is CartActionState,
      buildWhen: (previous, current) => current is! CartActionState,
      builder: (context, state) {
        switch (state.runtimeType) {
          case CartLoadedSuccessState:
            state as CartLoadedSuccessState;
            return Scaffold(
              appBar: AppBar(title: const Text('CART'), centerTitle: true),
              body: ListView.separated(
                itemCount: state.cart.length,
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(height: 12.h);
                },
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: Image.network(
                      '${state.cart[index].imgUrl}',
                      fit: BoxFit.contain,
                      height: 65.h,
                      width: 55.w,
                    ),
                    title: Text('${state.cart[index].name}'),
                    subtitle: Text('${state.cart[index].price} \$'),
                    trailing: SizedBox(
                      width: 120.w,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: IconButton(
                              onPressed: () => cartBloc.add(
                                UpdateQuantityItemCartEvent(
                                  idProduct: state.cart[index].idProduct!,
                                  quantity: -1,
                                  homeBloc: widget.homeBloc!,
                                ),
                              ),
                              icon: const Icon(CupertinoIcons.minus_circle),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              '${state.cart[index].quantity}',
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: IconButton(
                              onPressed: () => cartBloc.add(
                                UpdateQuantityItemCartEvent(
                                  idProduct: state.cart[index].idProduct!,
                                  quantity: 1,
                                  homeBloc: widget.homeBloc!,
                                ),
                              ),
                              icon: const Icon(CupertinoIcons.add_circled),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              bottomNavigationBar: Container(
                height: 80.h,
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  children: [
                    Text('Total Amount: ${cartBloc.amount.toStringAsFixed(2)}'),
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text('Payment'),
                    ),
                  ],
                ),
              ),
            );
          case CartErrorState:
            state as CartErrorState;
            return Scaffold(
              appBar: AppBar(title: const Text('CART'), centerTitle: true),
              body: FailureWidget(error: state.errorMsg),
            );
          default:
            return Scaffold(
              appBar: AppBar(title: const Text('CART'), centerTitle: true),
              body: const LoadingWidget(),
            );
        }
      },
    );
  }
}
