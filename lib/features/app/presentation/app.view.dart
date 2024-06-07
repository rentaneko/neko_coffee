import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neko_coffee/core/theme/app_pallete.dart';
import 'package:neko_coffee/core/theme/app_style.dart';
import 'package:neko_coffee/features/product/presentation/views/home.screen.dart';

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: selectedIndex,
        children: [
          const HomeScreen(),
          Container(color: AppPallete.border),
          Container(color: AppPallete.brand),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          border: Border.all(color: AppPallete.brand, width: 2),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(),
            IconButton(
              onPressed: () => setState(() => selectedIndex = 0),
              icon: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/icons/home.png',
                    height: 24.w,
                    color: selectedIndex == 0
                        ? AppPallete.brand
                        : AppPallete.disable,
                  ),
                  Text(
                    'Home',
                    style: mediumOswald(
                      size: selectedIndex == 0 ? 12 : 10,
                      color: selectedIndex == 0
                          ? AppPallete.brand
                          : AppPallete.disable,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () => setState(() => selectedIndex = 1),
              icon: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/icons/order.png',
                    height: 24.w,
                    color: selectedIndex == 1
                        ? AppPallete.brand
                        : AppPallete.disable,
                  ),
                  Text(
                    'History',
                    style: mediumOswald(
                      size: selectedIndex == 1 ? 12 : 10,
                      color: selectedIndex == 1
                          ? AppPallete.brand
                          : AppPallete.disable,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () => setState(() => selectedIndex = 2),
              icon: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/icons/user_light.png',
                    height: 24.w,
                    color: selectedIndex == 2
                        ? AppPallete.brand
                        : AppPallete.disable,
                  ),
                  Text(
                    'Account',
                    style: mediumOswald(
                      size: selectedIndex == 2 ? 12 : 10,
                      color: selectedIndex == 2
                          ? AppPallete.brand
                          : AppPallete.disable,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(),
          ],
        ),
      ),
    );
  }
}
