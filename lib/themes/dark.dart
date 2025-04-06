import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData darkMode = ThemeData(
  colorScheme: const ColorScheme.dark(
    surface: Color.fromARGB(255, 22, 22, 18),
    primary: Color.fromARGB(255, 36, 34, 34),
    secondary: Color.fromARGB(255, 85, 84, 84),
    tertiary: Color.fromARGB(255, 70, 70, 64),
    surfaceDim: Color.fromARGB(255, 64, 82, 97),
  ),
  appBarTheme: const AppBarTheme(
    titleTextStyle: TextStyle(
      fontSize: 20,
      color: Color.fromARGB(255, 254, 255, 235),
    ),
  ),
  inputDecorationTheme: const InputDecorationTheme(
    hintStyle: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
    ),
    prefixIconColor: Color.fromRGBO(119, 119, 119, 1),
  ),
  textTheme: TextTheme(
      titleLarge: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 35,
      ),
      titleMedium: GoogleFonts.aBeeZee(),
      bodySmall: GoogleFonts.arbutus()),
  useMaterial3: true,
);
