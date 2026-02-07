import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flame_riverpod/flame_riverpod.dart';
import 'package:gridbound_galaxy/game/components/wave_component.dart';
import 'package:gridbound_galaxy/modules/levels/domain/entities/game_level_configuration.dart';
import 'package:gridbound_galaxy/modules/towers/domain/entities/tower_entity.dart';

import '../../config/constants/levels_paths.dart';
import 'tile_highlight.component.dart';
import 'tower_component.dart';

class LevelComponent extends World with RiverpodComponentMixin {
  late TiledComponent level;
  final GameLevelConfiguration levelConfig;
  final int tileSize = 128;

  LevelComponent({required this.levelConfig}) : super(priority: 11);

  @override
  onLoad() async {
    await super.onLoad();
    final pathLibrary = await TmxPathExtractor.getPathsFromTmx(levelConfig.mapPath);
    level = await TiledComponent.load(levelConfig.mapPath, Vector2.all(tileSize.toDouble()));
    children.register<TowerComponent>();

    add(level);
    add(WaveComponent(waves: levelConfig.waves, pathLibrary: pathLibrary));
  }

  bool isTileBuildable(Vector2 worldPosition, Vector2 towerSize) {
    final buildingLayer = _buildingLayer();
    if (buildingLayer == null || buildingLayer.data == null) return false;

    int spanX = (towerSize.x / tileSize).ceil();
    int spanY = (towerSize.y / tileSize).ceil();

    int startX = (worldPosition.x / tileSize).floor();
    int startY = (worldPosition.y / tileSize).floor();

    for (int x = startX; x < startX + spanX; x++) {
      for (int y = startY; y < startY + spanY; y++) {
        if (x < 0 || x >= buildingLayer.width || y < 0 || y >= buildingLayer.height) {
          return false;
        }

        final isOccupied = children.query<TowerComponent>().any((t) {
          int tx = (t.position.x / tileSize).floor();
          int ty = (t.position.y / tileSize).floor();
          return tx == x && ty == y;
        });
        if (isOccupied) return false;

        final index = y * buildingLayer.width + x;
        final tileGid = buildingLayer.data![index];

        if (tileGid < 50 || tileGid > 65) {
          return false;
        }
      }
    }

    return true;
  }

  void enterBuildMode(TowerEntity tower) {
    exitBuildMode();
    final buildingLayer = _buildingLayer();
    if (buildingLayer == null) return;

    final highlights = <TileHighlight>[];

    for (int x = 0; x < buildingLayer.width; x++) {
      for (int y = 0; y < buildingLayer.height; y++) {
        Vector2 tileCenter = Vector2(x * tileSize + 64, y * tileSize + 64);

        if (isTileBuildable(tileCenter, Vector2(tower.width, tower.height))) {
          highlights.add(
            TileHighlight(
              position: tileCenter,
              towerToPlace: tower,
              priority: 20,
            ),
          );
        }
      }
    }
    addAll(highlights);
  }

  void exitBuildMode() {
    children.query<TileHighlight>().forEach((h) => h.removeFromParent());
  }

  TileLayer? _buildingLayer() {
    return level.tileMap.getLayer<TileLayer>('building_blocks');
  }
}
