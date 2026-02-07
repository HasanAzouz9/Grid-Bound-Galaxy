import 'package:gridbound_galaxy/modules/levels/domain/entities/enemy_squadron_group.dart';

class EnemiesWaveConfig {
  final double delay;
  final List<EnemySquadronGroup> groups;

  EnemiesWaveConfig({
    required this.delay,
    required this.groups,
  });

  factory EnemiesWaveConfig.fromJson(Map<String, dynamic> json) {
    return EnemiesWaveConfig(
      delay: (json['delay'] as num).toDouble(),
      groups: (json['groups'] as List<dynamic>).map((g) => EnemySquadronGroup.fromJson(g)).toList(),
    );
  }
}
