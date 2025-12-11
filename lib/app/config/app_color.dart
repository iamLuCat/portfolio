import 'package:flutter/material.dart';

class AppColor {
  // Primary accent color
  static const Color primary = Color(0xFF00BFA6);

  // Dark background (footer / contact sections)
  static const Color dark = Color(0xFF2D3748);

  // Neutrals
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color grey = Color(0xFF9E9E9E);

  // Common alpha variants / approximations
  static const Color black87 = Color(0xDE000000); // ~Colors.black87
  static const Color whiteOpacity10 = Color(0x1AFFFFFF); // 10% white

  // Additional convenience colors (add as needed)
  static const Color surface = Color(0xFFF7F7F8);
  static const Color muted = Color(0xFF6B7280);

  // Added shades (material-like shades used across the app)
  static const Color grey100 = Color(0xFFF5F5F5);
  static const Color grey200 = Color(0xFFEEEEEE);
  static const Color grey300 = Color(0xFFE0E0E0);
  static const Color grey900 = Color(0xFF212121);

  // Accent / semantic colors
  static const Color blue = Color(0xFF3B82F6);
  static const Color textPrimary = Color(0xFF1F2937);

  // Semi-transparent blacks matching material tokens
  static const Color black26 = Color(0x42000000);
  static const Color black54 = Color(0x8A000000);

  // Optional explicit transparent constant
  static const Color transparent = Color(0x00000000);
}
