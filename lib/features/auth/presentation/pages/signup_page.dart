// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neko_coffee/core/theme/app_pallete.dart';
import 'package:neko_coffee/core/common/widgets/dialog.widget.dart';
import 'package:neko_coffee/core/common/widgets/failure.widget.dart';
import 'package:neko_coffee/features/auth/presentation/widgets/auth_field.dart';
import 'package:neko_coffee/features/auth/presentation/widgets/auth_gradient_button.dart';

import '../../../blog/presentation/page/blog.screen.dart';
import '../../bloc/auth_bloc.dart';

class SignUpPage extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (_) => SignUpPage());

  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    passwordController.dispose();
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Form(
          key: formKey,
          child: BlocConsumer<AuthBloc, AuthState>(
            bloc: context.watch<AuthBloc>(),
            listenWhen: (previous, current) => current is! AuthActionEvent,
            buildWhen: (previous, current) => current is AuthEvent,
            listener: (_, state) {
              if (state is AuthSuccessState) {
                Navigator.of(context).pop();
                Navigator.of(context)
                    .pushAndRemoveUntil(BlogScreen.route(), (route) => false);
              }
              if (state is AuthLoadingState) {
                showLoadingDialog(context, title: 'Loading...');
              }
            },
            builder: (context, state) {
              switch (state.runtimeType) {
                case AuthFailureState:
                  state as AuthFailureState;
                  return FailureWidget(error: state.serverError);
                case AuthSuccessState:
                  return _body();
                case AuthInitialState:
                  return _body();
                default:
                  return SizedBox();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Sign Up',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppPallete.white,
              fontSize: 50.sp,
            ),
          ),
          SizedBox(height: 32.h),
          AuthField(hintText: 'Name', controller: nameController),
          SizedBox(height: 16.h),
          AuthField(hintText: 'Phone', controller: phoneController),
          SizedBox(height: 16.h),
          AuthField(hintText: 'Email', controller: emailController),
          SizedBox(height: 16.h),
          AuthField(
            hintText: 'Password',
            isHide: true,
            controller: passwordController,
          ),
          SizedBox(height: 32.h),
          AuthGradientButton(
            title: 'Sign up',
            onPess: () {
              if (formKey.currentState!.validate()) {
                context.read<AuthBloc>().add(AuthSignUp(
                      email: emailController.text.trim(),
                      password: passwordController.text.trim(),
                      phone: phoneController.text.trim(),
                      fullname: nameController.text.trim(),
                    ));
              }
            },
          ),
          SizedBox(height: 16.h),
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: RichText(
              text: TextSpan(
                text: 'Already have an account? ',
                style: Theme.of(context).textTheme.titleMedium,
                children: [
                  TextSpan(
                    text: 'Sign In',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: AppPallete.gradient2,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
