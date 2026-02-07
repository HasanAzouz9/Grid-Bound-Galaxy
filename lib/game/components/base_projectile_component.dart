import 'package:flame/components.dart';
import 'package:gridbound_galaxy/modules/towers/domain/entities/projectile_explosion_entity.dart';

import '../../core/enums/projectile_state.dart';
import '../../modules/towers/domain/entities/projectile_entity.dart';
import '../grid_bound_galaxy_game.dart';
import 'enemy_component.dart';

abstract class BaseProjectile extends SpriteAnimationGroupComponent<ProjectileState>
    with HasGameReference<GridBoundGalaxyGame> {
  final ProjectileEntity projectile;
  final ProjectileExplosionEntity explosion;
  final EnemyComponent target;
  late final Vector2 targetLocation;

  BaseProjectile({
    required this.projectile,
    required this.explosion,
    required this.target,
    required Vector2 position,
    Anchor anchor = Anchor.center,
  }) : super(
         position: position,
         size: Vector2(projectile.sizeWidth.toDouble(), projectile.sizeHeight.toDouble()),
         anchor: anchor,
         priority: 15,
       ) {
    targetLocation = target.position.clone();
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    _loadAnimations();
  }

  void _loadAnimations() {
    final spriteSheet = game.images.fromCache(projectile.sprite);

    // We use the JSON sequence data if available, otherwise default to a single frame
    final movingData = SpriteAnimationData.sequenced(
      amount: 1,
      stepTime: 1,
      textureSize: Vector2(projectile.sizeWidth.toDouble(), projectile.sizeHeight.toDouble()),
      loop: false,
    );

    animations = {ProjectileState.moving: SpriteAnimation.fromFrameData(spriteSheet, movingData)};
    current = ProjectileState.moving;
  }
}
