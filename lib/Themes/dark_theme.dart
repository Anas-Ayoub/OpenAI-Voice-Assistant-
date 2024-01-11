import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ThemeData darkTheme = ThemeData(
//   primaryColor: Colors.grey[800]!,
//   brightness: Brightness.dark,
//   appBarTheme: AppBarTheme(
//     backgroundColor:
//         Color.fromARGB(255, 24, 23, 23), //Color.fromARGB(255, 37, 45, 58),
//     elevation: 0,
//     titleTextStyle: GoogleFonts.aBeeZee(color: Colors.white, fontSize: 20),
//   ),
//   colorScheme: ColorScheme.dark(
//     background: Color.fromARGB(255, 18, 18, 18),
//     primary: const Color.fromARGB(255, 30, 30, 30),
//     secondary: Colors.grey[800]!,
//   ),
// );

ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  primaryColor: Color.fromARGB(255, 27, 27, 27),
  appBarTheme: AppBarTheme(
    backgroundColor: const Color.fromARGB(255, 3, 39, 68),
    elevation: 0,
    titleTextStyle: GoogleFonts.aBeeZee(color: Colors.white, fontSize: 20),
  ),
  scaffoldBackgroundColor: Color.fromARGB(255, 0, 0, 0),
  cardTheme: const CardTheme(
    color: Color.fromARGB(155, 46, 148, 231),
    elevation: 3,
    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 18),
  ),
  colorScheme: const ColorScheme.dark(
    error: Color(0xFFE57373),
    outline: Colors.white,
  ),
  textTheme: TextTheme(
    labelSmall: GoogleFonts.aBeeZee(
        color: const Color.fromARGB(255, 182, 182, 182), fontSize: 11.7),
    bodyLarge: GoogleFonts.aBeeZee(color: Colors.white, fontSize: 20),
    bodySmall: GoogleFonts.aBeeZee(
        color: const Color.fromARGB(255, 214, 214, 214), fontSize: 13.5),
    bodyMedium: GoogleFonts.aBeeZee(
        color: const Color.fromARGB(255, 255, 255, 255), fontSize: 16),
    titleMedium: GoogleFonts.aBeeZee(
        color: const Color.fromARGB(255, 255, 255, 255),
        fontSize: 20,
        fontWeight: FontWeight.bold),
    titleLarge: GoogleFonts.aBeeZee(
        color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),
  ),
);
