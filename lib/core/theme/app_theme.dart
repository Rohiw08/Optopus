import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static final light = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    hoverColor: const Color(0xFFF5F5F5),
    colorScheme: const ColorScheme.light(
      surface: Color(0xFFFFFFFF),
      onSurface: Colors.black,
      primary: Color(0xFFDC143C),
      onPrimary: Colors.white,
      secondary: Color(0xFFDC143C),
      onSecondary: Colors.white,
      tertiary: Colors.blue, // Deep Sky Blue
      onTertiary: Colors.white,
      outline: Color(0xFFE0E0E0),
      outlineVariant: Color(0xFFBDBDBD),
      error: Color(0xFFB00020),
      onError: Colors.white,
    ),
    dividerColor: const Color(0xFFEEEEEE),
    textTheme: GoogleFonts.interTextTheme(ThemeData.light().textTheme),
    iconTheme: const IconThemeData(color: Color(0xFF1E1E1E)),
    useMaterial3: true,
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        splashFactory: NoSplash.splashFactory,
        overlayColor: WidgetStateProperty.all(Colors.transparent),
        foregroundColor: WidgetStateProperty.all(const Color(0xFF1E1E1E)),
        side: WidgetStateProperty.resolveWith<BorderSide>((states) {
          if (states.contains(WidgetState.hovered)) {
            return const BorderSide(color: Color(0xFF1E1E1E), width: 1);
          }
          return const BorderSide(color: Color(0xFFE0E0E0), width: 1);
        }),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        ),
        padding: WidgetStateProperty.all(
          const EdgeInsets.symmetric(horizontal: 16),
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.transparent,
      hintStyle: TextStyle(
        color: const Color(0xFF1E1E1E).withValues(alpha: 0.5),
        fontSize: 12, // Default from previous AuthTextfield change
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: const BorderSide(color: Color(0xFFE0E0E0), width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: const BorderSide(color: Color(0xFFDC143C), width: 1),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: const BorderSide(color: Color(0xFFE0E0E0), width: 1),
      ),
    ),
  );

  static final dark = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xFF212121),
    hoverColor: const Color(0xFF2B2B2B),
    colorScheme: ColorScheme.dark(
      surface: const Color(0xFF1E1E1E), // Slightly darker surface
      surfaceBright: const Color(0xFF2C2C2C),
      onSurface: const Color(0xFFFFFFFF),
      primary: const Color(0xFFDC143C),
      onPrimary: Colors.white,
      secondary: const Color(0xFFDC143C),
      onSecondary: Colors.white,
      tertiary: Colors.blue,
      onTertiary: Colors.black,
      outline: const Color(0x1FFFFFFF), // ~12% White for subtle borders
      outlineVariant: const Color(0x24FFFFFF), // ~14% White for separators
      error: const Color(0xFFCF6679),
      onError: Colors.black,
    ),
    dividerColor: const Color(0xFF424242),
    textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme),
    iconTheme: const IconThemeData(color: Color(0xFFE0E0E0)),
    useMaterial3: true,
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        splashFactory: NoSplash.splashFactory,
        overlayColor: WidgetStateProperty.all(Colors.transparent),
        foregroundColor: WidgetStateProperty.all(const Color(0xFFE0E0E0)),
        side: WidgetStateProperty.resolveWith<BorderSide>((states) {
          if (states.contains(WidgetState.hovered)) {
            return const BorderSide(color: Color(0xFFE0E0E0), width: 1);
          }
          return BorderSide(color: Colors.white.withOpacity(0.08), width: 1);
        }),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        ),
        padding: WidgetStateProperty.all(
          const EdgeInsets.symmetric(horizontal: 16),
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFF1B1B1B), // Slightly darker input bg
      hintStyle: TextStyle(
        color: const Color(0xFFE0E0E0).withValues(alpha: 0.5),
        fontSize: 12,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: BorderSide(color: Colors.white.withOpacity(0.08), width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: const BorderSide(color: Color(0xFFDC143C), width: 1),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: BorderSide(color: Colors.white.withOpacity(0.08), width: 1),
      ),
    ),
  );
}
