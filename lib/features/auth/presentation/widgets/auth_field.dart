import 'package:flutter/material.dart';

class AuthField extends StatelessWidget {
  final String hintText;
  final bool isHide;
  final TextEditingController controller;
  const AuthField(
      {super.key,
      required this.hintText,
      this.isHide = false,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(hintText: hintText),
      obscureText: isHide,
      controller: controller,
      validator: (value) {
        if (value!.isEmpty) {
          return '$hintText is missing';
        }
        return null;
      },
    );
  }
}
