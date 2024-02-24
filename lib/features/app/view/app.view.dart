import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neko_coffee/features/account/bloc/index.dart';
import 'package:neko_coffee/features/app/bloc/index.dart';
import 'package:neko_coffee/features/cart/bloc/index.dart';
import 'package:neko_coffee/features/category/bloc/index.dart';
import 'package:neko_coffee/features/favorite/bloc/index.dart';
import 'package:neko_coffee/features/home/bloc/home_bloc.dart';
import 'package:neko_coffee/features/home/bloc/home_event.dart';
import 'package:neko_coffee/features/home/bloc/home_state.dart';
import 'package:neko_coffee/features/home/view/home.view.dart';

class AppScreen extends StatefulWidget {
  const AppScreen({super.key});

  @override
  State<AppScreen> createState() => _AppScreenState();
}

class _AppScreenState extends State<AppScreen> {
  final appBloc = AppBloc(InitialAppState());
  final homeBloc = HomeBloc(InitialHomeState());
  final categoryBloc = CategoryBloc(InitialCategoryState());
  final favouriteBloc = FavouriteBloc(FavouriteInitialState());
  final accountBloc = AccountBloc(InitialAccountState());
  final cartBloc = CartBloc(InitialCartState());
  int selectedIndex = 0;

  @override
  void initState() {
    homeBloc.add(InitialHomeEvent());
    categoryBloc.add(InitialCategoryEvent());
    favouriteBloc.add(FavouriteInitialEvent());
    accountBloc.add(InitialAccountEvent());
    cartBloc.add(InitialCartEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppBloc, AppState>(
      bloc: appBloc,
      listenWhen: (previous, current) => current is AppActionState,
      buildWhen: (previous, current) => current is! AppActionState,
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: IndexedStack(
            index: selectedIndex,
            children: [
              HomeScreen(homeBloc: homeBloc, favouriteBloc: favouriteBloc),
              CategoryScreen(categoryBloc: categoryBloc),
              FavoriteScreen(favouriteBloc: favouriteBloc),
              AccountScreen(accountBloc: accountBloc),
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
