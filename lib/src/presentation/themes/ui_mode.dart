import 'package:flutter/material.dart';

class UiMode {
  static final darkMode = ThemeData(
    scaffoldBackgroundColor: Colors.grey[900],
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.white),
      bodyMedium: TextStyle(color: Colors.white70),
    ),
    appBarTheme: const AppBarTheme(
      color: Colors.teal,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(Colors.blue),
        textStyle: WidgetStateProperty.all(
          const TextStyle(color: Colors.white),
        ),
      ),
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: Colors.teal,
      textTheme: ButtonTextTheme.primary,
    ),
    colorScheme: ColorScheme.dark(
      primary: Colors.grey[800]!,
      secondary: Colors.grey[700]!,
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.all(Colors.blue),
        textStyle: WidgetStateProperty.all(
          const TextStyle(color: Colors.blue),
        ),
      ),
    ),
  );

  static final lightMode = ThemeData(
    scaffoldBackgroundColor: Colors.grey[200],
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.black),
      bodyMedium: TextStyle(color: Colors.black54),
    ),
    appBarTheme: const AppBarTheme(
      color: Colors.teal,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(Colors.blue),
        textStyle: WidgetStateProperty.all(
          const TextStyle(color: Colors.white),
        ),
      ),
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: Colors.teal,
      textTheme: ButtonTextTheme.primary,
    ),
    colorScheme: ColorScheme.light(
      primary: Colors.grey[300]!,
      secondary: Colors.white70,
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.all(Colors.blue),
        textStyle: WidgetStateProperty.all(
          const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
        ),
      ),
    ),
  );
}
