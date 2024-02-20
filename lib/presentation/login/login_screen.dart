import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neko_coffee/features/login/index.dart';
import 'package:neko_coffee/features/login/login_event.dart';
import 'package:neko_coffee/routes/app_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passCtrl = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final loginBloc = LoginBloc(InitialLoginState());
  String? errorEmail, errorPassword;
  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      bloc: loginBloc,
      listener: (context, state) {
        if (state is ErrorInputEmailState) {
          setState(() => errorEmail = state.errorMsg);
        }
        if (state is ErrorInputPasswordState) {
          setState(() => errorPassword = state.errorMsg);
        }
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                SizedBox(height: 250.h),
                Text('LOGIN FORM'),
                Text('Email/Phone'),
                TextFormField(
                  controller: emailCtrl,
                  onChanged: (value) => loginBloc.add(
                    InputEmailEvent(email: value),
                  ),
                  validator: (value) => errorEmail,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                Text('Password'),
                TextFormField(
                  controller: passCtrl,
                  validator: (value) => errorPassword,
                  onChanged: (value) => loginBloc.add(
                    InputPasswordEvent(password: value),
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {}
                  },
                  child: Text('Login'),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, SIGNUP_ROUTE),
                  child: Text('Sign Up'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
