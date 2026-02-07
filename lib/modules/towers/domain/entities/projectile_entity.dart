import '../../../../core/enums/projectile_type.dart';

class ProjectileEntity {
  final String sprite;
  final int speed;
  final int damage;
  final ProjectileType type;
  final double velocityWidth;
  final double velocityHeight;
  final double sizeWidth;
  final double sizeHeight;
  final String? travelSound;
  final String? impactSound;

  ProjectileEntity({
    required this.sprite,
    required this.speed,
    required this.damage,
    required this.type,
    required this.velocityWidth,
    required this.velocityHeight,
    required this.sizeWidth,
    required this.sizeHeight,
    this.travelSound,
    this.impactSound,
  });

  factory ProjectileEntity.fromJson(Map<String, dynamic> json) {
    return ProjectileEntity(
      sprite: json['sprite'],
      speed: json['speed'],
      damage: json['damage'],
      type: projectileTypeFromJson(json['type']),
      velocityWidth: (json['velocityWidth'] as num).toDouble(),
      velocityHeight: (json['velocityHeight'] as num).toDouble(),
      sizeWidth: (json['sizeWidth'] as num).toDouble(),
      sizeHeight: (json['sizeHeight'] as num).toDouble(),
      travelSound: json['travelSound'],
      impactSound: json['impactSound'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sprite': sprite,
      'speed': speed,
      'damage': damage,
      'type': projectileTypeToJson(type),
      'velocityWidth': velocityWidth,
      'velocityHeight': velocityHeight,
      'sizeWidth': sizeWidth,
      'sizeHeight': sizeHeight,
      'travelSound': travelSound,
      'impactSound': impactSound,
    };
  }
}
