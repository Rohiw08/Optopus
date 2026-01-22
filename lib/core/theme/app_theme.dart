import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static final light = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    colorScheme: ColorScheme.light(
      surface: const Color(0xfff9f9f9),
      onSurface: Colors.black,
      outline: const Color(
        0xffe0e0e0,
      ), // Normalized from Colors.grey[500] with opacity
      primary: Colors.deepPurple,
    ),
    dividerColor: Colors.grey[300],
    textTheme: GoogleFonts.interTextTheme(ThemeData.light().textTheme),
    iconTheme: const IconThemeData(color: Color(0xff4D4D4D)),
  );

  static final dark = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xFF1E1E1E),
    colorScheme: ColorScheme.dark(
      surface: const Color(0xFF2D2D2D),
      onSurface: Colors.white,
      outline: const Color(0xFF404040),
      primary: Colors.deepPurpleAccent,
    ),
    dividerColor: const Color(0xFF404040),
    textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme),
    iconTheme: const IconThemeData(color: Color(0xFFB0B0B0)),
  );
}
