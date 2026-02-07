import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gridbound_galaxy/core/extensions/app_dimensions.extension.dart';
import 'package:gridbound_galaxy/core/extensions/context.extensions.dart';
import 'package:gridbound_galaxy/game/managers/game_run_time_stats.dart';
import 'package:gridbound_galaxy/services/towers_datasource.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../game/components/tower_component.dart';

class TowerActionMenu extends ConsumerWidget {
  const TowerActionMenu({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tower = ref.watch(selectedTowerProvider);
    final playerStats = ref.watch(GameSessionController.provider);
    if (tower == null) {
      return const SizedBox.shrink();
    }
    final isMax = ref
        .read(towersDatasourceProvider)
        .isMaxLevel(
          towerId: tower.tower.id,
          level: tower.tower.level,
        );
    return Align(
      alignment: Alignment.bottomRight,
      child: Container(
        height: 75.h,
        width: 15.w,
        padding: context.padding4,
        margin: context.padding4,

        // decoration:
        decoration: ShapeDecoration(
          color: context.colorScheme.primaryContainer.withAlpha(100),
          shape: RoundedSuperellipseBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),

        //  ShapeDecoration(
        //   color: context.colorScheme.primaryContainer.withAlpha(225),
        //   shape: const BeveledRectangleBorder(
        //     borderRadius: BorderRadius.only(
        //       topRight: Radius.circular(24),
        //       bottomLeft: Radius.circular(24),
        //     ),
        //   ),
        // ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 8.w,
                height: 8.w,
                decoration: BoxDecoration(
                  borderRadius: context.radius12,
                  image: DecorationImage(
                    image: AssetImage(
                      'assets/images/${tower.tower.turretSprite}',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 8),

              Text(
                tower.tower.id.replaceAll('_', ' ').toUpperCase(),
                style: context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const Divider(indent: 20, endIndent: 20),

              _infoRow('Level', '${tower.tower.level}'),
              isMax
                  ? const Text('Max')
                  : _actionButton(
                      context: context,
                      label: 'UPGRADE ${tower.tower.upgradeCost}G',
                      color: playerStats.playerGold < tower.tower.cost ? Colors.red : null,
                      onPressed: playerStats.playerGold < tower.tower.cost ? () {} : () => tower.upgradeTower(),
                    ),

              _actionButton(
                context: context,
                label: 'SELL ${(tower.tower.cost * 0.65).round()}G',
                onPressed: () => tower.sellTower(),
              ),

              const Divider(indent: 20, endIndent: 20),

              _infoRow('Range', '${tower.tower.range}'),
              _infoRow('Damage', '${tower.tower.projectile.damage}'),
              _infoRow('Speed', '${tower.tower.projectile.speed}'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Text(
        '$label: $value',
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _actionButton({
    required BuildContext context,
    required String label,
    Color? color,
    required VoidCallback? onPressed,
  }) {
    return InkWell(
      onTap: onPressed,

      child: Container(
        padding: context.padding4,
        margin: context.padding4,
        decoration: const BoxDecoration().copyWith(
          // color: context.colorScheme.onPrimaryContainer.withAlpha(150),
          borderRadius: context.radius4,
          border: Border.all(color: context.colorScheme.onPrimaryContainer),
        ),
        child: Text(
          label,
          style: const TextStyle().copyWith(color: color ?? context.colorScheme.onPrimaryContainer, fontWeight: .w500),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
