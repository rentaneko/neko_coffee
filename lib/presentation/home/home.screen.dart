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
      listener: (context, state) {},
      builder: (context, state) {
        switch (state.runtimeType) {
          case ErrorHomeState:
            return FailurePage(error: (state as ErrorHomeState).errorMessage);

          case UnAuthenticatedHomeState:
            return HomeWidget.unAuthenticatedScreen(
                context: context, state: state as UnAuthenticatedHomeState);

          case AuthenticatedHomeState:
            return HomeWidget.authenticatedScreen(
                context: context, state: state as AuthenticatedHomeState);

          default:
            return const LoadingPage();
        }
      },
    );
  }
}
