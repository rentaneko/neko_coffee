import 'package:flutter/material.dart';
import '../../theme/app_pallete.dart';

class BackgroundPainter extends CustomPainter {
  BackgroundPainter({super.repaint});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = AppPallete.brand.withOpacity(0.7)
      ..style = PaintingStyle.fill;

    var path = Path();
    path.moveTo(0, size.height * 0.75);
    path.quadraticBezierTo(
      size.width / 2.5,
      size.height / 1.4,
      size.width,
      size.height * 0.45,
    );
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, size.height * 0.75);

    canvas.drawPath(path, paint);

    // var circle = Paint()..color = AppPallete.white;
    // final textPainter = TextPainter(
    //   text: TextSpan(
    //     text: button.label,
    //     style: const TextStyle(
    //       color: Colors.red,
    //       fontSize: 14,
    //       fontWeight: FontWeight.w600,
    //       fontFamily: 'Lato',
    //     ),
    //   ),
    //   textDirection: TextDirection.ltr,
    // );
    // canvas.drawCircle(
    //   Offset(size.width - 50.w, size.height * 0.65),
    //   40,
    //   circle,
    // );
    // textPainter.layout(minWidth: 10, maxWidth: 30);
    // textPainter.paint(canvas, Offset(size.width - 60.w, size.height * 0.64));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class Button {
  final String label;
  final VoidCallback onPressed;

  Button({required this.label, required this.onPressed});
}
