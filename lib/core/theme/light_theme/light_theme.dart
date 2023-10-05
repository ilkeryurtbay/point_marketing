import 'package:flutter/material.dart';

class LightTheme {
  LightTheme._();

  static const Color mainThemeColor = Color(0xffD92337);
  static const Color fillColor = Color(0xffF4F4F4);
  static const Color enabledOutlineColor = Color(0xff33C3FF);
  static const Color outLineColor = Color(0xff86868B);

  //decoration constants
  static const double textFieldCornerRadius = 8;
  static const double elevatedButtonCornetRadius = 30;
  static final OutlineInputBorder errorBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(textFieldCornerRadius),
    borderSide: const BorderSide(
      color: Colors.red,
      width: 2.0,
    ),
  );

  static final elevatedButtonThemeData = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
        backgroundColor: mainThemeColor,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(elevatedButtonCornetRadius)),
        elevation: 0,
        fixedSize: const Size(double.maxFinite, 40)),
  );

  static ThemeData get themeData {
    return ThemeData(
      colorScheme: _colorScheme,
      scaffoldBackgroundColor: Colors.white,
      elevatedButtonTheme: elevatedButtonThemeData,
      appBarTheme: AppBarTheme(
          color: Colors.white,
          elevation: 0,
          centerTitle: true,
          toolbarHeight: 20,
          foregroundColor: Colors.black),
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: Colors.black,
      ),
      inputDecorationTheme: InputDecorationTheme(
        contentPadding:
            const EdgeInsets.only(left: 16.0, bottom: 20.0, top: 20.0),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(textFieldCornerRadius),
          borderSide: const BorderSide(
            color: enabledOutlineColor,
            width: 2.0,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(textFieldCornerRadius),
          borderSide: const BorderSide(
            color: outLineColor,
          ),
        ),
        errorBorder: errorBorder,
        focusedErrorBorder: errorBorder,
        fillColor: _colorScheme.secondaryContainer,
        filled: true,
        floatingLabelStyle:
            const TextStyle(color: enabledOutlineColor, fontSize: 18),
      ),
    );
  }

  static ColorScheme get _colorScheme => const ColorScheme(
        brightness: Brightness.light,
        primary: mainThemeColor,
        onPrimary: Colors.white,
        secondary: Colors.white,
        onSecondary: Colors.black,
        error: Colors.red,
        onError: Colors.white,
        background: Colors.white,
        onBackground: Colors.black,
        surface: mainThemeColor,
        onSurface: Colors.black,
        outline: outLineColor,
      );
}
