import 'package:flame/components.dart';
import 'package:flame/events.dart';

mixin CameraAdjustments {
  final double _minZoom = 1.0;
  final double _maxZoom = 3.0;
  // final double _startZoom = 1.0;

  void processScale(ScaleUpdateInfo info, Vector2 currentScale, CameraComponent camera, double startZoom) {
    final newZoom = startZoom * ((currentScale.y + currentScale.x) / 2.0);
    camera.viewfinder.zoom = newZoom.clamp(_minZoom, _maxZoom);
  }

  void processDrag(ScaleUpdateInfo info, CameraComponent camera) {
    final delta = info.delta.global;

    final zoomDragFactor = 3 / camera.viewfinder.zoom;
    final currentPosition = camera.viewfinder.position;

    camera.viewfinder.position = currentPosition.translated(-delta.x * zoomDragFactor, -delta.y * zoomDragFactor);
  }

  void checkScaleBorder(CameraComponent camera) {
    camera.viewfinder.zoom = camera.viewfinder.zoom.clamp(_minZoom, _maxZoom);
  }

  void checkDragBorders(CameraComponent camera, Vector2 mapSize) {
    final worldRect = camera.visibleWorldRect;
    final currentPosition = camera.viewfinder.position;

    var xTranslate = 0.0;
    var yTranslate = 0.0;

    if (worldRect.left < 0.0) {
      xTranslate = -worldRect.left;
    } else if (worldRect.right > mapSize.x) {
      xTranslate = mapSize.x - worldRect.right;
    }

    if (worldRect.top < 0.0) {
      yTranslate = -worldRect.top;
    } else if (worldRect.bottom > mapSize.y) {
      yTranslate = mapSize.y - worldRect.bottom;
    }

    camera.viewfinder.position = currentPosition.translated(xTranslate, yTranslate);
  }
}
