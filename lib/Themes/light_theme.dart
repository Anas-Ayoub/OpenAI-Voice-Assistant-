import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  primaryColor: Color.fromARGB(228, 255, 255, 255),
  appBarTheme: AppBarTheme(
    backgroundColor: Color.fromARGB(255, 194, 228, 255),
    elevation: 0,
    titleTextStyle: GoogleFonts.aBeeZee(color: Colors.black, fontSize: 20),
  ),
  scaffoldBackgroundColor: Color.fromARGB(255, 240, 240, 240),
  cardTheme: const CardTheme(
    color: Color.fromARGB(199, 151, 202, 243),
    elevation: 3,
    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 18),
  ),
  colorScheme: const ColorScheme.light(
    error: Color(0xFFE57373),
    outline: Colors.black,
  ),
  textTheme: TextTheme(
    labelSmall: GoogleFonts.aBeeZee(
        color: Color.fromARGB(255, 59, 59, 59), fontSize: 11.7),
    bodyLarge: GoogleFonts.aBeeZee(color: Colors.black, fontSize: 20),
    bodySmall: GoogleFonts.aBeeZee(
        color: Color.fromARGB(255, 24, 24, 24), fontSize: 13.5),
    bodyMedium:
        GoogleFonts.aBeeZee(color: Color.fromARGB(255, 0, 0, 0), fontSize: 16),
    titleMedium: GoogleFonts.aBeeZee(
        color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
    titleLarge: GoogleFonts.aBeeZee(
        color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25),
  ),
);
