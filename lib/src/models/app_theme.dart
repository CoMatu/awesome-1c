import 'package:flutter/material.dart';

enum _AppThemeOptions {
  vanilla,
  legacy,
  material,
  simple,
  fuchsia,
  darcula,
  unknown,
}

class AppTheme {
  /// TODO: фоновая картинка в стиле вотсапа
  static const String fontFamily = 'JetBrainsMono';
  //static const TextTheme textTheme = TextTheme();

  final _AppThemeOptions _option;
  ThemeData get themeData => AppTheme._getThemeData(_option);
  static ThemeData get defaultThemeData => AppTheme._getThemeData(_AppThemeOptions.vanilla);
  const AppTheme._internal(this._option);

  factory AppTheme.vanilla() => const AppTheme._internal(_AppThemeOptions.vanilla);
  factory AppTheme.legacy() => const AppTheme._internal(_AppThemeOptions.legacy);
  factory AppTheme.material() => const AppTheme._internal(_AppThemeOptions.material);
  factory AppTheme.simple() => const AppTheme._internal(_AppThemeOptions.simple);
  factory AppTheme.fuchsia() => const AppTheme._internal(_AppThemeOptions.fuchsia);
  factory AppTheme.darcula() => const AppTheme._internal(_AppThemeOptions.darcula);

  static ThemeData _getThemeData(_AppThemeOptions option) {
    ThemeData _currentThemeRouter() {
      switch (option) {
        case (_AppThemeOptions.vanilla): return ThemeData(brightness: Brightness.light, primarySwatch: Colors.yellow, fontFamily: fontFamily,);
        case (_AppThemeOptions.legacy): return ThemeData(brightness: Brightness.light, primarySwatch: Colors.orange, fontFamily: fontFamily,);
        case (_AppThemeOptions.material): return ThemeData(brightness: Brightness.light, primarySwatch: Colors.blue, fontFamily: fontFamily,);
        case (_AppThemeOptions.simple): return ThemeData(brightness: Brightness.light, primarySwatch: Colors.lightBlue, fontFamily: fontFamily,);
        case (_AppThemeOptions.fuchsia): return ThemeData(brightness: Brightness.light, primarySwatch: Colors.pink, fontFamily: fontFamily,);
        case (_AppThemeOptions.darcula): return ThemeData(brightness: Brightness.dark, primarySwatch: Colors.deepPurple, fontFamily: fontFamily,);
        case (_AppThemeOptions.unknown):
        default: return ThemeData(brightness: Brightness.light, primarySwatch: Colors.yellow, fontFamily: fontFamily,);
      }      
    }
    return _currentThemeRouter();
    /*
    return _currentThemeRouter().copyWith(
      textTheme: textTheme,
    );
    */
  }
}

