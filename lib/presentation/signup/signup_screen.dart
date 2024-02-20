import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neko_coffee/features/signup/index.dart';
import 'package:neko_coffee/features/signup/signup_event.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final SignUpBloc signUpBloc = SignUpBloc(InitialSignUpState());
  String? errorEmail, errorPassword;

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpBloc, SignUpState>(
      bloc: signUpBloc,
      listenWhen: (previous, current) => current is! SignUpActionState,
      listener: (context, state) {
        if (state is ErrorInputEmailSignUpState) {
          setState(() => errorEmail = state.errorMsg);
        }
        if (state is ErrorInputPasswordSignUpState) {
          setState(() => errorPassword = state.errorMsg);
        }
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Text('Sign Up'),
                Text('Email/Phone'),
                TextFormField(
                  controller: emailCtrl,
                  onChanged: (value) =>
                      signUpBloc.add(InputEmailSignupEvent(email: value)),
                  validator: (value) => errorEmail,
                ),
                Text('Password'),
                TextFormField(
                  controller: passCtrl,
                  onChanged: (value) =>
                      signUpBloc.add(InputPasswordSignupEvent(password: value)),
                  validator: (value) => errorPassword,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      signUpBloc.add(SignUpButtonClickedEvent(
                        email: emailCtrl.text.trim(),
                        password: passCtrl.text.trim(),
                      ));
                    }
                  },
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
