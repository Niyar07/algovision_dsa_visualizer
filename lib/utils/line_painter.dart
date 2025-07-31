import 'package:flutter/material.dart';

class LinePainter extends CustomPainter {
  final bool isLeft;

  LinePainter({required this.isLeft});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.grey[600]!
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    if (isLeft) {
      canvas.drawLine(
        Offset(size.width, 0),
        Offset(size.width * 0.5, size.height),
        paint,
      );
    } else {
      canvas.drawLine(
        Offset(0, 0),
        Offset(size.width * 0.5, size.height),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
