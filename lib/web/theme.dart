import 'package:flutter/material.dart';

/// Centralized design tokens for the Bhagavad Gita website.
/// Colors are drawn directly from the existing player's devotional palette.
abstract final class GitaColors {
  // Primary reds
  static const vermillion = Color(0xFF8E0E00);
  static const crimson = Color(0xFFB71C1C);
  static const red = Color(0xFFD32F2F);
  static const saffron = Color(0xFFE65100);

  // Golds and ambers
  static const gold = Color(0xFFFFD54F);
  static const amber = Color(0xFFFFB300);
  static const lightGold = Color(0xFFFFE082);
  static const peach = Color(0xFFFFCC80);

  // Warm backgrounds
  static const ivory = Color(0xFFFFF8E7);
  static const cream = Color(0xFFFFECD2);
  static const warmWhite = Color(0xFFFAF7F2);
  static const pureWhite = Color(0xFFFDFDFD);

  // Dark backgrounds (for contrast areas)
  static const darkBg = Color(0xFF2C0B0E);
  static const darkCard = Color(0xFF3D1518);

  // Text
  static const textDark = Color(0xFF3E2723);
  static const textMedium = Color(0xFF5D4037);
  static const textLight = Color(0xFF8D6E63);
  static const textOnDark = Color(0xFFFFF8E7);

  // Status badges
  static const statusActive = Color(0xFF2E7D32);
  static const statusActiveBg = Color(0xFFE8F5E9);
  static const statusPlanned = Color(0xFF757575);
  static const statusPlannedBg = Color(0xFFF5F5F5);

  // Surface & Borders
  static const surfaceBorder = Color(0xFFE8DFD5);
  static const surfaceCard = Color(0xFFFFFFFF);
  static const surfaceSubtle = Color(0xFFF8F5F0);
  static const goldAccent = Color(0xFFD4A017);
  static const tagBorder = Color(0xFFE5D5C5);
  static const darkBorder = Color(0x33FFD54F);
}

/// Reusable text styles for the website.
abstract final class GitaTextStyles {
  static const _baseFont = 'Roboto';

  static const heroHeadline = TextStyle(
    fontFamily: _baseFont,
    fontSize: 48,
    fontWeight: FontWeight.w800,
    color: GitaColors.textDark,
    letterSpacing: -0.5,
    height: 1.15,
  );

  static const sectionHeading = TextStyle(
    fontFamily: _baseFont,
    fontSize: 32,
    fontWeight: FontWeight.w700,
    color: GitaColors.textDark,
    letterSpacing: -0.3,
    height: 1.25,
  );

  static const sectionSubheading = TextStyle(
    fontFamily: _baseFont,
    fontSize: 18,
    fontWeight: FontWeight.w400,
    color: GitaColors.textMedium,
    height: 1.6,
  );

  static const bodyText = TextStyle(
    fontFamily: _baseFont,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: GitaColors.textMedium,
    height: 1.65,
  );

  static const caption = TextStyle(
    fontFamily: _baseFont,
    fontSize: 13,
    fontWeight: FontWeight.w500,
    color: GitaColors.textLight,
    height: 1.5,
  );

  static const navLink = TextStyle(
    fontFamily: _baseFont,
    fontSize: 15,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.3,
  );

  static const buttonLabel = TextStyle(
    fontFamily: _baseFont,
    fontSize: 16,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.5,
  );
}

/// Common layout constants.
abstract final class GitaLayout {
  static const double maxContentWidth = 1080.0;
  static const double headerHeight = 64.0;
  static const double sectionSpacing = 80.0;
  static const double mobileBreakpoint = 600.0;
  static const double tabletBreakpoint = 900.0;

  static const contentPadding = EdgeInsets.symmetric(horizontal: 24);

  static EdgeInsets responsivePadding(double screenWidth) {
    if (screenWidth > tabletBreakpoint) {
      return const EdgeInsets.symmetric(horizontal: 48);
    } else if (screenWidth > mobileBreakpoint) {
      return const EdgeInsets.symmetric(horizontal: 32);
    }
    return const EdgeInsets.symmetric(horizontal: 20);
  }
}
