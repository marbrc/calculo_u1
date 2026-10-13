import 'package:flutter/material.dart';

/// Paleta azul marino + acentos de color para que se vea personalizada.
class AppColors {
  static const marino = Color(0xFF0B1F44);
  static const marinoClaro = Color(0xFF1B3A73);
  static const cielo = Color(0xFF4FC3F7);
  static const coral = Color(0xFFFF7A59);
  static const menta = Color(0xFF3DDC97);
  static const fondo = Color(0xFFF2F5FB);
}

class AppTheme {
  static final ThemeData tema = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.fondo,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.marino,
      primary: AppColors.marino,
      secondary: AppColors.cielo,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.marino,
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.marino,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
    ),
  );
}
