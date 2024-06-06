// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neko_coffee/core/routes/route_name.dart';
import 'package:neko_coffee/core/theme/app_pallete.dart';
import 'package:neko_coffee/core/common/widgets/dialog.widget.dart';
import 'package:neko_coffee/core/common/widgets/failure.widget.dart';
import 'package:neko_coffee/features/auth/presentation/widgets/auth_field.dart';
import '../../../../core/theme/app_style.dart';
import '../../../blog/presentation/page/blog.screen.dart';
import '../../bloc/auth_bloc.dart';

class SignUpPage extends StatefulWidget {
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
      backgroundColor: AppPallete.light,
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
          Image.asset(
            'assets/images/logo-horizontal.png',
            width: 200.w,
            height: 220.w,
          ),
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
          ElevatedButton(
            child: Text(
              'Sign up',
              style: mediumOswald(size: 16, color: AppPallete.light),
            ),
            onPressed: () {
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
          TextButton(
            onPressed: () => Navigator.of(context)
                .pushReplacementNamed(RoutesName.loginPath),
            child: RichText(
              text: TextSpan(
                text: 'Already have an account? ',
                style: mediumOswald(size: 14, color: AppPallete.dark),
                children: [
                  TextSpan(
                    text: 'Sign In',
                    style: mediumOswald(size: 14, color: AppPallete.brand),
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
