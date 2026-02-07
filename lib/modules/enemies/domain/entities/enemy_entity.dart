import 'package:flame/input.dart' show Vector2;

class EnemyEntity {
  final String id;
  final String idleSprite;
  final String explosionSprite;
  final String movementSprite;
  final int health;
  final int speed;
  final Vector2 size;
  final Vector2 explosionSpriteTextureSize;
  final Vector2 movementSpriteTextureSize;
  final int reward;
  final int damage;
  final int spawnTime;
  final String explosionSound;
  final String movementSound;
  final String details;
  final String image;

  EnemyEntity({
    required this.id,
    required this.idleSprite,
    required this.explosionSprite,
    required this.movementSprite,
    required this.health,
    required this.speed,
    required this.size,
    required this.explosionSpriteTextureSize,
    required this.movementSpriteTextureSize,
    required this.reward,
    required this.damage,
    required this.spawnTime,
    required this.explosionSound,
    required this.movementSound,
    required this.details,
    required this.image,
  });

  EnemyEntity.fromJson(Map<String, dynamic> json)
    : id = json['id'],
      idleSprite = json['idle_sprite'],
      explosionSprite = json['explosion_sprite'],
      movementSprite = json['movement_sprite'],
      health = (json['health'] as num).toInt(),
      speed = (json['speed'] as num).toInt(),
      size = Vector2((json['width'] as num).toDouble(), (json['height'] as num).toDouble()),
      explosionSpriteTextureSize = Vector2(
        (json['explosionSpriteTextureSizeWidth'] as num).toDouble(),
        (json['explosionSpriteTextureSizeHeight'] as num).toDouble(),
      ),
      movementSpriteTextureSize = Vector2(
        (json['movementSpriteTextureSizeWidth'] as num).toDouble(),
        (json['movementSpriteTextureSizeHeight'] as num).toDouble(),
      ),
      reward = (json['reward'] as num).toInt(),
      damage = (json['damage'] as num).toInt(),
      spawnTime = (json['spawn_time'] as num).toInt(),
      explosionSound = json['explosion_sound'],
      movementSound = json['movement_sound'],
      details = json['details'],
      image = (json['image']);
}
