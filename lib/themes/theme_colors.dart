import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class ThemeColors {
  ThemeColors._();

  static const primary = Color(0xFF14213D);
  static final primaryLight = primarySwatch.shade400;
  static final primaryDark = primarySwatch.shade600;
  static const primaryTransparent = Color(0x6614213D);
  static final primarySwatch = _ThemeSwatches.primarySwatch;

  static const secondary = Color(0xFFFCA311);

  static const background = Color(0xFFFFFFFF);
  static const grey = Color(0xFFE5E5E5);
}

class _ThemeSwatches {
  _ThemeSwatches._();

  static final primarySwatch = MaterialColor(ThemeColors.primary.value, {
    50: tintColor(ThemeColors.primary, 0.9),
    100: tintColor(ThemeColors.primary, 0.8),
    200: tintColor(ThemeColors.primary, 0.6),
    300: tintColor(ThemeColors.primary, 0.4),
    400: tintColor(ThemeColors.primary, 0.3),
    500: ThemeColors.primary,
    600: tintColor(ThemeColors.primary, 0.1),
    700: shadeColor(ThemeColors.primary, 0.2),
    800: shadeColor(ThemeColors.primary, 0.3),
    900: shadeColor(ThemeColors.primary, 0.4),
  });

  // static MaterialColor _generateMaterialColor(Color color) => MaterialColor(color.value, {
  //       50: tintColor(color, 0.9),
  //       100: tintColor(color, 0.8),
  //       200: tintColor(color, 0.6),
  //       300: tintColor(color, 0.4),
  //       400: tintColor(color, 0.2),
  //       500: color,
  //       600: shadeColor(color, 0.1),
  //       700: shadeColor(color, 0.2),
  //       800: shadeColor(color, 0.3),
  //       900: shadeColor(color, 0.4),
  //     });

  static int tintValue(int value, double factor) => max(0, min((value + ((255 - value) * factor)).round(), 255));

  static Color tintColor(Color color, double factor) => Color.fromRGBO(
        tintValue(color.red, factor),
        tintValue(color.green, factor),
        tintValue(color.blue, factor),
        1,
      );

  static int shadeValue(int value, double factor) => max(0, min(value - (value * factor).round(), 255));

  static Color shadeColor(Color color, double factor) => Color.fromRGBO(
        shadeValue(color.red, factor),
        shadeValue(color.green, factor),
        shadeValue(color.blue, factor),
        1,
      );
}
