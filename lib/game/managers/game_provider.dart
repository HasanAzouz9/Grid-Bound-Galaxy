import 'package:flutter_riverpod/legacy.dart';

import '../../core/enums/game_levels_enum.dart';
import '../grid_bound_galaxy_game.dart';

class GameProvider extends StateNotifier<GridBoundGalaxyGame> {
  static final provider = StateNotifierProvider<GameProvider, GridBoundGalaxyGame>((ref) => GameProvider());
  GameProvider() : super(GridBoundGalaxyGame(initialLevel: GameLevelsEnum.level_01));

  void setLevel({required GameLevelsEnum level}) {
    state = GridBoundGalaxyGame(initialLevel: level);
  }
}
