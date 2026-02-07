import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../modules/towers/domain/entities/tower_entity.dart';
import '../modules/towers/domain/entities/tower_preview.dart';

final towersDatasourceInitializerProvider = FutureProvider<void>((ref) async {
  final towersDatasource = ref.read(towersDatasourceProvider);
  await towersDatasource.init();
});

final towersDatasourceProvider = Provider((ref) => TowersDatasource());

class TowersDatasource {
  final Map<String, Map<int, TowerEntity>> _cache = {};

  Future<void> init() async {
    final jsonString = await rootBundle.loadString('assets/data/towers.json');
    final Map<String, dynamic> data = json.decode(jsonString);

    for (final towerEntry in data.entries) {
      final towerId = towerEntry.key;
      final Map<String, dynamic> levelsJson = towerEntry.value;

      final levels = <int, TowerEntity>{};

      for (final levelEntry in levelsJson.entries) {
        final levelNumber = _parseLevel(levelEntry.key);
        final fallbackId = '${towerId}_lv$levelNumber';

        levels[levelNumber] = TowerEntity.fromJson(
          levelEntry.value,
          fallbackId: fallbackId,
        );
      }

      _cache[towerId] = levels;
    }
  }

  bool isMaxLevel({required String towerId, required int level}) {
    final towerLevels = _cache[towerId];
    if (towerLevels == null) {
      throw StateError('Tower "$towerId" not found');
    }

    return towerLevels.length == level ? true : false;
  }

  TowerEntity? upgradeTower({required String towerId, required int level}) {
    final towerLevels = _cache[towerId];
    if (towerLevels == null) {
      throw StateError('Tower "$towerId" not found');
    }
    TowerEntity? tower;
    if (towerLevels.length >= level) {
      tower = towerLevels[level + 1];
    }
    if (towerLevels.length < level) {
      return tower = null;
    }

    return tower;
  }

  TowerEntity getTower({
    required String towerId,
    required int level,
  }) {
    final towerLevels = _cache[towerId];
    if (towerLevels == null) {
      throw StateError('Tower "$towerId" not found');
    }

    final tower = towerLevels[level];
    if (tower == null) {
      throw StateError('Tower "$towerId" level $level not found');
    }

    return tower;
  }

  String getTowerImage(String towerId, {int level = 1}) {
    return getTower(towerId: towerId, level: level).image;
  }

  List<TowerPreview> getTowerPreviews() {
    return _cache.entries.map((entry) {
      final towerCategory = entry.key;
      final towerLevel1 = entry.value[1] ?? entry.value.values.first;

      return TowerPreview(
        towerId: towerCategory,
        image: towerLevel1.turretSprite,
        cost: towerLevel1.cost,
      );
    }).toList();
  }

  int _parseLevel(String key) => int.parse(key.replaceAll(RegExp(r'\D'), ''));
}
