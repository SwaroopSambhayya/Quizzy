import 'package:flutter/material.dart';

final ThemeData lightThemeData = ThemeData(
  useMaterial3: true,
  cardColor: Colors.deepPurpleAccent.withOpacity(0.1),
  colorSchemeSeed: Colors.deepPurpleAccent,
  appBarTheme: const AppBarTheme(
    color: Colors.deepPurpleAccent,
    foregroundColor: Colors.white,
  ),
);
