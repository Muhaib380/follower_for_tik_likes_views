import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Brand
  static const Color primary = Color(0xFF6C3CE9);
  static const Color primaryLight = Color(0xFF7B4DFF);
  static const Color primaryDeep = Color(0xFF5B2EE0);
  static const Color primaryDark = Color(0xFF1E1250);
  static const Color accent = Color(0xFFE63DB8);

  // Light mode
  static const Color background = Color(0xFFF4F3FF);
  static const Color surface = Colors.white;
  static const Color border = Color(0xFFE3E0F5);
  static const Color textPrimary = Color(0xFF1B1636);
  static const Color textSecondary = Color(0xFF7A7694);
  static const Color chipBackground = Color(0xFFEDE9FE);

  // Dark mode
  static const Color darkBackground = Color(0xFF0F0A2E);
  static const Color darkSurface = Color(0xFF1E1250);
  static const Color darkBorder = Color(0xFF3A2D7A);
  static const Color darkTextPrimary = Colors.white;
  static const Color darkTextSecondary = Color(0xFFB8B3D6);

  // Status
  static const Color success = Color(0xFF22C55E);
  static const Color error = Color(0xFFEF4444);
  static const Color warning = Color(0xFFF59E0B);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primaryLight, primaryDeep],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const LinearGradient splashGradient = LinearGradient(
    colors: [Color(0xFF6C3CE9), Color(0xFF1E1250), Color(0xFFE63DB8)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}