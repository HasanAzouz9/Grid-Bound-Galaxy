import 'dart:convert' show json;

import 'package:flutter/services.dart' show rootBundle;
import 'package:riverpod/riverpod.dart';

import '../modules/enemies/domain/entities/enemy_entity.dart';

final enemiesDatasourceInitializerProvider = FutureProvider<void>((ref) async {
  final enemiesDatasource = ref.read(enemiesDatasourceProvider);
  await enemiesDatasource.init();
});
final enemiesDatasourceProvider = Provider((ref) => EnemiesDatasource());

class EnemiesDatasource {
  final Map<String, EnemyEntity> _enemiesMap = {};

  Future<void> init() async {
    final String response = await rootBundle.loadString('assets/data/enemies.json');
    final data = await json.decode(response);

    for (var enemy in data['enemies']) {
      final decodedEnemy = EnemyEntity.fromJson(enemy);
      _enemiesMap[decodedEnemy.id] = decodedEnemy;
    }
  }

  List<EnemyEntity> getAll() => _enemiesMap.values.map((enemy) => enemy).toList();

  // Optimized Datasource
  EnemyEntity getById({required String id}) {
    final enemy = _enemiesMap[id];
    if (enemy == null) {
      throw Exception('Enemy ID "$id" not found. Check your JSON!');
    }
    return enemy;
  }
}
