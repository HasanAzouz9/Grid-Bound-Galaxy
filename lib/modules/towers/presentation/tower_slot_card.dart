import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gridbound_galaxy/core/extensions/app_dimensions.extension.dart';
import 'package:gridbound_galaxy/core/extensions/context.extensions.dart';
import 'package:gridbound_galaxy/game/managers/game_provider.dart';
import 'package:gridbound_galaxy/modules/towers/domain/entities/tower_preview.dart';
import 'package:gridbound_galaxy/services/towers_datasource.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../game/managers/game_run_time_stats.dart';

class TowerSlotCard extends ConsumerWidget {
  final TowerPreview tower;
  const TowerSlotCard({super.key, required this.tower});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: context.padding4,
      child: InkWell(
        onTap: () {
          final tow = ref.read(towersDatasourceProvider).getTower(towerId: tower.towerId, level: 1);
          final canAfford = ref.read(GameSessionController.provider).playerGold >= tower.cost;
          if (canAfford) {
            ref.read(GameProvider.provider).levelWorld.enterBuildMode(tow);
          }
        },
        child: Container(
          width: 6.w,
          height: 10.h,
          decoration: ShapeDecoration(
            color: context.colorScheme.primaryContainer.withAlpha(75),
            shape: RoundedSuperellipseBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          child: Column(
            mainAxisSize: .min,

            children: [
              Expanded(
                child: RotationTransition(
                  turns: const AlwaysStoppedAnimation(-30 / 360),

                  child: Image.asset(
                    'assets/images/${tower.image}',
                    fit: .contain,
                  ),
                ),
              ),

              Text(
                '${tower.cost}',
                style: context.textTheme.titleSmall?.copyWith(color: context.colorScheme.onPrimaryContainer),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
