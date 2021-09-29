import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:menu_editor/themes/text_styles.dart';
import 'package:menu_editor/themes/theme_colors.dart';

class Themes {
  Themes._();

  static const _smallInfinity = 1000.0;

  // MARK - Theme

  static final dark = ThemeData(
    brightness: Brightness.light,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    primarySwatch: ThemeColors.primarySwatch,
    primaryColor: ThemeColors.primary,
    primaryColorBrightness: Brightness.light,
    canvasColor: ThemeColors.grey,
    scaffoldBackgroundColor: ThemeColors.background,
    cardColor: ThemeColors.grey,
    dividerColor: ThemeColors.grey,
    focusColor: ThemeColors.primary,
    highlightColor: Colors.black.withOpacity(0.1),
    splashColor: Colors.black.withOpacity(0.1),
    backgroundColor: ThemeColors.background,
    dialogBackgroundColor: ThemeColors.grey,
    hintColor: ThemeColors.secondary,
    errorColor: Colors.red,
    textTheme: TextStyles.textTheme,
    primaryTextTheme: TextStyles.textTheme,
    iconTheme: iconTheme,
    primaryIconTheme: primaryIconTheme,
    appBarTheme: appBarTheme,
    bottomAppBarTheme: bottomAppBarTheme,
    colorScheme: colorScheme,
    dividerTheme: dividerTheme,
    elevatedButtonTheme: elevatedButtonTheme,
  );

  static final colorScheme = ColorScheme.fromSwatch(
    primarySwatch: ThemeColors.primarySwatch,
    primaryColorDark: ThemeColors.primaryDark,
    accentColor: ThemeColors.primary,
    cardColor: ThemeColors.grey,
    backgroundColor: ThemeColors.background,
    errorColor: Colors.red,
    brightness: Brightness.light,
  );

  static final iconTheme = const IconThemeData(color: Colors.black, opacity: 1.0, size: 22.0);

  static final primaryIconTheme = iconTheme.copyWith(color: ThemeColors.primary);

  static final appBarTheme = AppBarTheme(
    backgroundColor: ThemeColors.primary,
    foregroundColor: Colors.white,
    elevation: 0.0,
    shadowColor: Colors.transparent,
    iconTheme: iconTheme.copyWith(color: Colors.white),
    actionsIconTheme: iconTheme.copyWith(color: Colors.white),
    centerTitle: true,
    systemOverlayStyle: SystemUiOverlayStyle.light,
  );

  static final bottomAppBarTheme = const BottomAppBarTheme(
    color: ThemeColors.background,
    elevation: 0.0,
    shape: null,
  );

  static final dividerTheme = const DividerThemeData(
    color: ThemeColors.grey,
    space: double.infinity,
    thickness: 1.0,
    indent: 0.0,
    endIndent: 0.0,
  );

  static final elevatedButtonTheme = ElevatedButtonThemeData(style: elevatedButtonStyle);

  static final elevatedButtonStyle = ButtonStyle(
    textStyle: MaterialStateProperty.all(TextStyles.button),
    backgroundColor: MaterialStateProperty.all(ThemeColors.secondary),
    foregroundColor: MaterialStateProperty.all(Colors.black),
    minimumSize: MaterialStateProperty.all(const Size(0.0, 52.0)),
    shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(_smallInfinity))),
    mouseCursor: MaterialStateProperty.all(MouseCursor.uncontrolled),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    enableFeedback: true,
    alignment: Alignment.center,
  );
}
