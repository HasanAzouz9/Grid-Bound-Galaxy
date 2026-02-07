import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gridbound_galaxy/core/enums/game_levels_enum.dart';
import 'package:gridbound_galaxy/core/extensions/context.extensions.dart';
import 'package:gridbound_galaxy/game/managers/game_provider.dart';

class LevelsPage extends ConsumerWidget {
  const LevelsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Levels'),
          centerTitle: true,
        ),
        body: GridView.builder(
          itemCount: GameLevelsEnum.values.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5,
            childAspectRatio: 2 / 3,
            crossAxisSpacing: 16,
            mainAxisExtent: 50,
            mainAxisSpacing: 16,
          ),
          itemBuilder: (ctx, i) {
            return InkWell(
              onTap: () {
                ref.read(GameProvider.provider.notifier).setLevel(level: GameLevelsEnum.values[i]);
                context.pushRoute('/game_page');
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: context.colorScheme.primaryContainer,
                ),
                child: Center(child: Text('Level ${i + 1}')),
              ),
            );
          },
        ),
      ),
    );
  }
}
