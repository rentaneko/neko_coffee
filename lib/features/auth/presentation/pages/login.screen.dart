import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neko_coffee/core/common/widgets/failure.widget.dart';
import 'package:neko_coffee/core/common/widgets/loading.widget.dart';
import 'package:neko_coffee/core/routes/route_name.dart';
import 'package:neko_coffee/core/theme/app_pallete.dart';
import 'package:neko_coffee/core/theme/app_style.dart';
import '../../../../core/common/widgets/dialog.widget.dart';
import '../../bloc/auth_bloc.dart';
import '../widgets/auth_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
              Navigator.of(context).pushNamedAndRemoveUntil(
                  RoutesName.appPath, (route) => false);
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
                return Form(
                  key: formKey,
                  child: SingleChildScrollView(child: _body()),
                );
              case AuthInitialState:
                return LoadingWidget();

              case AuthUserIsNotLogged:
                return Form(
                  key: formKey,
                  child: SingleChildScrollView(child: _body()),
                );

              default:
                return Form(
                  key: formKey,
                  child: SingleChildScrollView(child: _body()),
                );
            }
          },
        ),
      ),
    );
  }

  Widget _body() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/images/logo-horizontal.png',
          width: 200.w,
          height: 220.w,
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
        ElevatedButton(
          child: Text(
            'Login',
            style: mediumOswald(size: 14, color: AppPallete.light),
          ),
          onPressed: () {
            if (emailController.text.isEmpty &&
                passwordController.text.isEmpty) {
              showErrorDialog(
                context,
                title: 'Warning',
                descripsion: Text(
                  'Complete your data first',
                  style: mediumOswald(size: 14, color: AppPallete.dark),
                ),
              );
            } else {
              if (formKey.currentState!.validate()) {
                context.read<AuthBloc>().add(
                      AuthLogin(
                        email: emailController.text.trim(),
                        password: passwordController.text.trim(),
                      ),
                    );
              }
            }
          },
        ),
        SizedBox(height: 16.h),
        GestureDetector(
          onTap: () => Navigator.of(context).pushReplacementNamed('/signup'),
          child: RichText(
            text: TextSpan(
              text: 'Don\'t have an account? ',
              style: mediumOswald(size: 14, color: AppPallete.dark),
              children: [
                TextSpan(
                  text: 'Sign Up',
                  style: mediumOswald(size: 14, color: AppPallete.brand),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
