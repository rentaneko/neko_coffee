import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neko_coffee/common/widgets/dialog.widget.dart';
import 'package:neko_coffee/features/account/bloc/index.dart';
import 'package:neko_coffee/features/login/bloc/index.dart';
import 'package:neko_coffee/routes/app_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, this.newBloc});
  final dynamic newBloc;
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
        if (state is ErrorLoginState) {
          showErrorDialog(context, title: state.errorMsg);
        }
        if (state is SuccessLoginState) {
          Navigator.of(context).pop();
          if (widget.newBloc is AccountBloc) {
            widget.newBloc.add(InitialAccountEvent());
          }
        }
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                SizedBox(height: 250.h),
                const Text('LOGIN FORM'),
                const Text('Email/Phone'),
                TextFormField(
                  controller: emailCtrl,
                  onChanged: (value) => loginBloc.add(
                    InputEmailEvent(email: value),
                  ),
                  validator: (value) => errorEmail,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                const Text('Password'),
                TextFormField(
                  controller: passCtrl,
                  validator: (value) => errorPassword,
                  onChanged: (value) => loginBloc.add(
                    InputPasswordEvent(password: value),
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      loginBloc.add(
                        LoginButtonClickedEvent(
                          email: emailCtrl.text.trim(),
                          password: passCtrl.text.trim(),
                        ),
                      );
                    }
                  },
                  child: const Text('Login'),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, SIGNUP_ROUTE),
                  child: const Text('Sign Up'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
