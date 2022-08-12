import 'package:flutter/material.dart';
import '../../../config/app_colors.dart';

class HeaderCurvedContainer extends CustomPainter {
  const HeaderCurvedContainer({
   this.customColor,
  });

  final Color? customColor;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()..color = customColor ?? AppColors.primaryColor;
    final Path path = Path()
      ..relativeLineTo(0, 150)
      ..quadraticBezierTo(size.width / 2, 225, size.width, 150)
      ..relativeLineTo(0, -150)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
