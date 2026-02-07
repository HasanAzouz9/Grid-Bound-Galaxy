import 'package:gridbound_galaxy/modules/towers/domain/entities/projectile_entity.dart';
import 'package:gridbound_galaxy/modules/towers/domain/entities/projectile_explosion_entity.dart';

import '../../../../common/animation_sequence.dart';

//TODO add turret width and height and bullet as well

class TowerEntity {
  final String id;
  final String activeBaseSprite;
  final String onHoldBaseSprite;
  final String turretSprite;
  final String turretShootingAnimationSprite;
  final String image;
  final double width;
  final double turretWidth;
  final double height;
  final double turretHeight;
  final int range;
  final double fireRate;
  final int cost;
  final int upgradeCost;
  final int level;
  final String activationSound;
  final String shootingSound;
  final AnimationSequence shootingSequence;
  final ProjectileEntity projectile;
  final bool lockRotationWhileShooting;
  final ProjectileExplosionEntity projectileExplosion;

  TowerEntity({
    required this.id,
    required this.activeBaseSprite,
    required this.onHoldBaseSprite,
    required this.turretSprite,
    required this.turretShootingAnimationSprite,
    required this.image,
    required this.width,
    required this.turretWidth,
    required this.height,
    required this.turretHeight,
    required this.range,
    required this.fireRate,
    required this.cost,
    required this.upgradeCost,
    required this.level,
    required this.activationSound,
    required this.shootingSound,
    required this.shootingSequence,
    required this.projectile,
    required this.lockRotationWhileShooting,
    required this.projectileExplosion,
  });

  factory TowerEntity.fromJson(
    Map<String, dynamic> json, {
    required String fallbackId,
  }) {
    return TowerEntity(
      id: json['id'] ?? fallbackId,
      activeBaseSprite: json['activeBaseSprite'],
      onHoldBaseSprite: json['onHoldBaseSprite'],
      turretSprite: json['turretSprite'],
      turretShootingAnimationSprite: json['turretShootingAnimationSprite'],
      image: json['image'],
      width: (json['width'] as num).toDouble(),
      turretWidth: (json['turretWidth'] as num).toDouble(),
      height: (json['height'] as num).toDouble(),
      turretHeight: (json['turretHeight'] as num).toDouble(),
      range: json['range'],
      fireRate: (json['fireRate'] as num).toDouble(),
      cost: json['cost'],
      upgradeCost: json['upgradeCost'],
      level: json['level'],
      activationSound: json['activationSound'],
      shootingSound: json['shootingSound'],
      shootingSequence: AnimationSequence.fromJson(json['shootingSequence']),
      projectile: ProjectileEntity.fromJson(json['projectile']),
      lockRotationWhileShooting: json['lockRotationWhileShooting'],
      projectileExplosion: ProjectileExplosionEntity.fromJson(json['projectileExplosion']),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'activeBaseSprite': activeBaseSprite,
    'onHoldBaseSprite': onHoldBaseSprite,
    'turretSprite': turretSprite,
    'turretShootingAnimationSprite': turretShootingAnimationSprite,
    'image': image,
    'width': width,
    'turretWidth': turretWidth,
    'height': height,
    'turretHeight': turretHeight,
    'range': range,
    'fireRate': fireRate,
    'cost': cost,
    'upgradeCost': upgradeCost,
    'level': level,
    'activationSound': activationSound,
    'shootingSound': shootingSound,
    'shootingSequence': shootingSequence.toJson(),
    'projectile': projectile.toJson(),
    'lockRotationWhileShooting': lockRotationWhileShooting,
    'projectileExplosion': projectileExplosion.toJson(),
  };
}
