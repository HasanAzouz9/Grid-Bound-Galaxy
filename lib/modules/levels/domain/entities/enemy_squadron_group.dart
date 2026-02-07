import 'package:gridbound_galaxy/modules/levels/domain/entities/enemy_squadron_spawn.dart';

class EnemySquadronGroup {
  final double delay;
  final List<EnemySquadronSpawn> spawns;

  EnemySquadronGroup.fromJson(Map<String, dynamic> json)
    : delay = (json['delay'] as num).toDouble(),
      spawns = (json['spawns'] as List).map((s) => EnemySquadronSpawn.fromJson(s)).toList();
}
