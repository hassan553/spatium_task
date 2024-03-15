import 'dart:math' as math;

import 'package:flutter/material.dart';

class ProgressBackgroundCircleShape extends CustomPainter {
  final bool? isBackground;
  final double? arc;
  final Color? progressColor;
  ProgressBackgroundCircleShape({
    this.isBackground,
    this.arc,
    this.progressColor,
  });
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..strokeCap = StrokeCap.round
      ..color = progressColor!
      ..style = PaintingStyle.stroke
      ..strokeWidth = 50;

    const rect = Rect.fromLTRB(0, 0, 300, 300);

    const startAngle = math.pi;
    final sweepAngle = arc ?? math.pi;
    canvas.drawArc(rect, startAngle, sweepAngle, false, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
