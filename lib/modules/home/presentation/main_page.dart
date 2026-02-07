import 'package:flutter/material.dart';
import 'package:gridbound_galaxy/core/extensions/app_dimensions.extension.dart';
import 'package:gridbound_galaxy/core/extensions/context.extensions.dart';
import 'package:gridbound_galaxy/common/app_large_button.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Container(
            width: 40.w,
            height: 60.h,
            padding: context.padding16,
            decoration: const BoxDecoration().copyWith(
              color: context.colorScheme.secondaryContainer.withAlpha(150),
              borderRadius: context.radius16,
              border: Border.all(color: context.colorScheme.onSurface, width: 2),
            ),
            child: Column(
              spacing: 24,
              children: [
                Text(
                  'Gridbound Galaxy',
                  style: context.textTheme.headlineLarge,
                ),
                AppLargeButton(label: 'New Game', onPressed: () => context.pushRoute('/levels')),
                AppLargeButton(label: 'Resume', onPressed: () {}),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
