import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../core/extensions/context.extensions.dart';

class VictoryOverlay extends ConsumerWidget {
  const VictoryOverlay({super.key});

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
        child: const Center(
          child: Text('Player is Victorious'),
        ),
      ),
    );
  }
}
