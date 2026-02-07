import 'package:flame/components.dart' show Vector2;

extension GameVectorExtensions on Vector2 {
  // Constants should ideally be in a central config, but keeping here for now
  static const double _tileSize = 128;

  /// Converts a World Position to Grid Coordinates based on the object's size
  /// Used to find the "Top Left" tile of a tower.
  Vector2 toGridCoordinates(Vector2 size) {
    return Vector2(
      ((x - (size.x / 2)) / _tileSize).floorToDouble(),
      ((y - (size.y / 2)) / _tileSize).floorToDouble(),
    );
  }

  /// Converts a World Size to a number of Tiles occupied
  /// e.g. 256x256 becomes 2x2 tiles
  Vector2 toTileSpan() {
    return Vector2(
      (x / _tileSize).ceilToDouble(),
      (y / _tileSize).ceilToDouble(),
    );
  }
}
