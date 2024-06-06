import 'package:flutter/material.dart';

class AuthField extends StatefulWidget {
  final String hintText;
  final bool isHide;
  final TextEditingController controller;
  const AuthField(
      {super.key,
      required this.hintText,
      this.isHide = false,
      required this.controller});

  @override
  State<AuthField> createState() => _AuthFieldState();
}

class _AuthFieldState extends State<AuthField> {
  bool isShow = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: 'Input your ${widget.hintText}',
        suffixIcon: widget.isHide
            ? IconButton(
                onPressed: () => setState(() => isShow = !isShow),
                icon: !isShow
                    ? const Icon(Icons.visibility_off)
                    : const Icon(Icons.visibility),
              )
            : null,
      ),
      obscureText: widget.isHide ? (!isShow ? true : false) : false,
      controller: widget.controller,
      validator: (value) {
        if (value!.isEmpty) {
          // return '$hintText is missing';
          return null;
        }
        if (widget.isHide == true) {
          if (value.length < 6) {
            return '${widget.hintText} must be at least 6 characters';
          }
          if (value.length > 20) {
            return '${widget.hintText} maximum 20 characters';
          }
        } else {
          if (value.length < 6) {
            return '${widget.hintText} must be at least 6 characters';
          }
          if (value.length > 30) {
            return '${widget.hintText} maximum 30 characters';
          }
        }
        return null;
      },
    );
  }
}
