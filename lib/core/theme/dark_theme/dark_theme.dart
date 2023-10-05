import 'package:flutter/material.dart';

class DarkTheme {
  DarkTheme._();

  static const Color columbiaBlue = Color(0xffCCDFE4);
  static const Color darkSkyBlue = Color(0xff99BECA);
  static const Color crystalBlue = Color(0xff669EAF);
  static const Color tealBlue = Color(0xff337D95);
  static const Color blueSapphire = Color(0xff005D7A);
  static const Color midnightGreen = Color(0xff004A62);
  static const Color richBlack = Color(0xff003849);
  static const Color daintree = Color(0xff002531);
  static const Color nero = Color(0xff180500);
  static const Color lightGrey = Color(0xffDCDCDC);
  static const Color richElectricBlue = Color(0xff0090CC);
  static const Color maastrichtBlue = Color(0xff002433);
  static const Color ateneoBlue = Color(0xff004866);
  static const Color daintreeDark = Color(0xff021E2A);
  static const Color highLightBlue = Color(0xff0097D6);

  //decoration constants
  static const double textFieldCornerRadius = 15;
  static const double elevatedButtonCornetRadius = 20;
  static final OutlineInputBorder errorBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(textFieldCornerRadius),
    borderSide: const BorderSide(
      color: Color(0xff8B0000),
      width: 2.0,
    ),
  );

  static ThemeData get themeData => ThemeData(
        colorScheme: _colorScheme,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: ateneoBlue,
            foregroundColor: lightGrey,
            shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(elevatedButtonCornetRadius)),
          ),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: ateneoBlue,
        ),
        inputDecorationTheme: InputDecorationTheme(
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(textFieldCornerRadius),
            borderSide: const BorderSide(
              color: richElectricBlue,
              width: 2.0,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(textFieldCornerRadius),
          ),
          errorBorder: errorBorder,
          focusedErrorBorder: errorBorder,
          fillColor: _colorScheme.secondaryContainer,
          filled: true,
        ),
      );

  static ColorScheme get _colorScheme => const ColorScheme(
        brightness: Brightness.light,
        primary: daintree,
        onPrimary: Colors.white,
        secondary: richBlack,
        onSecondary: blueSapphire,
        secondaryContainer: lightGrey,
        onSecondaryContainer: maastrichtBlue,
        scrim: ateneoBlue,
        error: Colors.red,
        onError: Colors.white,
        background: daintreeDark,
        onBackground: midnightGreen,
        surface: ateneoBlue,
        onSurface: Colors.white,
        surfaceVariant: Colors.transparent,
        onSurfaceVariant: blueSapphire,
        inverseSurface: columbiaBlue,
        onInverseSurface: maastrichtBlue,
        outline: lightGrey,
        inversePrimary: highLightBlue,
      );
}
