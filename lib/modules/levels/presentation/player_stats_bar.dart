import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gridbound_galaxy/core/extensions/app_dimensions.extension.dart';
import 'package:gridbound_galaxy/game/managers/game_run_time_stats.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../core/extensions/context.extensions.dart';

class PlayerStatsBar extends ConsumerWidget {
  const PlayerStatsBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameSession = ref.watch(GameSessionController.provider);
    return Align(
      alignment: .topCenter,
      child: Container(
        width: 100.w,
        height: 10.h,
        margin: context.padding8,
        child: Row(
          mainAxisAlignment: .center,
          children: [
            CustomPaint(
              painter: BeveledSpecificBorderPainter(
                color: context.colorScheme.primaryContainer,
                strokeColor: context.colorScheme.primary,
                width: 2,
                isLeft: true,
              ),
              child: SizedBox(
                width: 40.w,
                height: 6.h,
                child: Center(
                  child: Text('Gold: ${gameSession.playerGold}'),
                ),
              ),
            ),
            Container(
              width: 8.w,
              height: 10.h,
              decoration: ShapeDecoration(
                color: context.colorScheme.primaryContainer,
                shape: BeveledRectangleBorder(
                  borderRadius: context.radius8,
                ),
              ),
              child: Center(child: Text('Life: ${gameSession.playerHealth}')),
            ),
            CustomPaint(
              painter: BeveledSpecificBorderPainter(
                color: context.colorScheme.primaryContainer,
                strokeColor: context.colorScheme.primary,
                width: 2,
                isLeft: false,
              ),
              child: SizedBox(
                width: 40.w,
                height: 6.h,
                child: Center(
                  child: Text('Wave: ${gameSession.currentWave} / ${gameSession.totalWaves}'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BeveledSpecificBorderPainter extends CustomPainter {
  final Color color;
  final Color strokeColor;
  final double width;
  final bool isLeft;

  BeveledSpecificBorderPainter({
    required this.color,
    required this.width,
    required this.isLeft,
    required this.strokeColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final fillPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final strokePaint = Paint()
      ..color = strokeColor
      ..strokeWidth = width
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.square;

    final path = Path();

    if (isLeft) {
      path.moveTo(size.width, 0);
      path.lineTo(size.width, size.height);
      path.lineTo(24, size.height);
      path.lineTo(0, 0);
    } else {
      path.moveTo(0, 0);
      path.lineTo(0, size.height);
      path.lineTo(size.width - 24, size.height);
      path.lineTo(size.width, 0);
    }

    canvas.drawPath(path, fillPaint);

    final strokePath = Path();

    if (isLeft) {
      strokePath.moveTo(size.width, size.height);
      strokePath.lineTo(24, size.height);
      strokePath.lineTo(0, 0);
    } else {
      strokePath.moveTo(0, size.height);
      strokePath.lineTo(size.width - 24, size.height);
      strokePath.lineTo(size.width, 0);
    }

    canvas.drawPath(strokePath, strokePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
