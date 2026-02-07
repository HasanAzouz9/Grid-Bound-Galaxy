import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame_riverpod/flame_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:gridbound_galaxy/game/components/level_component.dart';
import 'package:gridbound_galaxy/game/managers/game_run_time_stats.dart';
import 'package:gridbound_galaxy/modules/towers/domain/entities/tower_entity.dart';

import 'tower_component.dart';

class TileHighlight extends PositionComponent
    with TapCallbacks, HasWorldReference<LevelComponent>, RiverpodComponentMixin {
  final TowerEntity towerToPlace;

  TileHighlight({
    required super.position,
    required this.towerToPlace,
    super.priority,
  }) : super(
         size: Vector2(128, 128),
         anchor: Anchor.center,
       );

  @override
  Future<void> onLoad() async {
    // Taps won't register reliably without a hitbox
    add(RectangleHitbox());
  }

  @override
  void onTapDown(TapDownEvent event) {
    world.add(
      TowerComponent(
        tower: towerToPlace,
        position: position.clone(),
      ),
    );
    ref.read(GameSessionController.provider.notifier).decreaseGold(amount: towerToPlace.cost);
    // Clean up highlights
    world.exitBuildMode();
  }

  @override
  void render(Canvas canvas) {
    final rect = size.toRect();
    final paint = Paint()
      ..color = Colors.green.withAlpha(25)
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = Colors.greenAccent
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    canvas.drawRect(rect, paint);
    canvas.drawRect(rect, borderPaint);
  }
}
