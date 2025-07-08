import 'package:flutter/material.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    useMaterial3: true,
    scaffoldBackgroundColor: Colors.white,
    colorSchemeSeed: Colors.orange,
    bottomAppBarTheme: BottomAppBarTheme(color: Colors.white),
  );

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    useMaterial3: true,
    scaffoldBackgroundColor: Colors.grey[800],
    colorSchemeSeed: Colors.orange,
    bottomAppBarTheme: BottomAppBarTheme(color: Colors.black),
  );
}
