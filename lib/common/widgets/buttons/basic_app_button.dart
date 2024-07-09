import 'package:flutter/material.dart';
import 'package:neko_coffee/common/helpers/is_dark_mode.dart';

class BasicAppButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final double? height;
  const BasicAppButton(
      {super.key, required this.onPressed, required this.title, this.height});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: Size.fromHeight(height ?? 55),
        textStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: context.isDarkMode ? Colors.white : Colors.black,
        ),
      ),
      child: Text(title),
    );
  }
}
