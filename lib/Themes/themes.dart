import 'package:flutter/material.dart';

class AppThemes {
  AppThemes._();

  static MaterialColor colorCustom = const MaterialColor(
    0xFF2a6466,
    {
      50: Color(0xffe5eced),
      100: Color(0xffbfd1d1),
      200: Color(0xff95b2b3),
      300: Color(0xff6a9394),
      400: Color(0xff4a7b7d),
      500: Color(0xff2a6466),
      600: Color(0xff255c5e),
      700: Color(0xff1f5253),
      800: Color(0xff194849),
      900: Color(0xff0f3638),
    },
  );

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,

    // primaryColor: colorCustom,
    // primarySwatch: MaterialColor(primary, swatch),
    sliderTheme: const SliderThemeData(activeTrackColor: Color(0xff1BAFB2)),
    colorScheme: ColorScheme(
      surfaceTint: Colors.white,
      brightness: Brightness.light,
      primary: const Color(0xff225153),
      onPrimary: const Color(0xff225153),
      secondary: const Color(0xff2BB294),
      onSecondary: const Color(0xff2BB294),
      tertiary: const Color(0xff225153),
      onTertiary: const Color(0xff225153),
      error: Colors.red,
      onError: Colors.red,
      background: Colors.white,
      onBackground: Colors.black,
      surface: colorCustom,
      onSurface: colorCustom,
    ),
    useMaterial3: true,
    // buttonTheme: ButtonThemeData(
    //   colorScheme: ColorScheme.fromSeed(seedColor: colorCustom),
    //   buttonColor: colorCustom,
    // ),
    appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xff2A6466),
        foregroundColor: Colors.white,
        titleTextStyle: TextStyle(fontSize: 15),
        centerTitle: true),
    // floatingActionButtonTheme: const FloatingActionButtonThemeData(
    //     backgroundColor: Colors.red, foregroundColor: Colors.white),
    scaffoldBackgroundColor: Colors.white,
  );

  static ThemeData darkTheme = ThemeData.dark().copyWith(
    brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrangeAccent),
    scaffoldBackgroundColor: Colors.green,
    useMaterial3: true,
  );
}
