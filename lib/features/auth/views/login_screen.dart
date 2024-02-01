import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neko_coffee/common/widgets/dialog.widget.dart';
import 'package:neko_coffee/features/auth/bloc/auth_bloc.dart';
import 'package:neko_coffee/features/auth/bloc/auth_event.dart';
import 'package:neko_coffee/features/auth/bloc/auth_state.dart';
import 'package:neko_coffee/routes/app_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
//
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  AuthBloc authBloc = AuthBloc(const InitializedAuthState());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LOG IN'),
        centerTitle: true,
      ),
      body: BlocListener<AuthBloc, AuthenticationState>(
        bloc: authBloc,
        listener: (context, state) {
          if (state is ErrorAuthState) {
            showFlashDialog(context, title: state.errorMessage);
            authBloc.add(WaitingAuthEvent());
          } else if (state is SignInSuccessState) {
            Navigator.popAndPushNamed(context, CART_ROUTE);
          }
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text('Email'),
              SizedBox(height: 12.h),
              TextFormField(
                controller: emailCtrl,
                onFieldSubmitted: (value) => authBloc.add(
                  InputEmailEvent(email: emailCtrl.text.trim()),
                ),
              ),
              SizedBox(height: 20.h),
              Text('Password'),
              SizedBox(height: 12.h),
              TextFormField(
                controller: passCtrl,
                onFieldSubmitted: (value) => authBloc.add(
                  InputPasswordEvent(password: passCtrl.text.trim()),
                ),
              ),
              SizedBox(height: 24.h),
              ElevatedButton(
                onPressed: () => authBloc.add(LoginButtonActionEvent()),
                child: Text('LOGIN'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
