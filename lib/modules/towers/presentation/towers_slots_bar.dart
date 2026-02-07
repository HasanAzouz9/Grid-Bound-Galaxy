import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gridbound_galaxy/modules/towers/presentation/tower_slot_card.dart';
import 'package:gridbound_galaxy/services/towers_datasource.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class TowersSlotsBar extends ConsumerWidget {
  const TowersSlotsBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final towers = ref.read(towersDatasourceProvider).getTowerPreviews();
    return Align(
      alignment: .bottomLeft,
      child: SizedBox(
        width: 35.w,
        height: 20.h,
        child: ListView.builder(
          itemCount: towers.length,
          scrollDirection: .horizontal,
          itemBuilder: (ctx, i) => TowerSlotCard(
            tower: towers[i],
          ),
        ),
      ),
    );
  }
}
