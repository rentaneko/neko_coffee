// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neko_coffee/core/common/widgets/failure.widget.dart';
import 'package:neko_coffee/core/common/widgets/loading.widget.dart';
import 'package:neko_coffee/features/auth/presentation/pages/signup_page.dart';
import 'package:neko_coffee/features/blog/presentation/page/blog.screen.dart';
import '../../../../core/theme/app_pallete.dart';
import '../../../../core/common/widgets/dialog.widget.dart';
import '../../bloc/auth_bloc.dart';
import '../widgets/auth_field.dart';
import '../widgets/auth_gradient_button.dart';

class LoginPage extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (_) => LoginPage());
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    passwordController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: BlocConsumer<AuthBloc, AuthState>(
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

            if (state is AuthFailureState) {
              showErrorDialog(
                context,
                title: 'Error',
                descripsion: FailureWidget(error: state.serverError),
              );
            }
          },
          builder: (_, state) {
            switch (state.runtimeType) {
              case AuthFailureState:
                state as AuthFailureState;
                return FailureWidget(error: state.serverError);

              case AuthSuccessState:
                return _body();

              case AuthInitialState:
                return LoadingWidget();

              case AuthUserIsNotLogged:
                return _body();

              default:
                return _body();
            }
          },
        ),
      ),
    );
  }

  Widget _body() {
    return Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Sign In',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppPallete.white,
              fontSize: 50.spMin,
            ),
          ),
          SizedBox(height: 32.h),
          AuthField(hintText: 'Email', controller: emailController),
          SizedBox(height: 16.h),
          AuthField(
            hintText: 'Password',
            isHide: true,
            controller: passwordController,
          ),
          SizedBox(height: 32.h),
          AuthGradientButton(
            title: 'Login',
            onPess: () {
              if (formKey.currentState!.validate()) {
                context.read<AuthBloc>().add(
                      AuthLogin(
                        email: emailController.text.trim(),
                        password: passwordController.text.trim(),
                      ),
                    );
              }
            },
          ),
          SizedBox(height: 16.h),
          GestureDetector(
            onTap: () => Navigator.of(context).push(SignUpPage.route()),
            child: RichText(
              text: TextSpan(
                text: 'Don\'t have an account? ',
                style: Theme.of(context).textTheme.titleMedium,
                children: [
                  TextSpan(
                    text: 'Sign Up',
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
