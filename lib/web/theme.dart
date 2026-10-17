import 'package:flutter/material.dart';

/// Centralized design tokens for the Bhagavad Gita website.
/// Grounded in an editorial devotional palette: deep crimson, warm ivory,
/// linen, antique gold, and deep warm earth charcoal text.
abstract final class GitaColors {
  // Primary identity reds
  static const vermillion = Color(0xFF8E0E00);
  static const crimson = Color(0xFFB71C1C);
  static const red = Color(0xFFD32F2F);
  static const saffron = Color(0xFFE65100);

  // Warm devotional golds & ambers
  static const gold = Color(0xFFFFD54F);
  static const amber = Color(0xFFFFB300);
  static const antiqueGold = Color(0xFFD4AF37);
  static const goldAccent = Color(0xFFC59B27);
  static const peach = Color(0xFFE5DFD5);

  // Warm backgrounds & surfaces (Editorial architectural neutrals, eliminating orange/peach cast)
  static const ivory = Color(0xFFFAF8F5);
  static const cream = Color(0xFFF2EFE8);
  static const linen = Color(0xFFF7F5F0);
  static const warmWhite = Color(0xFFFAF9F6);
  static const pureWhite = Color(0xFFFFFFFF);

  // Dark backgrounds & cards
  static const darkBg = Color(0xFF2C0B0E);
  static const darkCard = Color(0xFF3D1518);

  // High-contrast, warm typography colors
  static const textDark = Color(0xFF2C1A1D);
  static const textMedium = Color(0xFF5D443D);
  static const textLight = Color(0xFF887068);
  static const textOnDark = Color(0xFFFFF9EE);

  // Borders & Dividers
  static const surfaceBorder = Color(0xFFE5DFD5);
  static const borderLight = Color(0xFFECE7DF);
  static const surfaceCard = Color(0xFFFFFFFF);
  static const surfaceSubtle = Color(0xFFF2EFE8);

  // Status indicators
  static const statusActive = Color(0xFF2E7D32);
  static const statusActiveBg = Color(0xFFE8F5E9);
}

/// Reusable typography tokens for the website.
abstract final class GitaTextStyles {
  static const _baseFont = 'Roboto';

  static const heroHeadline = TextStyle(
    fontFamily: _baseFont,
    fontSize: 44,
    fontWeight: FontWeight.w800,
    color: GitaColors.textDark,
    letterSpacing: -0.5,
    height: 1.18,
  );

  static const sectionHeading = TextStyle(
    fontFamily: _baseFont,
    fontSize: 28,
    fontWeight: FontWeight.w700,
    color: GitaColors.textDark,
    letterSpacing: -0.3,
    height: 1.25,
  );

  static const sectionSubheading = TextStyle(
    fontFamily: _baseFont,
    fontSize: 16.5,
    fontWeight: FontWeight.w400,
    color: GitaColors.textMedium,
    height: 1.6,
  );

  static const bodyText = TextStyle(
    fontFamily: _baseFont,
    fontSize: 15.5,
    fontWeight: FontWeight.w400,
    color: GitaColors.textMedium,
    height: 1.65,
  );

  static const eyebrow = TextStyle(
    fontFamily: _baseFont,
    fontSize: 11.5,
    fontWeight: FontWeight.w700,
    letterSpacing: 1.6,
    color: GitaColors.crimson,
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
    fontSize: 14.5,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.2,
  );

  static const buttonLabel = TextStyle(
    fontFamily: _baseFont,
    fontSize: 15,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.3,
  );
}

/// Responsive layout constants.
abstract final class GitaLayout {
  static const double maxContentWidth = 1080.0;
  static const double headerHeight = 64.0;
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
