import 'package:flutter/material.dart';

class AppColors {
  /// Background Colors
  static const Color backgroundDark = Color(0xFF0D0E15);
  static const Color backgroundDarker = Color(0xFF07080C);
  static const Color cardDark = Color(0xFF161824);
  
  /// Accent Colors
  static const Color neonBlue = Color(0xFF00F0FF);
  static const Color purple = Color(0xFF8A2BE2);
  static const Color moneyGreen = Color(0xFF00E676);
  static const Color lightBlue = Color(0xFF40C4FF);

  /// Text Colors
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFA0A3B1);
  static const Color textDark = Color(0xFF1A1A24);

  /// Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [neonBlue, purple],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient successGradient = LinearGradient(
    colors: [moneyGreen, neonBlue],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
}
