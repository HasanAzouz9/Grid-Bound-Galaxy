import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:gridbound_galaxy/modules/towers/domain/entities/projectile_explosion_entity.dart';

import '../grid_bound_galaxy_game.dart';

// class ProjectileExplosionComponent extends SpriteAnimationComponent with HasGameReference<GridBoundGalaxyGame> {
//   final ProjectileExplosionEntity explosion;

//   ProjectileExplosionComponent({required this.explosion, required super.position})
//     : super(priority: 25, size: Vector2(explosion.sizeWidth, explosion.sizeHeight), removeOnFinish: true);

//   @override
//   FutureOr<void> onLoad() {
//     _loadExplosion();
//     return super.onLoad();
//   }

//   void _loadExplosion() {
//     final sprite = game.images.fromCache(explosion.sprite);

//     final spriteAnimation = SpriteAnimationData.sequenced(
//       amount: 1,
//       stepTime: 1,
//       textureSize: Vector2(explosion.textureSizeWidth.toDouble(), explosion.textureSizeHeight.toDouble()),
//       loop: false,
//     );

//     animation = SpriteAnimation.fromFrameData(sprite, spriteAnimation);
//   }
// }

enum ExplosionEnum { on }

class ProjectileExplosionComponent extends SpriteAnimationGroupComponent with HasGameReference<GridBoundGalaxyGame> {
  final ProjectileExplosionEntity explosion;

  ProjectileExplosionComponent({required this.explosion, required super.position})
    : super(
        size: Vector2(explosion.sizeWidth, explosion.sizeHeight),
        anchor: .center,
        removeOnFinish: {ExplosionEnum.on: true},
      );

  @override
  FutureOr<void> onLoad() {
    _loadExplosion();
    return super.onLoad();
  }

  void _loadExplosion() {
    final sprite = game.images.fromCache(explosion.sprite);

    final spriteAnimation = SpriteAnimationData.range(
      start: explosion.start,
      end: explosion.stop,
      amount: explosion.amount,
      amountPerRow: explosion.amountPerRow,
      stepTimes: explosion.stepTimes,

      textureSize: Vector2(explosion.textureSizeWidth.toDouble(), explosion.textureSizeHeight.toDouble()),
      loop: false,
    );

    animations = {ExplosionEnum.on: SpriteAnimation.fromFrameData(sprite, spriteAnimation)};
    current = ExplosionEnum.on;
  }
}
