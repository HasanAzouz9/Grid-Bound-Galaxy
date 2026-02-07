import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gridbound_galaxy/gridbound_galaxy.dart';
import 'package:gridbound_galaxy/initializer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Flame.device.fullScreen();
  Flame.device.setLandscape();
  runApp(
    UncontrolledProviderScope(
      container: await initializer(),
      child: const ProviderScope(child: GridboundGalaxy()),
    ),
  );
}
