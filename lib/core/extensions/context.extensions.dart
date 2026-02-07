import 'package:flutter/material.dart';

extension ContextExtensions on BuildContext {
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
  TextTheme get textTheme => Theme.of(this).textTheme;
  void pushRoute(String routeName) {
    Navigator.of(this).pushNamed(routeName);
  }

  void pop(String routeName) {
    Navigator.of(this).pop(routeName);
  }
}
