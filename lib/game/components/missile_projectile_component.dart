import 'dart:math' show atan2;

import 'package:flame/components.dart' show HasWorldReference, Vector2;
import 'package:gridbound_galaxy/game/components/projectile_explosion_component.dart';

import 'base_projectile_component.dart';
import 'level_component.dart';

class MissileProjectileComponent extends BaseProjectile with HasWorldReference<LevelComponent> {
  late final Vector2 _moveDirection;

  MissileProjectileComponent({
    required super.projectile,
    required super.explosion,
    required super.target,
    required super.position,
  }) {
    _moveDirection = (targetLocation - position).normalized();
    angle = atan2(_moveDirection.y, _moveDirection.x);
  }

  @override
  void update(double dt) {
    super.update(dt);
    final step = projectile.speed * dt;
    final dist = position.distanceTo(targetLocation);

    if (step >= dist) {
      position.setFrom(targetLocation);
      world.add(ProjectileExplosionComponent(explosion: explosion, position: position));
      removeFromParent();
    } else {
      position += _moveDirection * step;
    }
  }
}
