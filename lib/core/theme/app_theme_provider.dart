import 'package:flutter/material.dart';
import 'package:point_marketing/core/theme/app_theme_mode_enum.dart';

class AppThemeProvider extends ChangeNotifier {
  AppThemeMode _themeMode = AppThemeMode.light;
  AppThemeMode get currentTheme => _themeMode;

  void setLightTheme() {
    _themeMode = AppThemeMode.light;
    notifyListeners();
  }

  void setDarkTheme() {
    _themeMode = AppThemeMode.dark;
    notifyListeners();
  }
}
