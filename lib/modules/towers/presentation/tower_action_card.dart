import 'package:flutter/material.dart';
import 'package:gridbound_galaxy/core/extensions/context.extensions.dart';

class TowerActionCard extends StatelessWidget {
  final Color? textColor;
  final String label;
  final String content;
  const TowerActionCard({super.key, this.textColor, required this.label, required this.content});

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: context.textTheme.bodyMedium!.copyWith(color: textColor ?? context.colorScheme.onPrimaryContainer),
      child: Row(
        mainAxisSize: .min,
        children: [Text(label), Text(content)],
      ),
    );
  }
}
