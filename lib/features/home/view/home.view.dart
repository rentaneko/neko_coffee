import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neko_coffee/common/widgets/dialog.widget.dart';
import 'package:neko_coffee/common/widgets/failure.widget.dart';
import 'package:neko_coffee/common/widgets/loading.widget.dart';
import 'package:neko_coffee/features/home/bloc/home_bloc.dart';
import 'package:neko_coffee/features/home/bloc/home_event.dart';
import 'package:neko_coffee/features/home/bloc/home_state.dart';
import 'package:neko_coffee/features/home/view/home.widget.dart';
import 'package:neko_coffee/models/cart.model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final homeBloc = HomeBloc(InitialHomeState());
  List<CartModel> cart = [];

  @override
  void initState() {
    homeBloc.add(InitialHomeEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      listenWhen: (previous, current) => current is HomeActionState,
      buildWhen: (previous, current) => current is! HomeActionState,
      listener: (context, state) {
        if (state is AddToCartClickedHomeState) {
          showLoadingDialog(context);
        }
        if (state is SuccessAddToCartHomeState) {
          Navigator.of(context).pop();
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case ErrorHomeState:
            return FailurePage(error: (state as ErrorHomeState).errorMessage);

          case UnAuthenticatedHomeState:
            state as UnAuthenticatedHomeState;
            return Scaffold(
              appBar: AppBar(
                title: Text('Home UnAu'),
                automaticallyImplyLeading: false,
              ),
              body: HomeWidget.unAuthenticatedScreen(
                  products: state.products, onPress: homeBloc),
            );

          case AuthenticatedHomeState:
            state as AuthenticatedHomeState;
            return Scaffold(
              appBar: AppBar(
                title: Text('Home Au'),
                automaticallyImplyLeading: false,
                actions: [
                  Badge(
                    label: Text('${state.cart.length}'),
                    isLabelVisible: state.cart == [] ? false : true,
                    alignment: Alignment.bottomRight,
                    offset: const Offset(5, 4),
                    child: const Icon(CupertinoIcons.shopping_cart),
                  ),
                  SizedBox(width: 20.w),
                ],
              ),
              body: HomeWidget.authenticatedScreen(
                  products: state.products, onPress: homeBloc),
            );

          case LoadingHomeState:
            if (homeBloc.client.auth.currentUser != null) {
              return Scaffold(
                appBar: AppBar(
                  title: Text('Home Au'),
                  leading: const Icon(Icons.menu),
                ),
                body: const LoadingWidget(),
              );
            }

            return Scaffold(
              appBar: AppBar(
                title: Text('Home UnAu'),
                leading: const Icon(Icons.menu),
              ),
              body: const LoadingWidget(),
            );

          default:
            return const LoadingPage();
        }
      },
    );
  }
}