import 'package:flutter/material.dart';

TextTheme createTextTheme(BuildContext context) {
  final base = Theme.of(context).textTheme;

  final body = base.apply(fontFamily: "Amiri");
  final display = base.apply(fontFamily: "Cairo");
  final title = base.apply(fontFamily: "Cairo");
  final headline = base.apply(fontFamily: "Cairo");

  return display.copyWith(
    bodyLarge: body.bodyLarge,
    bodyMedium: body.bodyMedium,
    bodySmall: body.bodySmall,
    labelLarge: body.labelLarge,
    labelMedium: body.labelMedium,
    labelSmall: body.labelSmall,
    titleLarge: title.titleLarge,
    titleMedium: title.titleMedium,
    titleSmall: title.titleSmall,
    headlineLarge: headline.headlineLarge,
    headlineMedium: headline.headlineMedium,
    headlineSmall: headline.headlineSmall,
  );
}
