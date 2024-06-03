import 'package:flutter/material.dart';
import 'package:neko_coffee/core/routes/navigation_anim.dart';
import 'package:neko_coffee/features/auth/presentation/pages/login_page.dart';
import 'package:neko_coffee/features/onboarding/presentation/onboarding_1.view.dart';
import 'package:neko_coffee/features/onboarding/presentation/onboarding_2.view.dart';
import 'package:neko_coffee/features/onboarding/presentation/onboarding_3.view.dart';

class MyRoutes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/onboarding-1':
        return SlideLeftRoute(
          page: const OnboardingFirstScreen(),
          settings: const RouteSettings(name: '/onboarding-1'),
        );
      case '/onboarding-2':
        return SlideLeftRoute(
          page: const OnboardingSecondScreen(),
          settings: const RouteSettings(name: '/onboarding-2'),
        );
      case '/onboarding-3':
        return SlideLeftRoute(
          page: const OnboardingThirdScreen(),
          settings: const RouteSettings(name: '/onboarding-3'),
        );
      case '/login':
        return Fade(page: const LoginPage(), settings: settings);

      default:
    }
    return MaterialPageRoute(
      builder: (context) => const Scaffold(
        body: Text('no route defined'),
      ),
    );
  }
}
