import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neko_coffee/features/auth/bloc/auth_bloc.dart';
import 'package:neko_coffee/features/auth/bloc/auth_state.dart';
import 'package:neko_coffee/features/auth/bloc/index.dart';
import 'package:neko_coffee/features/home/bloc/index.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final AuthBloc authBloc = AuthBloc(const InitializedAuthState());

  @override
  void initState() {
    super.initState();
    authBloc.add(InitializedAuthEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthenticationState>(
        bloc: authBloc,
        listener: (context, state) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const HomeScreen()));
        },
        builder: (context, state) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator.adaptive()),
          );
        },
      ),
      bottomNavigationBar: ElevatedButton(
        onPressed: () => authBloc.add(InitializedAuthEvent()),
        child: Text('AUTH STATE'),
      ),
    );
  }
}
