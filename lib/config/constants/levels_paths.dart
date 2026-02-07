import 'package:flame/game.dart' show Vector2;

import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart' show TiledMap, TileMapParser, ObjectGroup;
import 'package:flutter/services.dart';

class TmxPathExtractor {
  static Future<Map<String, List<Vector2>>> getPathsFromTmx(String tmxPath) async {
    final String tmxString = await rootBundle.loadString('assets/tiles/$tmxPath');

    final TiledMap map = TileMapParser.parseTmx(tmxString);
    final Map<String, List<Vector2>> extractedPaths = {};

    final objectLayers = map.layers.whereType<ObjectGroup>();

    for (final layer in objectLayers) {
      if (layer.name == 'paths') {
        for (final obj in layer.objects) {
          if (obj.polyline.isNotEmpty) {
            List<Vector2> path = [];
            for (final point in obj.polyline) {
              path.add(Vector2(obj.x + point.x, obj.y + point.y));
            }
            extractedPaths[obj.name] = path;
          }
        }
      }
    }
    return extractedPaths;
  }
}

// class LevelsPaths {
//   static final List<Vector2> level01Path1 = [
//     Vector2(0, 1344),
//     Vector2(960, 1344),
//     Vector2(960, 960),
//     Vector2(2880, 960),
//     Vector2(2880, 1728),
//     Vector2(4480, 1728),
//   ];

//   static final List<Vector2> level01Path2 = [
//     Vector2(0, 1472),
//     Vector2(1088, 1472),
//     Vector2(1088, 1088),
//     Vector2(2752, 1088),
//     Vector2(2752, 1856),
//     Vector2(4480, 1856),
//   ];

//   static final List<Vector2> level01Path3 = [
//     Vector2(0, 1408),
//     Vector2(1024, 1408),
//     Vector2(1024, 1024),
//     Vector2(2816, 1024),
//     Vector2(2816, 1792),
//     Vector2(4480, 1792),
//   ];

//   static final List<Vector2> level02Lane1Path1 = [
//     Vector2(0, 1344),
//     Vector2(2496, 1344),
//     Vector2(2496, 1728),
//     Vector2(3904, 1728),
//     Vector2(3904, 1216),
//     Vector2(5120, 1216),
//   ];

//   static final List<Vector2> level02Lane1Path2 = [
//     Vector2(0, 1472),
//     Vector2(2368, 1472),
//     Vector2(2368, 1856),
//     Vector2(4032, 1856),
//     Vector2(4032, 1344),
//     Vector2(5120, 1344),
//   ];

//   static final List<Vector2> level02Lane1Path3 = [
//     Vector2(0, 1408),
//     Vector2(2432, 1408),
//     Vector2(2432, 1792),
//     Vector2(3968, 1792),
//     Vector2(3968, 1280),
//     Vector2(5120, 1280),
//   ];

//   static final List<Vector2> level02Lane2Path1 = [
//     Vector2(0, 1984),
//     Vector2(2368, 1984),
//     Vector2(2368, 1728),
//     Vector2(4032, 1728),
//     Vector2(4032, 2112),
//     Vector2(5120, 2112),
//   ];

//   static final List<Vector2> level02Lane2Path2 = [
//     Vector2(0, 2112),
//     Vector2(2496, 2112),
//     Vector2(2496, 1856),
//     Vector2(3776, 1856),
//     Vector2(3776, 2240),
//     Vector2(5120, 2240),
//   ];

//   static final List<Vector2> level02Lane2Path3 = [
//     Vector2(0, 2048),
//     Vector2(2432, 2048),
//     Vector2(2432, 1792),
//     Vector2(3840, 1792),
//     Vector2(3840, 2176),
//     Vector2(5120, 2176),
//   ];
// }
