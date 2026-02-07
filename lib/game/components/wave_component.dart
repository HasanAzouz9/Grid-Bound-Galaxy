import 'package:flame/components.dart';
import 'package:flame_riverpod/flame_riverpod.dart';
import 'package:gridbound_galaxy/modules/levels/domain/entities/enemies_wave_config.dart';
import '../grid_bound_galaxy_game.dart';
import 'enemy_component.dart';

class _SpawnRuntime {
  int enemyIndex = 0;
  double timer = 0;
  bool completed = false;
}

class WaveComponent extends Component with HasGameReference<GridBoundGalaxyGame>, RiverpodComponentMixin {
  final List<EnemiesWaveConfig> waves;
  final Map<String, List<Vector2>> pathLibrary;
  double _waveDelayTimer = 0;
  bool _waitingForWaveStart = true;
  int _waveIndex = 0;
  int _groupIndex = 0;

  double _groupDelayTimer = 0;

  List<_SpawnRuntime> _activeSpawns = [];

  WaveComponent({required this.waves, required this.pathLibrary});

  @override
  void update(double dt) {
    super.update(dt);

    if (_waveIndex >= waves.length) return;
    final wave = waves[_waveIndex];

    if (_waitingForWaveStart) {
      _waveDelayTimer += dt;
      if (_waveDelayTimer < wave.delay) return;

      _waveDelayTimer = 0;
      _waitingForWaveStart = false;
    }

    if (_groupIndex >= wave.groups.length) {
      _waveIndex++;
      _groupIndex = 0;
      _activeSpawns.clear();
      _waitingForWaveStart = true;
      return;
    }

    final group = wave.groups[_groupIndex];

    if (_activeSpawns.isEmpty) {
      _groupDelayTimer += dt;
      if (_groupDelayTimer < group.delay) return;

      _groupDelayTimer = 0;
      _activeSpawns = List.generate(group.spawns.length, (_) => _SpawnRuntime());
    }

    bool allDone = true;

    for (int i = 0; i < group.spawns.length; i++) {
      final spawn = group.spawns[i];
      final runtime = _activeSpawns[i];

      if (runtime.completed) continue;

      allDone = false;
      runtime.timer += dt;
      final enemy = game.enemyRepo.getById(id: spawn.enemyId);

      if (runtime.timer * 1000 >= enemy.spawnTime) {
        runtime.timer = 0;
        final path = pathLibrary[spawn.pathName];
        if (path == null) return;

        game.levelWorld.add(
          EnemyComponent(enemyEntity: enemy, pathPoints: path),
        );

        runtime.enemyIndex++;

        if (runtime.enemyIndex >= spawn.count) {
          runtime.completed = true;
        }
      }
    }

    if (allDone) {
      _groupIndex++;
      _activeSpawns.clear();
    }
  }

  // void _nextWave() {
  //   game.ref.read(GameSessionController.provider.notifier).nextWave();
  // }
}
