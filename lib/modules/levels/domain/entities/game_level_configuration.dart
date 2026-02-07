import 'enemies_wave_config.dart';

class GameLevelConfiguration {
  final String mapPath;
  final double width;
  final double height;
  final int playerHealth;
  final int playerGold;
  final List<EnemiesWaveConfig> waves;

  GameLevelConfiguration({
    required this.mapPath,
    required this.width,
    required this.height,
    required this.waves,
    required this.playerHealth,
    required this.playerGold,
  });

  factory GameLevelConfiguration.fromJson(Map<String, dynamic> json) {
    return GameLevelConfiguration(
      mapPath: json['map'] as String,
      width: double.parse(json['width'].toString()),
      height: double.parse(json['height'].toString()),
      playerHealth: json['playerHealth'],
      playerGold: json['playerGold'],
      waves: (json['waves'] as List).map((wave) => EnemiesWaveConfig.fromJson(wave)).toList(),
    );
  }
}
