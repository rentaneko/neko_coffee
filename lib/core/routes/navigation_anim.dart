import 'package:flutter/material.dart';

class Fade<T> extends PageRouteBuilder<T> {
  final Widget page;

  Fade({required this.page, required super.settings})
      : super(
          transitionDuration: const Duration(milliseconds: 700),
          reverseTransitionDuration: const Duration(milliseconds: 500),
          pageBuilder: (BuildContext context, Animation<double> animation1,
                  Animation<double> animation2) =>
              page,
          transitionsBuilder: (BuildContext context,
              Animation<double> animation1,
              Animation<double> animation2,
              Widget page) {
            final CurvedAnimation _curvedAnimation =
                CurvedAnimation(parent: animation1, curve: Curves.ease);
            return FadeTransition(
              opacity:
                  Tween<double>(begin: 0.0, end: 1.0).animate(_curvedAnimation),
              child: page,
            );
          },
        );
}

class Rotation<T> extends PageRouteBuilder<T> {
  final Widget page;

  Rotation({required this.page, required super.settings})
      : super(
          transitionDuration: const Duration(milliseconds: 700),
          reverseTransitionDuration: const Duration(milliseconds: 500),
          pageBuilder: (BuildContext context, Animation<double> animation1,
                  Animation<double> animation2) =>
              page,
          transitionsBuilder: (BuildContext context,
              Animation<double> animation1,
              Animation<double> animation2,
              Widget page) {
            final CurvedAnimation _curvedAnimation =
                CurvedAnimation(parent: animation1, curve: Curves.ease);
            return RotationTransition(
              alignment: Alignment.center,
              turns:
                  Tween<double>(begin: 0.0, end: 1.0).animate(_curvedAnimation),
              child: page,
            );
          },
        );
}

class SlideLeftRoute<T> extends PageRouteBuilder<T> {
  final Widget page;

  SlideLeftRoute({required this.page, required super.settings})
      : super(
          transitionDuration: const Duration(milliseconds: 700),
          reverseTransitionDuration: const Duration(milliseconds: 500),
          pageBuilder: (BuildContext context, Animation<double> animation1,
                  Animation<double> animation2) =>
              page,
          transitionsBuilder: (BuildContext context,
              Animation<double> animation1,
              Animation<double> animation2,
              Widget page) {
            final CurvedAnimation _curvedAnimation =
                CurvedAnimation(parent: animation1, curve: Curves.ease);
            return SlideTransition(
              position:
                  Tween<Offset>(begin: const Offset(1.0, 0.0), end: Offset.zero)
                      .animate(_curvedAnimation),
              child: page,
            );
          },
        );
}

class SlideVertical<T> extends PageRouteBuilder<T> {
  final Widget page;

  SlideVertical({required this.page, required super.settings})
      : super(
          transitionDuration: const Duration(milliseconds: 700),
          reverseTransitionDuration: const Duration(milliseconds: 500),
          pageBuilder: (BuildContext context, Animation<double> animation1,
              Animation<double> animation2) {
            return page;
          },
          transitionsBuilder: (BuildContext context,
              Animation<double> animation1,
              Animation<double> animation2,
              Widget page) {
            final CurvedAnimation _curvedAnimation =
                CurvedAnimation(parent: animation1, curve: Curves.ease);
            return SlideTransition(
              child: page,
              position:
                  Tween<Offset>(begin: const Offset(0.0, 1.0), end: Offset.zero)
                      .animate(_curvedAnimation),
            );
          },
        );
}
