import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF00A9FF),
      brightness: Brightness.light,
    ),
    useMaterial3: true,
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        fontSize: 32.0,
        fontWeight: FontWeight.bold,
        color: Color(0xFF00A9FF),
      ),
      bodyLarge: TextStyle(
        fontSize: 16.0,
        color: Colors.black87,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF00A9FF),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(vertical: 16.0),
      ),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF00A9FF),
      brightness: Brightness.dark,
    ),
    useMaterial3: true,
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        fontSize: 32.0,
        fontWeight: FontWeight.bold,
        color: Color(0xFF00A9FF),
      ),
      bodyLarge: TextStyle(
        fontSize: 16.0,
        color: Colors.white70,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF00A9FF),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(vertical: 16.0),
      ),
    ),
  );
}
