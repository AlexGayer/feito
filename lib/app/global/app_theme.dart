import 'package:flutter/material.dart';

final darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: "PT_Sans-Narrow-Web",
    brightness: Brightness.dark,
    primaryColor: Colors.black,
    colorScheme: const ColorScheme.dark(
      primary: Color.fromARGB(255, 0, 238, 255),
      secondary: Color.fromARGB(255, 0, 238, 255),
      tertiary: Color.fromARGB(255, 0, 238, 255),
      surface: Color.fromARGB(255, 0, 238, 255),
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: Color.fromARGB(255, 0, 238, 255),
      textTheme: ButtonTextTheme.primary,
    ),
    textTheme: const TextTheme(
      titleLarge: TextStyle(
          color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
      titleMedium: TextStyle(
          color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
      titleSmall: TextStyle(
          color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
      bodyLarge: TextStyle(color: Colors.white),
      bodyMedium: TextStyle(color: Colors.white),
      bodySmall: TextStyle(color: Colors.white),
      labelLarge: TextStyle(color: Colors.white),
      labelMedium: TextStyle(color: Colors.white),
      labelSmall: TextStyle(color: Colors.white),
      displayLarge: TextStyle(
          color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold),
      displayMedium: TextStyle(color: Colors.black, fontSize: 18),
      displaySmall: TextStyle(color: Colors.black, fontSize: 12),
      headlineLarge: TextStyle(color: Colors.white),
      headlineMedium: TextStyle(color: Colors.white),
      headlineSmall: TextStyle(color: Colors.white),
    ),
    timePickerTheme: const TimePickerThemeData());

final lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: "PT_Sans-Narrow-Web",
    brightness: Brightness.light,
    primaryColor: Colors.black,
    colorScheme: const ColorScheme.light(
      primary: Color.fromARGB(255, 0, 238, 255),
      secondary: Color.fromARGB(255, 0, 238, 255),
      tertiary: Color.fromARGB(255, 0, 238, 255),
      surface: Color.fromARGB(255, 0, 238, 255),
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: Color.fromARGB(255, 0, 238, 255),
      textTheme: ButtonTextTheme.primary,
    ),
    textTheme: const TextTheme(
      titleLarge: TextStyle(
          color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
      titleMedium: TextStyle(color: Colors.white, fontSize: 14),
      titleSmall: TextStyle(color: Colors.white, fontSize: 12),
      bodyLarge: TextStyle(color: Colors.white),
      bodyMedium: TextStyle(color: Colors.white),
      bodySmall: TextStyle(color: Colors.white),
      labelLarge: TextStyle(
          color: Color.fromARGB(255, 0, 238, 255),
          fontSize: 18,
          fontWeight: FontWeight.bold),
      labelMedium: TextStyle(
          color: Color.fromARGB(255, 0, 238, 255),
          fontSize: 16,
          fontWeight: FontWeight.bold),
      labelSmall: TextStyle(
          color: Color.fromARGB(255, 0, 238, 255),
          fontSize: 12,
          fontWeight: FontWeight.bold),
      displayLarge: TextStyle(
          color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
      displayMedium: TextStyle(color: Colors.black, fontSize: 18),
      displaySmall: TextStyle(color: Colors.black, fontSize: 12),
      headlineLarge: TextStyle(color: Colors.white),
      headlineMedium: TextStyle(color: Colors.white),
      headlineSmall: TextStyle(color: Colors.white),
    ),
    timePickerTheme: const TimePickerThemeData());
