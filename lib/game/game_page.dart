import 'package:flame_riverpod/flame_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gridbound_galaxy/game/grid_bound_galaxy_game.dart';
import 'package:gridbound_galaxy/game/managers/player_lost_overlay.dart';
import 'package:gridbound_galaxy/modules/levels/presentation/player_stats_bar.dart';
import 'package:gridbound_galaxy/modules/towers/presentation/tower_action_menu.dart';
import 'package:gridbound_galaxy/modules/towers/presentation/towers_slots_bar.dart';

import 'managers/game_provider.dart';

final _gameKey = GlobalKey<RiverpodAwareGameWidgetState<GridBoundGalaxyGame>>();

class GamePage extends ConsumerStatefulWidget {
  const GamePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _GamePageState();
}

class _GamePageState extends ConsumerState<GamePage> {
  @override
  Widget build(BuildContext context) {
    final game = ref.read(GameProvider.provider);
    return SafeArea(
      child: Scaffold(
        body: RiverpodAwareGameWidget(
          key: _gameKey,
          game: game,
          overlayBuilderMap: {
            'TowersBuildingBar': (BuildContext context, GridBoundGalaxyGame game) {
              return const TowersSlotsBar();
            },
            'TowerActionsMenu': (BuildContext context, GridBoundGalaxyGame game) {
              return const TowerActionMenu();
            },
            'PlayerStats': (BuildContext context, GridBoundGalaxyGame game) {
              return const PlayerStatsBar();
            },
            'PlayerLostOverlay': (BuildContext context, GridBoundGalaxyGame game) {
              return const PlayerLostOverlay();
            },
          },
        ),
      ),
    );
  }
}
