import 'package:flutter/material.dart';
import 'cooking_loader_painter.dart';

class CookingLoaderAnimation extends StatelessWidget {
  final AnimationController controller;
  final double? size;

  const CookingLoaderAnimation({
    super.key,
    this.size,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        // Menggunakan SizedBox untuk memaksakan ukuran box
        return SizedBox(
          width: size ?? 80, // Sesuaikan ukuran yang diinginkan
          height: size ?? 80,
          child: CustomPaint(
            painter: CookingLoaderPainter(
              animationValue: controller.value,
              color: Theme.of(context).colorScheme.primary,
            ),
            // Jika ada icon di tengah, gunakan Stack agar tidak mengganggu layout CustomPaint
            child: Center(
              child: Icon(
                Icons.restaurant,
                size: 24, // Sesuaikan agar pas di dalam lingkaran
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        );
      },
    );
  }
}
