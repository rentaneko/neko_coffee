import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  //
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text('email'),
            TextFormField(
              controller: emailCtrl,
            ),
            Text('password'),
            TextFormField(
              controller: passCtrl,
            ),
            MaterialButton(
              onPressed: () {},
              child: Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}
