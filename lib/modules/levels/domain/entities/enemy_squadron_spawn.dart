class EnemySquadronSpawn {
  final String enemyId;
  final int count;
  final String pathName;

  EnemySquadronSpawn({
    required this.enemyId,
    required this.count,
    required this.pathName,
  });

  factory EnemySquadronSpawn.fromJson(Map<String, dynamic> json) {
    return EnemySquadronSpawn(
      enemyId: json['enemyId'],
      count: json['count'],
      pathName: json['path'],
    );
  }
}
