import 'package:flutter/material.dart';
import 'package:neko_coffee/core/routes/navigation_anim.dart';
import 'package:neko_coffee/core/routes/route_name.dart';
import 'package:neko_coffee/features/app/presentation/app.view.dart';
import 'package:neko_coffee/features/auth/presentation/pages/login.screen.dart';
import 'package:neko_coffee/features/auth/presentation/pages/signup.screen.dart';
import 'package:neko_coffee/features/auth/presentation/pages/splash.screen.dart';
import 'package:neko_coffee/features/app/presentation/onboarding_1.view.dart';
import 'package:neko_coffee/features/app/presentation/onboarding_2.view.dart';
import 'package:neko_coffee/features/app/presentation/onboarding_3.view.dart';
import 'package:neko_coffee/features/cart/presentation/view/add_to_cart.view.dart';
import 'package:neko_coffee/features/product/presentation/views/home.screen.dart';

import '../entities/product.dart';

class MyRoutes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.onboardingFirstPath:
        return Fade(
          page: const OnboardingFirstScreen(),
          settings: const RouteSettings(name: '/onboarding-1'),
        );
      case RoutesName.onboardingSecondPath:
        return Fade(
          page: const OnboardingSecondScreen(),
          settings: const RouteSettings(name: '/onboarding-2'),
        );
      case RoutesName.onboardingThirdPath:
        return Fade(
          page: const OnboardingThirdScreen(),
          settings: const RouteSettings(name: '/onboarding-3'),
        );
      case RoutesName.loginPath:
        return SlideLeftRoute(page: const LoginScreen(), settings: settings);
      case RoutesName.signupPath:
        return SlideVertical(page: const SignUpPage(), settings: settings);
      case RoutesName.splashPath:
        return Fade(page: const SplashScreen(), settings: settings);
      case RoutesName.homePath:
        return SlideVertical(page: const HomeScreen(), settings: settings);
      case RoutesName.appPath:
        return Rotation(page: const MainApp(), settings: settings);
      case RoutesName.addToCartPath:
        Product prod = (settings.arguments as List)[0] as Product;
        String cate = (settings.arguments as List)[1] as String;
        return SlideVertical(
          page: AddToCartScreen(product: prod, category: cate),
          settings: settings,
        );
      default:
    }
    return MaterialPageRoute(
      builder: (context) => const Scaffold(
        body: Text('no route defined'),
      ),
    );
  }
}
