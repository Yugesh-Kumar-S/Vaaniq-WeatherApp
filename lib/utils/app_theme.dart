import 'package:flutter/material.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    useMaterial3: true,
    scaffoldBackgroundColor: Colors.grey[400],
    bottomAppBarTheme: BottomAppBarThemeData(color: Colors.white),
    textTheme: TextTheme(labelLarge: TextStyle(color: Colors.white)),
  );

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    useMaterial3: true,
    scaffoldBackgroundColor: Colors.grey[800],
    bottomAppBarTheme: BottomAppBarThemeData(color: Colors.black),
    textTheme: TextTheme(labelLarge: TextStyle(color: Colors.black)),
  );
}
