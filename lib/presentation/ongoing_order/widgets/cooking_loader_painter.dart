import 'package:flutter/material.dart';
import 'dart:math' as math;

class CookingLoaderPainter extends CustomPainter {
  final double animationValue;
  final Color color;

  CookingLoaderPainter({
    required this.animationValue,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0
      ..strokeCap = StrokeCap.round;

    // Pastikan menggambar berdasarkan parameter 'size' yang diterima
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) / 2;

    // Lingkaran Background (Track)
    canvas.drawCircle(
      center,
      radius,
      paint..color = color.withValues(alpha: 0.1),
    );

    // Animasi Progress Arc
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2 + (animationValue * 2 * math.pi),
      math.pi / 2,
      false,
      paint..color = color,
    );
  }

  @override
  bool shouldRepaint(covariant CookingLoaderPainter oldDelegate) {
    return oldDelegate.animationValue != animationValue;
  }
}