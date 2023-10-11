import 'package:flutter/material.dart';

extension BuilContextExtension on BuildContext {
  //Colors

  ColorScheme get colorScheme => Theme.of(this).colorScheme;
  Color get mainThemeColor => colorScheme.surface;
  Color get outlineColor => colorScheme.outline;
  Color get errorColor => colorScheme.error;
}
