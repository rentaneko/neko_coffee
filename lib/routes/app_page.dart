import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neko_coffee/features/auth/bloc/index.dart';
import 'package:neko_coffee/features/auth/views/login_screen.dart';
import 'package:neko_coffee/features/auth/views/signup_screen.dart';
import 'package:neko_coffee/features/cart/bloc/index.dart';
import 'package:neko_coffee/features/home/bloc/index.dart';
import 'package:neko_coffee/routes/app_router.dart';

class AppPages {
  //
  static final RouteObserver<Route> observer = RouteObserver();
  static List<String> history = [];

  static List<PageEntity> routes() {
    return [
      PageEntity(
        path: SPLASH_ROUTE,
        page: const AuthScreen(),
        bloc:
            BlocProvider(create: (_) => AuthBloc(const InitializedAuthState())),
      ),
      PageEntity(
        path: HOME_ROUTE,
        page: const HomeScreen(),
        bloc:
            BlocProvider(create: (_) => HomeBloc(const HomeInitializedState())),
      ),
      PageEntity(
        path: LOGIN_ROUTE,
        page: const LoginScreen(),
        bloc:
            BlocProvider(create: (_) => AuthBloc(const InitializedAuthState())),
      ),
      PageEntity(
        path: SIGNUP_ROUTE,
        page: const SignUpScreen(),
        bloc:
            BlocProvider(create: (_) => AuthBloc(const InitializedAuthState())),
      ),
      PageEntity(
        path: CART_ROUTE,
        page: const CartScreen(),
        bloc:
            BlocProvider(create: (_) => AuthBloc(const InitializedAuthState())),
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
        builder: (_) => const AuthScreen(), settings: settings);
  }
}

class PageEntity<T> {
  String path;
  Widget page;
  dynamic bloc;

  PageEntity({required this.path, required this.page, required this.bloc});
}
