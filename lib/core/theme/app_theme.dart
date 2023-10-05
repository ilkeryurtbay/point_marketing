import 'package:flutter/material.dart';

import 'dark_theme/dark_theme.dart';
import 'light_theme/light_theme.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get lightTheme => LightTheme.themeData;
  static ThemeData get darkTheme => DarkTheme.themeData;
}
