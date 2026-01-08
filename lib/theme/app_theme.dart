import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color backgroundBlack = Color(0xFF050510);
  static const Color surfaceDark = Color(0xFF101020);
  static const Color electricBlue = Color(0xFF00E5FF);
  static const Color neonPurple = Color(0xFFD500F9);
  static const Color softWhite = Color(0xFFF0F0FF);
  static const Color glassBorder = Color(0x33FFFFFF);

  static const Color backgroundLight = Color(0xFFF5F5FA);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color textDark = Color(0xFF050510);

  static ThemeData get darkTheme {
    return ThemeData.dark().copyWith(
      scaffoldBackgroundColor: backgroundBlack,
      primaryColor: electricBlue,
      colorScheme: const ColorScheme.dark(
        primary: electricBlue,
        secondary: neonPurple,
        surface: surfaceDark,
      ),
      textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme)
          .copyWith(
            displayLarge: GoogleFonts.poppins(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            titleLarge: GoogleFonts.poppins(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
            bodyLarge: GoogleFonts.poppins(color: softWhite),
          ),
      iconTheme: const IconThemeData(color: softWhite),
    );
  }

  static ThemeData get lightTheme {
    return ThemeData.light().copyWith(
      scaffoldBackgroundColor: backgroundLight,
      primaryColor: electricBlue, // Keep accents
      colorScheme: const ColorScheme.light(
        primary: electricBlue,
        secondary: neonPurple,
        surface: surfaceLight,
      ),
      textTheme: GoogleFonts.poppinsTextTheme(ThemeData.light().textTheme)
          .copyWith(
            displayLarge: GoogleFonts.poppins(
              color: textDark,
              fontWeight: FontWeight.bold,
            ),
            titleLarge: GoogleFonts.poppins(
              color: textDark,
              fontWeight: FontWeight.w600,
            ),
            bodyLarge: GoogleFonts.poppins(color: textDark),
          ),
      iconTheme: const IconThemeData(color: textDark),
    );
  }
}
