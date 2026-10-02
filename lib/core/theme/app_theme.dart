import 'package:flutter/material.dart';

class AppTheme {
  static const Color navy = Color(0xFF0B1731);
  static const Color royalBlue = Color.fromARGB(255, 135, 141, 153);
  static const Color sky = Color(0xFF38BDF8);
  static const Color cyan = Color(0xFF22D3EE);
  static const Color lavender = Color(0xFF8B5CF6);
  static const Color mint = Color(0xFF34D399);
  static const Color green = Color(0xFF22C55E);
  static const Color amber = Color(0xFFF59E0B);
  static const Color red = Color(0xFFEF4444);
  static const Color background = Color(0xFFF5F7FF);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color muted = Color(0xFF6B7280);

  static ThemeData lightTheme() {
    final base = ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: ColorScheme.fromSeed(
        seedColor: royalBlue,
        brightness: Brightness.light,
      ).copyWith(
        primary: royalBlue,
        secondary: cyan,
        surface: surface,
      ),
      scaffoldBackgroundColor: background,
      cardTheme: const CardThemeData(
        elevation: 0,
        margin: EdgeInsets.zero,
        color: surface,
      ),
      dialogTheme: const DialogThemeData(
        backgroundColor: surface,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: royalBlue.withValues(alpha: 0.9)),
        ),
      ),
    );

    return base.copyWith(
      textTheme: base.textTheme.copyWith(
        headlineLarge: base.textTheme.headlineLarge?.copyWith(
          color: navy,
          fontWeight: FontWeight.w800,
        ),
        headlineMedium: base.textTheme.headlineMedium?.copyWith(
          color: navy,
          fontWeight: FontWeight.w700,
        ),
        titleLarge: base.textTheme.titleLarge?.copyWith(
          color: navy,
          fontWeight: FontWeight.w700,
        ),
        titleMedium: base.textTheme.titleMedium?.copyWith(
          color: navy,
          fontWeight: FontWeight.w600,
        ),
        bodyLarge: base.textTheme.bodyLarge?.copyWith(color: navy),
        bodyMedium: base.textTheme.bodyMedium?.copyWith(color: navy),
        labelLarge: base.textTheme.labelLarge?.copyWith(
          color: navy,
          fontWeight: FontWeight.w700,
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: surface,
        indicatorColor: royalBlue.withValues(alpha: 0.12),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const TextStyle(
              color: royalBlue,
              fontWeight: FontWeight.w700,
            );
          }
          return const TextStyle(
            color: muted,
            fontWeight: FontWeight.w600,
          );
        }),
      ),
      chipTheme: const ChipThemeData(
        shape: StadiumBorder(),
      ),
    );
  }
}

