import 'package:flutter/material.dart';
import '../core/config/app_colors.dart';

ThemeData buildLightTheme() {
  final cs = ColorScheme(
    brightness: Brightness.light,
    primary: AppColors.green,
    onPrimary: Colors.white,
    secondary: AppColors.orange,
    onSecondary: Colors.black,
    error: AppColors.red,
    onError: Colors.white,
    surface: Colors.white,
    onSurface: const Color(0xFF1C1B1F),
    surfaceVariant: const Color(0xFFF3F5F7),
    onSurfaceVariant: const Color(0xFF5E6A6F),
    outline: const Color(0xFFE3E7EA),
    outlineVariant: const Color(0xFFD3D8DC),
    background: Colors.white,
    onBackground: const Color(0xFF121212),
    tertiary: AppColors.gold,
    onTertiary: Colors.black,
  );

  return ThemeData(
    colorScheme: cs,
    scaffoldBackgroundColor: cs.background,
    useMaterial3: true,

    // Typography: slightly bolder headers for marketing style
    textTheme: Typography.blackCupertino.copyWith(
      headlineLarge: const TextStyle(fontWeight: FontWeight.w800),
      headlineMedium: const TextStyle(fontWeight: FontWeight.w800),
      headlineSmall: const TextStyle(fontWeight: FontWeight.w800),
      titleLarge: const TextStyle(fontWeight: FontWeight.w700),
      titleMedium: const TextStyle(fontWeight: FontWeight.w700),
      bodyMedium: const TextStyle(height: 1.25),
      bodySmall: const TextStyle(height: 1.25),
    ),

    appBarTheme: AppBarTheme(
      backgroundColor: cs.surface,
      foregroundColor: cs.onSurface,
      elevation: 0,
      centerTitle: true,
    ),

    cardTheme: CardThemeData(
      color: Color.alphaBlend(cs.primary.withOpacity(.06), cs.surfaceVariant),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      margin: EdgeInsets.zero,
    ),

    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: cs.primary,
        foregroundColor: cs.onPrimary,
        minimumSize: const Size.fromHeight(52),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: cs.primary,
        side: BorderSide(color: cs.primary, width: 1.2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),

    chipTheme: ChipThemeData(
      backgroundColor:
          Color.alphaBlend(cs.secondary.withOpacity(.12), cs.surface),
      labelStyle: TextStyle(color: cs.onSurface),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      side: BorderSide(color: cs.outlineVariant),
    ),

    dividerTheme: DividerThemeData(color: cs.outline),
    iconTheme: IconThemeData(color: cs.onSurface),
    listTileTheme: ListTileThemeData(iconColor: cs.onSurface),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: cs.surfaceVariant,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: cs.outlineVariant),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: cs.primary, width: 1.4),
      ),
    ),
  );
}

ThemeData buildDarkTheme() {
  final cs = ColorScheme(
    brightness: Brightness.dark,
    primary: AppColors.green,
    onPrimary: Colors.white,
    secondary: AppColors.orange,
    onSecondary: Colors.black,
    error: AppColors.red,
    onError: Colors.white,
    surface: const Color(0xFF151618),
    onSurface: Colors.white,
    surfaceVariant: const Color(0xFF1D2023),
    onSurfaceVariant: const Color(0xFFB7C0C6),
    outline: const Color(0xFF2B3237),
    outlineVariant: const Color(0xFF353C42),
    background: const Color(0xFF0F1113),
    onBackground: Colors.white,
    tertiary: AppColors.gold,
    onTertiary: Colors.black,
  );

  return buildLightTheme().copyWith(
    colorScheme: cs,
    scaffoldBackgroundColor: cs.background,
    textTheme: Typography.whiteCupertino,
    dividerTheme: DividerThemeData(color: cs.outline),
    inputDecorationTheme: buildLightTheme().inputDecorationTheme.copyWith(
          fillColor: cs.surfaceVariant,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(color: cs.primary, width: 1.4),
          ),
        ),
  );
}
