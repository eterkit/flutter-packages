import 'package:flutter/material.dart';

abstract class Themes {
  static buildDark(BuildContext context) => ThemeData(
        primaryTextTheme: Theme.of(context).primaryTextTheme.apply(
              bodyColor: Colors.white,
              displayColor: Colors.white,
            ),
        focusColor: Colors.white,
        dividerTheme: const DividerThemeData(
          color: Colors.white,
          space: 48,
        ),
        colorScheme: const ColorScheme.dark().copyWith(
          primary: Colors.orange[300],
        ),
        bottomAppBarTheme: BottomAppBarTheme(
          color: Colors.grey[800],
        ),
      );

  static buildLight(BuildContext context) => ThemeData(
        primaryTextTheme: Theme.of(context).primaryTextTheme.apply(
              bodyColor: Colors.black,
              displayColor: Colors.black,
            ),
        focusColor: Colors.black,
        dividerTheme: const DividerThemeData(
          color: Colors.black,
          space: 48,
        ),
        colorScheme: const ColorScheme.light().copyWith(
          primary: Colors.blue,
        ),
        bottomAppBarTheme: BottomAppBarTheme(
          color: Colors.grey[300],
        ),
      );
}
