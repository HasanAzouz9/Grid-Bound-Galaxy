import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame_riverpod/flame_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:gridbound_galaxy/game/components/circle_component.dart' show RangeCircle;
import 'package:gridbound_galaxy/game/components/enemy_component.dart' show EnemyComponent;
import 'package:gridbound_galaxy/game/components/missile_projectile_component.dart';
import 'package:gridbound_galaxy/game/grid_bound_galaxy_game.dart';
import 'package:gridbound_galaxy/game/managers/game_run_time_stats.dart';
import 'package:gridbound_galaxy/modules/towers/domain/entities/tower_entity.dart';
import 'package:gridbound_galaxy/services/towers_datasource.dart';

import '../../core/extensions/vector_extensions.dart';
import 'base_projectile_component.dart';
import 'energy_projectile_component.dart';

enum TowerBaseState { idle, active }

enum TurretState { idle, shooting }

final selectedTowerProvider = StateProvider<TowerComponent?>((ref) => null);

class TowerComponent extends PositionComponent
    with HasGameReference<GridBoundGalaxyGame>, TapCallbacks, RiverpodComponentMixin {
  TowerEntity tower;

  late SpriteGroupComponent<TowerBaseState> _base;
  late SpriteAnimationGroupComponent<TurretState> _turret;
  bool _hasFiredThisCycle = false;
  RangeCircle? _rangeDisplay;

  bool _isShooting = false;
  double _fireCoolDown = 0;

  final double turnSpeed = 4.0;

  TowerComponent({
    required this.tower,
    required Vector2 position,
  }) : super(position: position, size: Vector2(tower.width, tower.height), anchor: Anchor.center, priority: 11);

  Vector2 get _startGrid => position.toGridCoordinates(size);
  Vector2 get _span => size.toTileSpan();

  bool occupiesTile(int x, int y) {
    return x >= _startGrid.x && x < _startGrid.x + _span.x && y >= _startGrid.y && y < _startGrid.y + _span.y;
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    add(RectangleHitbox());

    _loadBase();
    _loadTurret();
  }

  void _loadBase() {
    _base = SpriteGroupComponent(
      sprites: {
        TowerBaseState.idle: Sprite(game.images.fromCache(tower.onHoldBaseSprite)),
        TowerBaseState.active: Sprite(game.images.fromCache(tower.activeBaseSprite)),
      },
      current: TowerBaseState.idle,
      size: size,
      anchor: Anchor.center,
      position: size / 2,
    );

    add(_base);
  }

  void _loadTurret() {
    final turretImage = game.images.fromCache(tower.turretSprite);
    final shootingImage = game.images.fromCache(tower.turretShootingAnimationSprite);

    final onHoldState = SpriteAnimation.fromFrameData(
      turretImage,
      SpriteAnimationData.range(
        start: tower.shootingSequence.start,
        end: tower.shootingSequence.start,
        amount: tower.shootingSequence.amount,
        amountPerRow: tower.shootingSequence.amountPerRow,
        stepTimes: [1],
        textureSize: Vector2(tower.shootingSequence.textureSizeWidth, tower.shootingSequence.textureSizeHeight),
      ),
    );

    final shootingState = SpriteAnimation.fromFrameData(
      shootingImage,
      SpriteAnimationData.range(
        start: tower.shootingSequence.start,
        end: tower.shootingSequence.stop,
        amount: tower.shootingSequence.amount,
        amountPerRow: tower.shootingSequence.amountPerRow,
        stepTimes: tower.shootingSequence.stepTimes,
        textureSize: Vector2(tower.shootingSequence.textureSizeWidth, tower.shootingSequence.textureSizeHeight),
        loop: false,
      ),
    );

    _turret = SpriteAnimationGroupComponent(
      animations: {
        TurretState.idle: onHoldState,
        TurretState.shooting: shootingState,
      },
      current: TurretState.idle,
      size: Vector2(tower.turretWidth, tower.turretHeight),
      anchor: Anchor.center,
      position: size / 2,
    );

    add(_turret);
  }

  @override
  void onTapDown(TapDownEvent event) {
    event.handled = true;
    game.onTowerSelected(this);
  }

  void onSelected() {
    if (_rangeDisplay != null) return;

    if (!game.overlays.isActive('TowerActionsMenu')) {
      game.overlays.add('TowerActionsMenu');
    }
    _rangeDisplay =
        RangeCircle(
            radius: tower.range.toDouble(),
          )
          ..priority = -1
          ..position = size / 2;

    add(_rangeDisplay!);
  }

  void onDeselected() {
    _rangeDisplay?.removeFromParent();
    _rangeDisplay = null;
  }

  @override
  void onRemove() {
    _rangeDisplay?.removeFromParent();
    super.onRemove();
  }

  @override
  void update(double dt) {
    super.update(dt);

    _fireCoolDown -= dt;

    final enemy = _getNearestEnemy();
    if (enemy == null) {
      _setIdle();
      return;
    }

    final distance = enemy.position.distanceTo(position);
    if (distance > tower.range) {
      _setIdle();
      return;
    }

    _rotateTurret(enemy.position, dt);

    if (_fireCoolDown <= 0 && !_isShooting) {
      _startShooting();
    }

    if (_isShooting) {
      _handleShooting(enemy);
    }
  }

  void _startShooting() {
    _isShooting = true;
    _hasFiredThisCycle = false;

    _turret.current = TurretState.shooting;
    _turret.animationTicker?.reset();
    _base.current = TowerBaseState.active;
  }

  void _handleShooting(EnemyComponent enemy) {
    final ticker = _turret.animationTicker;
    if (ticker == null) return;

    if (ticker.currentIndex == tower.shootingSequence.firingFrame && !_hasFiredThisCycle) {
      _hasFiredThisCycle = true;
      _executeShoot(enemy: enemy);
    }

    if (ticker.isLastFrame) {
      _isShooting = false;
      _hasFiredThisCycle = false;
      _fireCoolDown = 1 / tower.fireRate;

      _turret.current = TurretState.idle;
    }
  }

  EnemyComponent? _getNearestEnemy() {
    final enemies = game.levelWorld.children.query<EnemyComponent>();
    if (enemies.isEmpty) return null;

    EnemyComponent? closest;
    double minDist = double.infinity;

    for (final enemy in enemies) {
      final d = enemy.position.distanceToSquared(position);
      if (d < minDist) {
        minDist = d;
        closest = enemy;
      }
    }

    return closest;
  }

  void _rotateTurret(Vector2 targetWorld, double dt) {
    final direction = targetWorld - position;
    final desiredAngle = atan2(direction.y, direction.x);

    double delta = desiredAngle - _turret.angle;
    while (delta > pi) {
      delta -= pi * 2;
    }
    while (delta < -pi) {
      delta += pi * 2;
    }

    _turret.angle += delta * turnSpeed * dt;
  }

  void _executeShoot({required EnemyComponent enemy}) {
    double barrelLength = size.x / 2;
    Vector2 muzzleOffset = Vector2(cos(_turret.angle), sin(_turret.angle)) * barrelLength;
    Vector2 spawnPos = position + muzzleOffset;

    BaseProjectile bullet;

    switch (tower.projectile.type) {
      case .energy:
        bullet = EnergyProjectile(
          projectile: tower.projectile,
          target: enemy,
          explosion: tower.projectileExplosion,
          position: spawnPos,
        );
        break;
      case .missile:
        bullet = MissileProjectileComponent(
          projectile: tower.projectile,
          explosion: tower.projectileExplosion,
          target: enemy,
          position: spawnPos,
        );
        break;
      default:
        bullet = EnergyProjectile(
          projectile: tower.projectile,
          explosion: tower.projectileExplosion,
          target: enemy,
          position: spawnPos,
        );
        break;
    }

    game.levelWorld.add(bullet);
  }

  void _setIdle() {
    _turret.current = TurretState.idle;
    _base.current = TowerBaseState.idle;
  }

  void sellTower() {
    ref.read(GameSessionController.provider.notifier).increaseGold(amount: (tower.cost * 0.65).round());
    ref.read(selectedTowerProvider.notifier).state = null;
    removeFromParent();
  }

  Future<void> upgradeTower() async {
    final upgraded = ref
        .read(towersDatasourceProvider)
        .upgradeTower(
          towerId: tower.id,
          level: tower.level,
        );

    if (upgraded != null) {
      tower = upgraded;
      ref.read(GameSessionController.provider.notifier).decreaseGold(amount: upgraded.cost);
      _base.removeFromParent();
      _turret.removeFromParent();

      _loadBase();
      _loadTurret();

      // Update the range display visual if it's currently shown
      if (_rangeDisplay != null) {
        onDeselected();
        onSelected();
      }

      // --- THE FIX ---
      // Re-assign the provider state to the same instance.
      // This tells Riverpod: "Hey, the data inside this object changed, please rebuild listeners."
      ref.read(selectedTowerProvider.notifier).state = null; // Clear it briefly
      ref.read(selectedTowerProvider.notifier).state = this; // Re-set it
    }
  }
}
