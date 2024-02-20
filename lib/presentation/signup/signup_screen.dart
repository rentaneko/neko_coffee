import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neko_coffee/common/widgets/dialog.widget.dart';
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
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final SignUpBloc signUpBloc = SignUpBloc(InitialSignUpState());
  String? errorEmail, errorPassword;

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpBloc, SignUpState>(
      bloc: signUpBloc,
      // listenWhen: (previous, current) => current is! SignUpActionState,

      listener: (context, state) {
        if (state is ErrorInputEmailSignUpState) {
          setState(() => errorEmail = state.errorMsg);
        }
        if (state is ErrorInputPasswordSignUpState) {
          setState(() => errorPassword = state.errorMsg);
        }
        if (state is SuccessSignUpState) {
          Navigator.of(context).pop();
          Navigator.of(context).pop();
          showSuccessDialog(context, title: 'Sign Up Successfull');
        }

        if (state is LoadingSignUpState) {
          showLoadingDialog(context);
        }
        if (state is ErrorSignUpState) {
          showFlashDialog(context, title: 'Something was wrong');
        }
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                SizedBox(height: 250.h),
                Text('Sign Up'),
                Text('Email/Phone'),
                TextFormField(
                  controller: emailCtrl,
                  onChanged: (value) =>
                      signUpBloc.add(InputEmailSignupEvent(email: value)),
                  validator: (value) => errorEmail,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                Text('Password'),
                TextFormField(
                  controller: passCtrl,
                  onChanged: (value) =>
                      signUpBloc.add(InputPasswordSignupEvent(password: value)),
                  validator: (value) => errorPassword,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
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
