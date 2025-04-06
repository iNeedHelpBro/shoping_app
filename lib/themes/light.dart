import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData lightMode = ThemeData(
  colorScheme: ColorScheme.light(
    surface:  Color.fromARGB(255, 224, 224, 224),
    primary:  Color.fromARGB(255, 232, 201, 66),
    secondary: Color.fromARGB(255, 239, 236, 190),
    tertiary: Color.fromARGB(255, 255, 255, 231),
    surfaceDim: Color.fromARGB(255, 215, 237, 255),
  ),
  appBarTheme: const AppBarTheme(
    titleTextStyle: TextStyle(
      fontSize: 20,
      color: Color.fromARGB(255, 42, 37, 37),
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
