import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../core/extensions/context.extensions.dart';

class PlayerLostOverlay extends ConsumerWidget {
  const PlayerLostOverlay({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Align(
      alignment: .center,
      child: Container(
        width: 70.w,
        height: 70.h,
        decoration: ShapeDecoration(
          color: context.colorScheme.primaryContainer.withAlpha(100),
          shape: RoundedSuperellipseBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: Center(
          child: Column(
            children: [
              const Text('Player Lost'),
              TextButton(
                onPressed: () {
                  context.pop('/game_page');
                },
                child: const Text('Tap'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
