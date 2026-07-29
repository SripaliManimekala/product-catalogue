import 'package:flutter/material.dart';

class AppTheme {
  static const _seedColor = Color.fromARGB(255, 13, 70, 106);

  static ThemeData darkTheme = _base(
    ColorScheme.fromSeed(
      seedColor: _seedColor,
      brightness: Brightness.dark,
    ),
  );

  static ThemeData lightTheme = _base(
     ColorScheme.fromSeed(
      seedColor: _seedColor,
      brightness: Brightness.light,
    ),
  );

  static ThemeData _base(ColorScheme colorScheme) {
    return ThemeData(
         colorScheme: colorScheme,
      scaffoldBackgroundColor: colorScheme.surface,
       appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
        scrolledUnderElevation: 2,
        centerTitle: false,
        titleTextStyle: TextStyle(
          color: colorScheme.onSurface,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
       cardTheme: CardThemeData(
        color: colorScheme.surfaceContainerLow,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        clipBehavior: Clip.antiAlias,
      ),
    );
  }
}