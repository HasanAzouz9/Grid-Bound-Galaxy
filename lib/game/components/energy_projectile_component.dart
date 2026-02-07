import 'dart:math';

import 'package:flame/components.dart' show HasWorldReference, Vector2;
import 'package:gridbound_galaxy/game/components/base_projectile_component.dart';

import 'level_component.dart';
import 'projectile_explosion_component.dart';

class EnergyProjectile extends BaseProjectile with HasWorldReference<LevelComponent> {
  double _lifeTime = 0.1;
  late final Vector2 _targetLocation;
  late final Vector2 _moveDirection;
  late Vector2 _muzzlePosition;
  EnergyProjectile({
    required super.projectile,
    required super.target,
    required super.explosion,
    required super.position,
  }) : super(anchor: .centerLeft) {
    _muzzlePosition = position.clone();
    _targetLocation = target.position.clone();
    _moveDirection = (_targetLocation - _muzzlePosition).normalized();
    angle = atan2(_moveDirection.y, _moveDirection.x);
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (target.isRemoving || !target.isMounted) {
      removeFromParent();
      return;
    }
    final Vector2 targetPos = target.position;
    final dir = targetPos - position;
    final distance = dir.length;
    _handleLaserLogic(distance, dt);
  }

  void _handleLaserLogic(double distance, double dt) {
    size.x = distance;

    if (_lifeTime == 0.1) {}

    _lifeTime -= dt;
    if (_lifeTime <= 0) {
      world.add(ProjectileExplosionComponent(explosion: explosion, position: target.position));

      removeFromParent();
    }
  }
}
