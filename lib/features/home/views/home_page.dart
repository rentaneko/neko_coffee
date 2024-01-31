import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neko_coffee/features/auth/views/signup_screen.dart';
import 'package:neko_coffee/features/cart/bloc/index.dart';
import 'package:neko_coffee/features/home/bloc/index.dart';
import 'package:neko_coffee/features/wishlist/bloc/index.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() {
    return HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen> {
  HomeScreenState();
  final HomeBloc homeBloc = HomeBloc(const HomeInitializedState());
  @override
  void initState() {
    homeBloc.add(HomeInitialEvent());
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      listenWhen: (previous, current) => current is HomeActionState,
      buildWhen: (previous, current) => current is! HomeActionState,
      listener: (context, state) {
        if (state is HomeNavigateToCartScreenActionState) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const CartScreen()));
        } else if (state is HomeNavigateToWishlistScreenActionState) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const WishlistScreen()));
        } else if (state is HomeNavigateToLoginScreenActionState) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const SignUpScreen()));
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case HomeLoadingState:
            return const Scaffold(
              body: Center(child: CircularProgressIndicator.adaptive()),
            );

          case HomeLoadedSuccessState:
            final successState = state as HomeLoadedSuccessState;
            return Scaffold(
              appBar: AppBar(
                title: Text('Home page'),
                actions: [
                  IconButton(
                      onPressed: () =>
                          homeBloc.add(HomeWishlistButtonNavigateEvent()),
                      icon: const Icon(Icons.favorite_border_outlined)),
                  IconButton(
                      onPressed: () =>
                          homeBloc.add(HomeCartButtonNavigateEvent()),
                      icon: const Icon(Icons.shopping_cart_outlined)),
                ],
              ),
              body: ListView.separated(
                itemCount: successState.products.length,
                shrinkWrap: true,
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(height: 8.h);
                },
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: Colors.black45),
                      color: Colors.white,
                    ),
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                    margin: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CachedNetworkImage(
                          imageUrl: successState.products[index].imgUrl,
                          height: 125.h,
                          width: 140.w,
                          errorWidget: (context, url, error) => Image.network(
                              'https://i.pinimg.com/originals/ef/8b/bd/ef8bbd4554dedcc2fd1fd15ab0ebd7a1.gif'),
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Image.network(
                              'https://kellerheavy.vn/upload/source/loc-nuoc-dau-nguon-A2/7.png'),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              successState.products[index].name,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 16.sp,
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                text: '${successState.products[index].price}',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16.sp,
                                  color: Colors.redAccent.shade400,
                                ),
                                children: [
                                  TextSpan(
                                    text: ' \$',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              successState.products[index].desc!,
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14.sp,
                              ),
                            ),
                            Row(
                              children: [
                                IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.favorite_outline_sharp)),
                                IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                        Icons.shopping_cart_checkout_rounded)),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            );

          case HomeErrorState:
            return Scaffold(
              appBar: AppBar(
                title: const Text('Error State'),
              ),
            );
          default:
            return const SizedBox();
        }
      },
    );
  }
}
