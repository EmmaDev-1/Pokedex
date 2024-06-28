import 'package:flutter/material.dart';

// light mode

ThemeData lightMode = ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
      background: Colors.grey.shade100,
      primary: Colors.grey.shade300,
      secondary: Colors.grey.shade400,
      tertiary: Colors.grey.shade500,
      inversePrimary: Colors.black,
    ));

// dark mode

ThemeData darkMode = ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
      background: Colors.grey.shade900,
      primary: Colors.grey.shade700,
      secondary: Colors.grey.shade600,
      tertiary: Colors.grey.shade500,
      inversePrimary: Colors.white,
    ));
