import 'package:flutter/material.dart';

class AppColors {
  // Primary Brand Colors
  static const Color primary = Color(0xFF2E8B57); // Emerald Green
  static const Color primaryDark = Color(0xFF006A60); // Dark Teal
  static const Color primaryLight = Color(0xFF40E0D0); // Turquoise

  // Secondary Colors
  static const Color secondary = Color(0xFF00BFA6);
  static const Color accent = Color(0xFFD4AF37); // Gold
  static const Color accentLight = Color(0xFFE8C872);

  // Background Colors
  static const Color background = Color(0xFFF9F9F9); // Ivory White
  static const Color backgroundDark = Color(0xFF1E1E1E); // Charcoal Gray
  static const Color cardBackground = Color(0xFFFFFFFF);
  static const Color cardBackgroundDark = Color(0xFF2A2A2A);

  // Text Colors
  static const Color textPrimary = Color(0xFF1E1E1E);
  static const Color textSecondary = Color(0xFF666666);
  static const Color textLight = Color(0xFF999999);
  static const Color textWhite = Color(0xFFFFFFFF);
  static const Color textGold = Color(0xFFD4AF37);

  // Status Colors
  static const Color success = Color(0xFF4CAF50);
  static const Color error = Color(0xFFE53935);
  static const Color warning = Color(0xFFFF9800);
  static const Color info = Color(0xFF2196F3);

  // Hadith Classification Colors
  static const Color sahih = Color(0xFF4CAF50); // Green - Authentic
  static const Color hasan = Color(0xFF8BC34A); // Light Green - Good
  static const Color daif = Color(0xFFFF9800); // Orange - Weak
  static const Color mawdu = Color(0xFFE53935); // Red - Fabricated

  // Border & Divider Colors
  static const Color border = Color(0xFFE0E0E0);
  static const Color borderDark = Color(0xFF404040);
  static const Color divider = Color(0xFFEEEEEE);

  // Shadow Colors
  static const Color shadow = Color(0x1A000000);
  static const Color shadowDark = Color(0x40000000);

  // Overlay Colors
  static const Color overlay = Color(0x80000000);
  static const Color overlayLight = Color(0x40000000);

  // Gradient Colors
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF2E8B57), Color(0xFF006A60)],
  );

  static const LinearGradient goldGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFD4AF37), Color(0xFFE8C872)],
  );

  static const LinearGradient subtleGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFFF9F9F9), Color(0xFFFFFFFF)],
  );

  // Input Field Colors
  static const Color inputBackground = Color(0xFFF5F5F5);
  static const Color inputBorder = Color(0xFFE0E0E0);
  static const Color inputFocused = Color(0xFF2E8B57);
  static const Color inputError = Color(0xFFE53935);

  // Islamic Pattern Colors
  static const Color patternLight = Color(0x0DFFFFFF); // 5% white
  static const Color patternMedium = Color(0x1AFFFFFF); // 10% white

  // Shimmer Effect Colors (for loading states)
  static const Color shimmerBase = Color(0xFFE0E0E0);
  static const Color shimmerHighlight = Color(0xFFF5F5F5);

  // Dark Mode Colors
  static const Color darkPrimary = Color(0xFF40E0D0);
  static const Color darkBackground = Color(0xFF121212);
  static const Color darkSurface = Color(0xFF1E1E1E);
  static const Color darkCard = Color(0xFF2A2A2A);

  // Utility method to get color with opacity
  static Color withOpacity(Color color, double opacity) {
    return color.withOpacity(opacity);
  }

  // Utility method to get hadith classification color
  static Color getHadithColor(String classification) {
    switch (classification.toLowerCase()) {
      case 'sahih':
      case 'صحيح':
        return sahih;
      case 'hasan':
      case 'حسن':
        return hasan;
      case 'daif':
      case 'ضعيف':
        return daif;
      case 'mawdu':
      case 'موضوع':
        return mawdu;
      default:
        return textSecondary;
    }
  }

  // Utility method to get status color with icon
  static Color getStatusColor(bool isAuthentic) {
    return isAuthentic ? success : error;
  }
}

