class ProjectileExplosionEntity {
  final String sprite;
  final int damage;
  final double velocityWidth;
  final double velocityHeight;
  final double sizeWidth;
  final double sizeHeight;
  final String? sound;
  final int start;
  final int stop;
  final int amount;
  final int firingFrame;
  final int amountPerRow;
  final double stepTime;
  final List<double> stepTimes;
  final double textureSizeWidth;
  final double textureSizeHeight;

  ProjectileExplosionEntity({
    required this.sprite,
    required this.damage,
    required this.velocityWidth,
    required this.velocityHeight,
    required this.sizeWidth,
    required this.sizeHeight,
    this.sound,
    required this.start,
    required this.stop,
    required this.amount,
    required this.firingFrame,
    required this.amountPerRow,
    required this.stepTime,
    required this.stepTimes,
    required this.textureSizeWidth,
    required this.textureSizeHeight,
  });

  factory ProjectileExplosionEntity.fromJson(Map<String, dynamic> json) {
    return ProjectileExplosionEntity(
      sprite: json['sprite'],
      damage: json['damage'],
      velocityWidth: (json['velocityWidth'] as num).toDouble(),
      velocityHeight: (json['velocityHeight'] as num).toDouble(),
      sizeWidth: (json['sizeWidth'] as num).toDouble(),
      sizeHeight: (json['sizeHeight'] as num).toDouble(),
      sound: json['sound'],
      amount: json['amount'],
      start: json['start'],
      stepTime: (json['stepTime'] as num).toDouble(),
      stepTimes: (json['stepTimes'] as List<dynamic>).map((e) => (e as num).toDouble()).toList(),
      stop: json['stop'],
      textureSizeWidth: (json['textureSizeWidth'] as num).toDouble(),
      textureSizeHeight: (json['textureSizeHeight'] as num).toDouble(),
      amountPerRow: json['amountPerRow'],
      firingFrame: json['firingFrame'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sprite': sprite,
      'damage': damage,
      'velocityWidth': velocityWidth,
      'velocityHeight': velocityHeight,
      'sizeWidth': sizeWidth,
      'sizeHeight': sizeHeight,
      'sound': sound,
      'amount': amount,
      'start': start,
      'stepTime': stepTime,
      'stepTimes': stepTimes,
      'stop': stop,
      'textureSizeHeight': textureSizeHeight,
      'textureSizeWidth': textureSizeWidth,
      'amountPerRow': amountPerRow,
      'firingFrame': firingFrame,
    };
  }
}
