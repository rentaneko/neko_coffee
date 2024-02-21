import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neko_coffee/features/app/index.dart';
import 'package:neko_coffee/features/category/index.dart';
import 'package:neko_coffee/features/favorite/index.dart';
import 'package:neko_coffee/features/login/index.dart';
import 'package:neko_coffee/features/signup/index.dart';
import 'package:neko_coffee/presentation/home/home.screen.dart';

class AppScreen extends StatefulWidget {
  const AppScreen({super.key});

  @override
  State<AppScreen> createState() => _AppScreenState();
}

class _AppScreenState extends State<AppScreen> {
  final appBloc = AppBloc(InitialAppState());
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppBloc, AppState>(
      bloc: appBloc,
      listenWhen: (previous, current) => current is AppActionState,
      buildWhen: (previous, current) => current is! AppActionState,
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          body: IndexedStack(
            index: selectedIndex,
            children: const [
              HomeScreen(),
              CategoryScreen(),
              FavoriteScreen(),
              SignUpScreen(),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: selectedIndex,
            onTap: (value) => setState(() => selectedIndex = value),
            selectedItemColor: Colors.blue,
            unselectedItemColor: Colors.black,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Category',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Favorite',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Account',
              ),
            ],
          ),
        );
      },
    );
  }
}
