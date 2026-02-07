import 'dart:async';
import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame_riverpod/flame_riverpod.dart';
import 'package:gridbound_galaxy/core/enums/enemy_state.dart';
import 'package:gridbound_galaxy/modules/enemies/domain/entities/enemy_entity.dart';
import 'package:gridbound_galaxy/game/grid_bound_galaxy_game.dart';

import '../managers/game_run_time_stats.dart';

class EnemyComponent extends SpriteAnimationGroupComponent
    with HasGameReference<GridBoundGalaxyGame>, RiverpodComponentMixin {
  final List<Vector2> pathPoints;
  final EnemyEntity enemyEntity;
  int currentIndex = 0;
  bool isDead = false;
  EnemyComponent({required this.enemyEntity, required this.pathPoints})
    : super(
        position: Vector2.copy(pathPoints.first),
        size: enemyEntity.size,
        anchor: Anchor.center,
        priority: 10,
      );

  @override
  FutureOr<void> onLoad() {
    _loadEnemy();
    return super.onLoad();
  }

  void _reachGoal() {
    if (isDead) return;
    isDead = true;
    removeFromParent();
    if (isMounted) {
      game.ref.read(GameSessionController.provider.notifier).decreaseHealth(amount: 1);
      final playerHealth = ref.read(GameSessionController.provider).playerHealth;
      if (playerHealth == 0) {
        game.overlays.add('PlayerLostOverlay');
        game.pauseEngine();
      }
    }
  }

  @override
  void update(double dt) {
    _moveEnemy(dt);
    super.update(dt);
  }

  void _loadEnemy() {
    final idleEnemy = SpriteAnimation.fromFrameData(
      game.images.fromCache(enemyEntity.idleSprite),
      SpriteAnimationData.range(
        start: 0,
        end: 0,
        amount: 1,
        stepTimes: [1],

        textureSize: enemyEntity.movementSpriteTextureSize,
      ),
    );
    animations = {EnemyState.idle: idleEnemy, EnemyState.moving: idleEnemy};
    current = EnemyState.idle;
  }

  void _moveEnemy(double dt) {
    if (pathPoints.isEmpty) return;
    if (currentIndex >= pathPoints.length) {
      current = EnemyState.idle;
      return;
    }

    final newPoint = pathPoints[currentIndex];
    final direction = newPoint - position;

    if (direction.length < 2) {
      currentIndex++;

      if (currentIndex >= pathPoints.length) {
        position = newPoint;
        _reachGoal();
        current = EnemyState.idle;
        return;
      }

      return;
    }

    current = EnemyState.moving;
    angle = atan2(direction.y, direction.x);
    direction.normalize();
    position += direction * enemyEntity.speed.toDouble() * dt;
  }
}
