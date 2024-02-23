import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neko_coffee/features/account/bloc/account_state.dart';
import 'package:neko_coffee/features/account/bloc/index.dart';
import 'package:neko_coffee/features/app/bloc/index.dart';
import 'package:neko_coffee/features/cart/bloc/cart_state.dart';
import 'package:neko_coffee/features/cart/bloc/index.dart';
import 'package:neko_coffee/features/home/bloc/home_bloc.dart';
import 'package:neko_coffee/features/home/bloc/home_state.dart';
import 'package:neko_coffee/features/login/bloc/index.dart';
import 'package:neko_coffee/features/signup/bloc/index.dart';
import 'package:neko_coffee/features/home/view/home.view.dart';
import 'package:neko_coffee/routes/app_router.dart';

class AppPages {
  //
  static final RouteObserver<Route> observer = RouteObserver();
  static List<String> history = [];

  static List<PageEntity> routes() {
    return [
      PageEntity(
        path: HOME_ROUTE,
        page: const HomeScreen(),
        bloc: BlocProvider(create: (_) => HomeBloc(InitialHomeState())),
      ),
      PageEntity(
        path: LOGIN_ROUTE,
        page: const LoginScreen(),
        bloc: BlocProvider(create: (_) => LoginBloc(InitialLoginState())),
      ),
      PageEntity(
        path: SIGNUP_ROUTE,
        page: const SignUpScreen(),
        bloc: BlocProvider(create: (_) => SignUpBloc(InitialSignUpState())),
      ),
      PageEntity(
        path: APP_ROUTE,
        page: const AppScreen(),
        bloc: BlocProvider(create: (_) => AppBloc(InitialAppState())),
      ),
      PageEntity(
        path: ACCOUNT_ROUTE,
        page: const AccountScreen(),
        bloc: BlocProvider(create: (_) => AccountBloc(InitialAccountState())),
      ),
      PageEntity(
        path: CART_ROUTE,
        page: const CartScreen(),
        bloc: BlocProvider(create: (_) => CartBloc(InitialCartState())),
      ),
    ];
  }

  static List<dynamic> blocer(BuildContext context) {
    List<dynamic> blocerList = <dynamic>[];
    for (var blocer in routes()) {
      blocerList.add(blocer.bloc);
    }
    return blocerList;
  }

  static MaterialPageRoute generateRouteSettings(RouteSettings settings) {
    if (settings.name != null) {
      var result = routes().where((element) => element.path == settings.name);
      if (result.isNotEmpty) {
        return MaterialPageRoute(
            builder: (_) => result.first.page, settings: settings);
      }
    }
    return MaterialPageRoute(
        builder: (_) => const HomeScreen(), settings: settings);
  }
}

class PageEntity<T> {
  String path;
  Widget page;
  dynamic bloc;

  PageEntity({required this.path, required this.page, required this.bloc});
}
