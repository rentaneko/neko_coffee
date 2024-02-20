import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neko_coffee/common/widgets/failure.widget.dart';
import 'package:neko_coffee/common/widgets/loading.widget.dart';
import 'package:neko_coffee/features/home/home_bloc.dart';
import 'package:neko_coffee/features/home/home_event.dart';
import 'package:neko_coffee/features/home/home_state.dart';
import 'package:neko_coffee/presentation/home/home.widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final homeBloc = HomeBloc(InitialHomeState());

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
        if (state is LoadingHomeState) {}
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case ErrorHomeState:
            return FailurePage(error: (state as ErrorHomeState).errorMessage);

          case UnAuthenticatedHomeState:
            state as UnAuthenticatedHomeState;
            return Scaffold(
              appBar: AppBar(title: Text('Home UnAu')),
              drawer: HomeWidget.drawer(context, state.cates, homeBloc),
              body: HomeWidget.unAuthenticatedScreen(products: state.products),
            );

          case AuthenticatedHomeState:
            state as AuthenticatedHomeState;
            return Scaffold(
              appBar: AppBar(
                title: Text('Home Au'),
                actions: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(CupertinoIcons.cart),
                  ),
                ],
              ),
              drawer: HomeWidget.drawer(context, state.cates, homeBloc),
              body: HomeWidget.authenticatedScreen(products: state.products),
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
