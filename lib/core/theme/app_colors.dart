import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Primary Colors (温かみのあるアンバー系)
  static const Color primary = Color(0xFFFF8F00); // Orange 800
  static const Color primaryLight = Color(0xFFFFF3E0); // Orange 50  
  static const Color primaryMedium = Color(0xFFFFE0B2); // Orange 200
  static const Color primaryDark = Color(0xFFE65100); // Deep Orange 800

  // Secondary Colors (ウォームグレー系)
  static const Color secondary = Color(0xFF8D6E63); // Brown 300
  static const Color secondaryLight = Color(0xFFEFEBE9); // Brown 50
  static const Color secondaryDark = Color(0xFF5D4037); // Brown 700

  // Background Colors
  static const Color background = Color(0xFFFAFAFA); // Grey 50
  static const Color surface = Color(0xFFFFFFFF); // White
  static const Color card = Color(0xFFF5F5F5); // Grey 100

  // Accent Colors
  static const Color accentHeart = Color(0xFFE91E63); // Pink 500
  static const Color success = Color(0xFF4CAF50); // Green 500
  static const Color warning = Color(0xFFFF9800); // Orange 500
  static const Color error = Color(0xFFF44336); // Red 500

  // Text Colors
  static const Color textPrimary = Color(0xFF212121); // Grey 900
  static const Color textSecondary = Color(0xFF757575); // Grey 600
  static const Color textDisabled = Color(0xFFBDBDBD); // Grey 400
  static const Color textOnPrimary = Color(0xFFFFFFFF); // White
}