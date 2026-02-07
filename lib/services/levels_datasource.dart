import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/enums/game_levels_enum.dart';
import '../modules/levels/domain/entities/game_level_configuration.dart';

final levelsDatasourceInitializerProvider = FutureProvider<void>((ref) async {
  final levelsDatasource = ref.read(levelsDatasourceProvider);
  await levelsDatasource.init();
});

final levelsDatasourceProvider = Provider((ref) => GameLevelsDatasource());

class GameLevelsDatasource {
  final Map<GameLevelsEnum, GameLevelConfiguration> _cache = {};

  Future<void> init() async {
    final response = await rootBundle.loadString('assets/data/levels_waves.json');
    final Map<String, dynamic> data = json.decode(response);

    for (final level in GameLevelsEnum.values) {
      final key = level.name;

      final levelJson = data[key];
      if (levelJson == null) continue;

      _cache[level] = GameLevelConfiguration.fromJson(levelJson);
    }
  }

  GameLevelConfiguration getLevel(GameLevelsEnum level) {
    final config = _cache[level];
    if (config == null) {
      throw StateError('Level $level not loaded');
    }
    return config;
  }
}
