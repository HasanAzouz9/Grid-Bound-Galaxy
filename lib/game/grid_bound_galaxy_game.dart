import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame_riverpod/flame_riverpod.dart';
import 'package:gridbound_galaxy/core/enums/game_levels_enum.dart';
import 'package:gridbound_galaxy/core/helpers/camera_adjustments.dart';
import 'package:gridbound_galaxy/game/managers/game_run_time_stats.dart';
import 'package:gridbound_galaxy/modules/levels/domain/entities/game_level_configuration.dart';
import 'package:gridbound_galaxy/game/components/level_component.dart';
import 'package:gridbound_galaxy/services/levels_datasource.dart';

import '../config/constants/assets_constants.dart';
import '../services/enemies_datasource_initializer.dart';
import 'components/tower_component.dart';

final class GridBoundGalaxyGame extends FlameGame
    with RiverpodGameMixin, ScaleDetector, TapCallbacks, CameraAdjustments {
  late final LevelComponent levelWorld;
  final GameLevelsEnum initialLevel;
  late final GameLevelConfiguration config;
  double _startZoom = 1.0;
  late final Vector2 _mapSize;
  GridBoundGalaxyGame({
    required this.initialLevel,
  });

  EnemiesDatasource get enemyRepo => ref.read(enemiesDatasourceProvider);

  @override
  Future<void> onLoad() async {
    super.onLoad();

    config = ref.read(levelsDatasourceProvider).getLevel(initialLevel);

    final allSprites = enemyRepo.getAll().map((e) => e.idleSprite).toList();

    await images.loadAll([...allSprites, ...AssetsConstants.towersAssets]);

    levelWorld = LevelComponent(levelConfig: config);
    _mapSize = Vector2(config.width, config.height);
    camera = CameraComponent.withFixedResolution(
      width: config.width,
      height: config.height,
      world: levelWorld,
    )..viewfinder.anchor = Anchor.topLeft;

    camera.viewfinder.zoom = 3.0;

    overlays.addAll([
      'TowersBuildingBar',
    ]);
    addAll([camera, levelWorld]);
  }

  @override
  void onMount() {
    ref
        .read(GameSessionController.provider.notifier)
        .setGameSession(
          gameSession: GameSession(
            playerHealth: config.playerHealth,
            playerGold: config.playerGold,
            totalWaves: config.waves.length,
            currentWave: 0,
          ),
        );
    overlays.add('PlayerStats');
    super.onMount();
  }

  @override
  void onScaleStart(ScaleStartInfo info) {
    _startZoom = camera.viewfinder.zoom;
  }

  @override
  void onScaleUpdate(ScaleUpdateInfo info) {
    final currentScale = info.scale.global;
    currentScale.isIdentity() ? processDrag(info, camera) : processScale(info, currentScale, camera, _startZoom);
  }

  @override
  void onScaleEnd(ScaleEndInfo info) {
    checkScaleBorder(camera);
    checkDragBorders(camera, _mapSize);
  }

  @override
  void onTapDown(TapDownEvent event) {
    final ref = this.ref;

    if (!event.handled) {
      final selected = ref.read(selectedTowerProvider);
      if (selected != null) {
        selected.onDeselected();
        overlays.remove('TowerActionsMenu');

        ref.read(selectedTowerProvider.notifier).state = null;
      }
    }

    super.onTapDown(event);
  }

  void onTowerSelected(TowerComponent tower) {
    final ref = this.ref;

    final previous = ref.read(selectedTowerProvider);

    if (previous != null && previous != tower) {
      previous.onDeselected();
    }

    ref.read(selectedTowerProvider.notifier).state = tower;
    tower.onSelected();
  }
}
