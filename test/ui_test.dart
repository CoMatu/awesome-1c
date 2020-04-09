import 'package:test/test.dart';
import 'package:flutter/material.dart' show Colors;
import 'package:awesome1c/src/models/app_theme.dart';

void main() {
  test('Color to hex', () {
    final String colorHexRepresentation = '#${Colors.blue?.value?.toRadixString(16)?.padLeft(8, '0') ?? '00000000'}';
    expect(colorHexRepresentation, '#ff2196f3');
  });

  test('Theme color', () {
    final AppTheme appTheme = AppTheme.material();
    final String appBarThemeColorHexRepresentation = '#${appTheme.themeData?.primaryColor?.value?.toRadixString(16)?.padLeft(8, '0') ?? '00000000'}';
    expect(appBarThemeColorHexRepresentation, '#ff2196f3');
  });

  test('Background color', () {
    final AppTheme appTheme = AppTheme.material();
    final String backgroundColorHexRepresentation = '#${appTheme.themeData?.backgroundColor?.value?.toRadixString(16)?.padLeft(8, '0') ?? '00000000'}';
    expect(backgroundColorHexRepresentation, '#ff90caf9');
  });
}