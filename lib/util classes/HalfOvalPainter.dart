import 'package:flutter/cupertino.dart';

class HalfOvalPainter extends CustomPainter {
  final Color fillColor;
  final Color borderColor;
  final double borderWidth;

  HalfOvalPainter({
    required this.fillColor,
    required this.borderColor,
    required this.borderWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint fillPaint = Paint()..color = fillColor;
    final Paint borderPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth;

    final Rect rect = Rect.fromPoints(Offset(0, 0), Offset(size.width, size.height * 2));

    canvas.drawArc(rect, 0, -3.14, true, fillPaint);
    canvas.drawArc(rect, 0, -3.14, true, borderPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}