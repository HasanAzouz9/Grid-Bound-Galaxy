import 'dart:ui';

import 'package:flame/components.dart';

class RangeCircle extends CircleComponent {
  RangeCircle({required double radius})
    : super(
        radius: radius,
        anchor: Anchor.center,
        paint: Paint()..color = const Color.fromARGB(60, 255, 0, 0),
      );

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    // Add a simple outline
    canvas.drawCircle(
      Offset(radius, radius),
      radius,
      Paint()
        ..color = const Color.fromARGB(150, 255, 0, 0)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2,
    );
  }
}
