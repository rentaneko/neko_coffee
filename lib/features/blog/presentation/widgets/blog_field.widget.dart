import 'package:flutter/material.dart';

Widget inputField(
    {required String title,
    required TextEditingController controller,
    bool isContent = false}) {
  return TextFormField(
    decoration: InputDecoration(hintText: title),
    controller: controller,
    validator: (value) {
      if (value!.isEmpty) {
        return null;
      } else {
        if (value.length < 6) {
          return 'Your $title required as least 6 character';
        }

        if (isContent == false && value.length > 30) {
          return 'Your $title is too long';
        }
      }
      return null;
    },
  );
}
