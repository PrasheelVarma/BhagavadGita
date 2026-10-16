import 'package:flutter/material.dart';

import '../theme.dart';
import '../utils/url_launcher_helper.dart';

/// Professional public-facing product home page.
/// Follows high-standard software distribution architecture (e.g. Spacedesk style).
class HomePage extends StatelessWidget {
  final VoidCallback onOpenPlayer;

  const HomePage({super.key, required this.onOpenPlayer});

  static const String _androidReleaseUrl =
      'https://github.com/PrasheelVarma/BhagavadGita/releases/tag/v1.0-android';
  static const String _githubRepoUrl =
      'https://github.com/PrasheelVarma/BhagavadGita';

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // 1. Hero Section: Headline, trust badges, CTAs, album art
        _HeroSection(
          screenWidth: screenWidth,
          onOpenPlayer: onOpenPlayer,
          androidReleaseUrl: _androidReleaseUrl,
        ),

        // 2. Platform Matrix & Distribution Center (Spacedesk Download Grid)
        _PlatformMatrixSection(
          screenWidth: screenWidth,
          onOpenPlayer: onOpenPlayer,
          androidReleaseUrl: _androidReleaseUrl,
        ),

        // 3. Core Product Capabilities & Feature Breakdown
        _FeatureCapabilitiesSection(screenWidth: screenWidth),

        // 4. The 18 Chapters Recitation Guide & Spiritual Scope
        _ChapterRecitationGuideSection(screenWidth: screenWidth),

        // 5. Technical Specifications & Integrity Audit
        _TechSpecsSection(screenWidth: screenWidth),

        // 6. Step-by-Step Android Sideloading & Installation Guide
        _InstallationGuideSection(
          screenWidth: screenWidth,
          androidReleaseUrl: _androidReleaseUrl,
        ),

        // 7. Frequently Asked Questions (FAQ)
        _FaqSection(screenWidth: screenWidth),

        // 8. Bottom CTA Banner
        _BottomCtaBanner(
          screenWidth: screenWidth,
          onOpenPlayer: onOpenPlayer,
          androidReleaseUrl: _androidReleaseUrl,
        ),

        const SizedBox(height: 32),
      ],
    );
  }
}

// ===========================================================================
// 1. Hero Section
// ===========================================================================

class _HeroSection extends StatelessWidget {
  final double screenWidth;
  final VoidCallback onOpenPlayer;
  final String androidReleaseUrl;

  const _HeroSection({
    required this.screenWidth,
    required this.onOpenPlayer,
    required this.androidReleaseUrl,
  });

  bool get _isWide => screenWidth > GitaLayout.tabletBreakpoint;
  bool get _isMobile => screenWidth < GitaLayout.mobileBreakpoint;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            GitaColors.ivory,
            GitaColors.cream,
            GitaColors.warmWhite,
          ],
          stops: [0.0, 0.65, 1.0],
        ),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints:
              const BoxConstraints(maxWidth: GitaLayout.maxContentWidth + 96),
          child: Padding(
            padding: GitaLayout.responsivePadding(screenWidth).copyWith(
              top: _isMobile ? 36 : 64,
              bottom: _isMobile ? 40 : 68,
            ),
            child: _isWide ? _buildWideLayout() : _buildNarrowLayout(),
          ),
        ),
      ),
    );
  }

  Widget _buildWideLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 6,
          child: _buildTextContent(),
        ),
        const SizedBox(width: 56),
        Expanded(
          flex: 4,
          child: _buildArtworkShowcase(),
        ),
      ],
    );
  }

  Widget _buildNarrowLayout() {
    return Column(
      children: [
        _buildArtworkShowcase(),
        SizedBox(height: _isMobile ? 28 : 40),
        _buildTextContent(centered: true),
      ],
    );
  }

  Widget _buildTextContent({bool centered = false}) {
    return Column(
      crossAxisAlignment:
          centered ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        // Release & Platform Pill
        Wrap(
          alignment: centered ? WrapAlignment.center : WrapAlignment.start,
          spacing: 8,
          runSpacing: 6,
          children: [
            _buildBadge(
              icon: Icons.verified_rounded,
              label: 'v1.0.0 Stable Release',
              bgColor: GitaColors.statusActiveBg,
              fgColor: GitaColors.statusActive,
            ),
            _buildBadge(
              icon: Icons.offline_pin_rounded,
              label: '100% Offline (Android)',
              bgColor: const Color(0xFFFFF3E0),
              fgColor: const Color(0xFFE65100),
            ),
            _buildBadge(
              icon: Icons.security_rounded,
              label: 'Zero Ads / Zero Tracking',
              bgColor: const Color(0xFFEDE7F6),
              fgColor: const Color(0xFF512DA8),
            ),
          ],
        ),
        const SizedBox(height: 18),

        // Main Headline
        Text(
          'Bhagavad Gita Audio Player',
          style: GitaTextStyles.heroHeadline.copyWith(
            fontSize: _isMobile ? 32 : 48,
          ),
          textAlign: centered ? TextAlign.center : TextAlign.left,
        ),
        const SizedBox(height: 14),

        // Subtitle / Product description
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 620),
          child: Text(
            'The revered complete 73-minute Telugu recitation and commentary sung by Sri Ghantasala Venkateswara Rao. Built as a distraction-free, privacy-first audio player available as a native Android app and an instant in-browser web application.',
            style: GitaTextStyles.sectionSubheading.copyWith(
              fontSize: _isMobile ? 15 : 17.5,
              height: 1.6,
            ),
            textAlign: centered ? TextAlign.center : TextAlign.left,
          ),
        ),
        const SizedBox(height: 28),

        // CTAs: Web Player + APK Download
        Wrap(
          alignment: centered ? WrapAlignment.center : WrapAlignment.start,
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 16,
          runSpacing: 12,
          children: [
            _PrimaryButton(
              label: 'Launch Web Player',
              icon: Icons.play_arrow_rounded,
              onTap: onOpenPlayer,
              isMobile: _isMobile,
            ),
            _SecondaryButton(
              label: 'Download APK (v1.0)',
              icon: Icons.android_rounded,
              onTap: () => launchUrlSafely(androidReleaseUrl),
              isMobile: _isMobile,
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Micro-Specs Under CTAs
        Text(
          'Android 5.0+ to Android 15 • Standalone 27 MB APK • All Modern Web Browsers',
          style: TextStyle(
            fontSize: _isMobile ? 12 : 13,
            color: GitaColors.textLight,
            fontWeight: FontWeight.w500,
          ),
          textAlign: centered ? TextAlign.center : TextAlign.left,
        ),
      ],
    );
  }

  Widget _buildBadge({
    required IconData icon,
    required String label,
    required Color bgColor,
    required Color fgColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4.5),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: fgColor.withValues(alpha: 0.25), width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: fgColor),
          const SizedBox(width: 5),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: fgColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildArtworkShowcase() {
    final artSize = _isMobile ? 220.0 : (_isWide ? 310.0 : 260.0);

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: artSize,
            height: artSize,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Glowing radial backdrop
                Container(
                  width: artSize * 0.94,
                  height: artSize * 0.94,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: GitaColors.amber.withValues(alpha: 0.28),
                        blurRadius: 46,
                        spreadRadius: 8,
                      ),
                      BoxShadow(
                        color: GitaColors.crimson.withValues(alpha: 0.16),
                        blurRadius: 60,
                        spreadRadius: 4,
                      ),
                    ],
                  ),
                ),
                // Circular frame with album artwork
                Container(
                  width: artSize * 0.88,
                  height: artSize * 0.88,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: GitaColors.gold,
                      width: 2.5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.18),
                        blurRadius: 28,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      'assets/artwork.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.8),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFEADBCE), width: 1),
            ),
            child: const Text(
              'Sung by Sri Ghantasala Venkateswara Rao',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: GitaColors.crimson,
                letterSpacing: 0.2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// 2. Platform Matrix & Distribution Center (Spacedesk Reference Standard)
// ===========================================================================

class _PlatformMatrixSection extends StatelessWidget {
  final double screenWidth;
  final VoidCallback onOpenPlayer;
  final String androidReleaseUrl;

  const _PlatformMatrixSection({
    required this.screenWidth,
    required this.onOpenPlayer,
    required this.androidReleaseUrl,
  });

  bool get _isMobile => screenWidth < GitaLayout.mobileBreakpoint;
  bool get _isTablet => screenWidth < GitaLayout.tabletBreakpoint;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      child: Center(
        child: ConstrainedBox(
          constraints:
              const BoxConstraints(maxWidth: GitaLayout.maxContentWidth + 96),
          child: Padding(
            padding: GitaLayout.responsivePadding(screenWidth).copyWith(
              top: 56,
              bottom: 56,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Section Title
                _SectionTitle(
                  title: 'Platform Availability & Download Center',
                  subtitle:
                      'Engineered for instant browser streaming and native offline Android listening. Explore binaries and compatibility.',
                  isMobile: _isMobile,
                ),
                const SizedBox(height: 32),

                // Platform Cards Matrix
                if (_isMobile)
                  Column(
                    children: _buildPlatformCards(),
                  )
                else if (_isTablet)
                  Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    children: _buildPlatformCards(width: (screenWidth - 80) / 2),
                  )
                else
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (int i = 0; i < 4; i++) ...[
                        if (i > 0) const SizedBox(width: 16),
                        Expanded(child: _buildPlatformCardByIndex(i)),
                      ],
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildPlatformCards({double? width}) {
    final list = <Widget>[];
    for (int i = 0; i < 4; i++) {
      final card = _buildPlatformCardByIndex(i);
      list.add(
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: width != null ? SizedBox(width: width, child: card) : card,
        ),
      );
    }
    return list;
  }

  Widget _buildPlatformCardByIndex(int index) {
    switch (index) {
      case 0:
        return _DetailedPlatformCard(
          icon: Icons.android_rounded,
          platformName: 'Android Native App',
          version: 'v1.0.0 (APK)',
          statusText: 'Available',
          isActive: true,
          specs: const [
            '100% Offline (27 MB bundled audio)',
            'Android 5.0 (API 21) to Android 15',
            'Lock-screen & Notification controls',
            'No network permissions required',
          ],
          primaryActionText: 'Download APK',
          onPrimaryAction: () => launchUrlSafely(androidReleaseUrl),
          secondaryActionText: 'GitHub Release',
          onSecondaryAction: () => launchUrlSafely(androidReleaseUrl),
        );
      case 1:
        return _DetailedPlatformCard(
          icon: Icons.language_rounded,
          platformName: 'Web Application',
          version: 'Live In-Browser',
          statusText: 'Active',
          isActive: true,
          specs: const [
            'Zero installation required',
            'Desktop & mobile web browser support',
            'Interactive radial & linear scrubbers',
            'Continuous playback across pages',
          ],
          primaryActionText: 'Launch Player',
          onPrimaryAction: onOpenPlayer,
        );
      case 2:
        return const _DetailedPlatformCard(
          icon: Icons.desktop_windows_rounded,
          platformName: 'Windows Desktop',
          version: 'Cross-Platform',
          statusText: 'Planned',
          isActive: false,
          specs: [
            'Native 64-bit Windows bundle',
            'Flutter desktop runtime engine',
            'Hardware media hotkey integration',
            'Currently in development roadmap',
          ],
        );
      default:
        return const _DetailedPlatformCard(
          icon: Icons.terminal_rounded,
          platformName: 'Linux & macOS',
          version: 'Cross-Platform',
          statusText: 'Planned',
          isActive: false,
          specs: [
            'Native AppImage / Debian package',
            'macOS Universal Binary (Apple Silicon & Intel)',
            'MPRIS desktop media integration',
            'Scheduled for future release',
          ],
        );
    }
  }
}

class _DetailedPlatformCard extends StatelessWidget {
  final IconData icon;
  final String platformName;
  final String version;
  final String statusText;
  final bool isActive;
  final List<String> specs;
  final String? primaryActionText;
  final VoidCallback? onPrimaryAction;
  final String? secondaryActionText;
  final VoidCallback? onSecondaryAction;

  const _DetailedPlatformCard({
    required this.icon,
    required this.platformName,
    required this.version,
    required this.statusText,
    required this.isActive,
    required this.specs,
    this.primaryActionText,
    this.onPrimaryAction,
    this.secondaryActionText,
    this.onSecondaryAction,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: isActive ? Colors.white : const Color(0xFFFAF7F2),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isActive ? const Color(0xFFE2D6C8) : const Color(0xFFECE3DA),
          width: 1.2,
        ),
        boxShadow: isActive
            ? [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 14,
                  offset: const Offset(0, 4),
                ),
              ]
            : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top row: Icon + status
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: isActive ? GitaColors.ivory : Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: isActive ? GitaColors.crimson : Colors.grey.shade600,
                  size: 24,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: isActive
                      ? GitaColors.statusActiveBg
                      : GitaColors.statusPlannedBg,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isActive
                        ? GitaColors.statusActive.withValues(alpha: 0.3)
                        : Colors.grey.withValues(alpha: 0.3),
                    width: 1,
                  ),
                ),
                child: Text(
                  statusText,
                  style: TextStyle(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w700,
                    color: isActive
                        ? GitaColors.statusActive
                        : GitaColors.statusPlanned,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // Title & Version
          Text(
            platformName,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: isActive ? GitaColors.textDark : Colors.grey.shade700,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            version,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: isActive ? GitaColors.crimson : GitaColors.textLight,
            ),
          ),
          const SizedBox(height: 14),

          // Divider
          Container(
            height: 1,
            color: const Color(0xFFF0EAE1),
          ),
          const SizedBox(height: 14),

          // Specs bullet list
          for (final spec in specs)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    isActive ? Icons.check_circle_outline_rounded : Icons.schedule_rounded,
                    size: 15,
                    color: isActive ? GitaColors.statusActive : Colors.grey.shade500,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      spec,
                      style: TextStyle(
                        fontSize: 12.5,
                        color: isActive
                            ? GitaColors.textMedium
                            : Colors.grey.shade600,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),

          if (primaryActionText != null) ...[
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onPrimaryAction,
                style: ElevatedButton.styleFrom(
                  backgroundColor: GitaColors.crimson,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  primaryActionText!,
                  style: const TextStyle(
                    fontSize: 13.5,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],

          if (secondaryActionText != null) ...[
            const SizedBox(height: 8),
            Center(
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: onSecondaryAction,
                  child: Text(
                    secondaryActionText!,
                    style: const TextStyle(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w600,
                      color: GitaColors.crimson,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

// ===========================================================================
// 3. Core Product Capabilities & Feature Breakdown
// ===========================================================================

class _FeatureCapabilitiesSection extends StatelessWidget {
  final double screenWidth;

  const _FeatureCapabilitiesSection({required this.screenWidth});

  bool get _isMobile => screenWidth < GitaLayout.mobileBreakpoint;
  bool get _isTablet => screenWidth < GitaLayout.tabletBreakpoint;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: GitaColors.warmWhite,
      child: Center(
        child: ConstrainedBox(
          constraints:
              const BoxConstraints(maxWidth: GitaLayout.maxContentWidth + 96),
          child: Padding(
            padding: GitaLayout.responsivePadding(screenWidth).copyWith(
              top: 56,
              bottom: 56,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _SectionTitle(
                  title: 'Engineered for Devotional Listening',
                  subtitle:
                      'Designed from first principles to deliver an authentic, uninterrupted recitation experience with zero computational overhead.',
                  isMobile: _isMobile,
                ),
                const SizedBox(height: 32),

                // 6 Feature Grid Cards
                if (_isMobile)
                  Column(
                    children: _features
                        .map((f) => Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: _FeatureCard(feature: f),
                            ))
                        .toList(),
                  )
                else
                  Wrap(
                    spacing: 20,
                    runSpacing: 20,
                    children: _features
                        .map((f) => SizedBox(
                              width: _isTablet
                                  ? (screenWidth - 84) / 2
                                  : (GitaLayout.maxContentWidth + 96 - 48 - 40) / 3,
                              child: _FeatureCard(feature: f),
                            ))
                        .toList(),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static const List<_FeatureItem> _features = [
    _FeatureItem(
      icon: Icons.library_music_rounded,
      title: '73-Minute Unabridged Audio',
      description:
          'Contains the complete Sanskrit slokas alongside clear Telugu commentary rendered by Sri Ghantasala Venkateswara Rao in a single continuous stream.',
    ),
    _FeatureItem(
      icon: Icons.album_rounded,
      title: 'Dual Radial & Linear Scrubbing',
      description:
          'Seek effortlessly via the interactive circular dial surrounding the artwork or the synchronized horizontal progress bar with millisecond accuracy.',
    ),
    _FeatureItem(
      icon: Icons.notifications_active_rounded,
      title: 'Lock-Screen & Background Playback',
      description:
          'On Android, playback continues reliably when the app is minimized or the screen is locked, integrated directly into system media controls.',
    ),
    _FeatureItem(
      icon: Icons.bedtime_rounded,
      title: 'Sleep Timer with Countdown',
      description:
          'Set a 15, 30, 45, or 60-minute sleep timer for evening meditation or bedtime listening. Includes live real-time countdown feedback.',
    ),
    _FeatureItem(
      icon: Icons.speed_rounded,
      title: 'Precision Speed Control',
      description:
          'Calibrate playback tempo between 0.75x, 1.0x, 1.25x, 1.5x, and 2.0x to facilitate close study, chanting practice, or quick revision.',
    ),
    _FeatureItem(
      icon: Icons.shield_rounded,
      title: 'Absolute Privacy & Zero Ads',
      description:
          'No user accounts, no tracking pixels, zero analytics SDKs, and no telemetry. Playback runs strictly on your device without transmitting data.',
    ),
  ];
}

class _FeatureItem {
  final IconData icon;
  final String title;
  final String description;

  const _FeatureItem({
    required this.icon,
    required this.title,
    required this.description,
  });
}

class _FeatureCard extends StatelessWidget {
  final _FeatureItem feature;

  const _FeatureCard({required this.feature});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE8E0D5), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.025),
            blurRadius: 12,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: GitaColors.ivory,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: GitaColors.peach, width: 0.8),
            ),
            child: Icon(
              feature.icon,
              color: GitaColors.crimson,
              size: 22,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            feature.title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: GitaColors.textDark,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            feature.description,
            style: const TextStyle(
              fontSize: 13.5,
              color: GitaColors.textMedium,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// 4. The 18 Chapters Recitation Guide & Spiritual Scope
// ===========================================================================

class _ChapterRecitationGuideSection extends StatelessWidget {
  final double screenWidth;

  const _ChapterRecitationGuideSection({required this.screenWidth});

  bool get _isMobile => screenWidth < GitaLayout.mobileBreakpoint;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      child: Center(
        child: ConstrainedBox(
          constraints:
              const BoxConstraints(maxWidth: GitaLayout.maxContentWidth + 96),
          child: Padding(
            padding: GitaLayout.responsivePadding(screenWidth).copyWith(
              top: 56,
              bottom: 56,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _SectionTitle(
                  title: 'The 18 Chapters Recitation Guide',
                  subtitle:
                      'Sri Ghantasala’s 73-minute composition encapsulates the universal wisdom of the Bhagavad Gita across all 18 yogas.',
                  isMobile: _isMobile,
                ),
                const SizedBox(height: 28),

                // Table / Grid of Chapters
                Container(
                  decoration: BoxDecoration(
                    color: GitaColors.warmWhite,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFFE2D6C8), width: 1),
                  ),
                  child: Column(
                    children: [
                      for (int i = 0; i < _chapters.length; i++) ...[
                        if (i > 0)
                          Container(
                            height: 1,
                            color: const Color(0xFFEBE3D8),
                          ),
                        _buildChapterRow(_chapters[i], i + 1, _isMobile),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildChapterRow(_ChapterItem item, int number, bool isMobile) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 24,
        vertical: 14,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32,
            height: 32,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: GitaColors.ivory,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: GitaColors.peach, width: 0.8),
            ),
            child: Text(
              '$number',
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: GitaColors.crimson,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            flex: isMobile ? 5 : 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: const TextStyle(
                    fontSize: 14.5,
                    fontWeight: FontWeight.w700,
                    color: GitaColors.textDark,
                  ),
                ),
                Text(
                  item.teluguName,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: GitaColors.textLight.withValues(alpha: 0.9),
                  ),
                ),
              ],
            ),
          ),
          if (!isMobile) ...[
            const SizedBox(width: 16),
            Expanded(
              flex: 6,
              child: Text(
                item.theme,
                style: const TextStyle(
                  fontSize: 13.5,
                  color: GitaColors.textMedium,
                  height: 1.4,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  static const List<_ChapterItem> _chapters = [
    _ChapterItem('Arjuna Vishada Yoga', 'అర్జున విషాద యోగము', 'The crisis of conscience and despondency of Arjuna on the Kurukshetra battlefield.'),
    _ChapterItem('Sankhya Yoga', 'సాంఖ్య యోగము', 'The eternal nature of the soul (Atman), moral duty, and equanimity in action.'),
    _ChapterItem('Karma Yoga', 'కర్మ యోగము', 'The path of selfless dedicated action performed without anxiety for results.'),
    _ChapterItem('Jnana Karma Sannyasa Yoga', 'జ్ఞాన కర్మ సన్యాస యోగము', 'The descending wisdom of divine avatars and the purifying flame of knowledge.'),
    _ChapterItem('Karma Sannyasa Yoga', 'కర్మ సన్యాస యోగము', 'Harmonizing active external duty with serene inner detachment.'),
    _ChapterItem('Dhyana Yoga', 'ధ్యాన యోగము', 'The discipline of steady meditation, physical posture, and tranquil mental mastery.'),
    _ChapterItem('Jnana Vijnana Yoga', 'జ్ఞాన విజ్ఞాన యోగము', 'Comprehension of the divine reality underlying both spiritual and material energies.'),
    _ChapterItem('Akshara Brahma Yoga', 'అక్షర పరబ్రహ్మ యోగము', 'The spiritual transition at life’s departure and constant remembrance of the Supreme.'),
    _ChapterItem('Raja Vidya Raja Guhya Yoga', 'రాజవిద్యా రాజగుహ్య యోగము', 'The sovereign science of unconditional devotion and personal divine grace.'),
    _ChapterItem('Vibhuti Yoga', 'విభూతి యోగము', 'The manifold divine splendors and manifestations across the created cosmos.'),
    _ChapterItem('Vishwarupa Sandarshana Yoga', 'విశ్వరూప సందర్శన యోగము', 'The majestic revelation of the universal cosmic form to Arjuna.'),
    _ChapterItem('Bhakti Yoga', 'భక్తి యోగము', 'The noble path of pure loving devotion and the attributes of an ideal seeker.'),
    _ChapterItem('Kshetra Kshetrajna Vibhaga Yoga', 'క్షేత్ర క్షేత్రజ్ఞ విభాగ యోగము', 'Discriminating between the mortal body (the field) and the immortal soul (the knower).'),
    _ChapterItem('Gunatraya Vibhaga Yoga', 'గుణత్రయ విభాగ యోగము', 'The mechanics of the three cosmic modes: Sattva (purity), Rajas (passion), and Tamas (inertia).'),
    _ChapterItem('Purushottama Yoga', 'పురుషోత్తమ యోగము', 'The eternal cosmic Tree of Life and the transcendence of the Supreme Person.'),
    _ChapterItem('Daivasura Sampad Vibhaga Yoga', 'దైవాసుర సంపద్విభాగ యోగము', 'Contrasting luminous virtues of the divine with the destructive qualities of ego.'),
    _ChapterItem('Shraddhatraya Vibhaga Yoga', 'శ్రద్ధాత్రయ విభాగ యోగము', 'The threefold division of faith, worship, dietary preferences, and charitable deeds.'),
    _ChapterItem('Moksha Sannyasa Yoga', 'మోక్ష సన్యాస యోగము', 'The culmination of spiritual freedom, total surrender (Saranagati), and radiant victory.'),
  ];
}

class _ChapterItem {
  final String name;
  final String teluguName;
  final String theme;

  const _ChapterItem(this.name, this.teluguName, this.theme);
}

// ===========================================================================
// 5. Technical Specifications & Integrity Audit
// ===========================================================================

class _TechSpecsSection extends StatelessWidget {
  final double screenWidth;

  const _TechSpecsSection({required this.screenWidth});

  bool get _isMobile => screenWidth < GitaLayout.mobileBreakpoint;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: GitaColors.warmWhite,
      child: Center(
        child: ConstrainedBox(
          constraints:
              const BoxConstraints(maxWidth: GitaLayout.maxContentWidth + 96),
          child: Padding(
            padding: GitaLayout.responsivePadding(screenWidth).copyWith(
              top: 56,
              bottom: 56,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _SectionTitle(
                  title: 'Technical Specifications & Privacy Guarantee',
                  subtitle:
                      'A transparent breakdown of media encoding, runtime architecture, security policies, and device permissions.',
                  isMobile: _isMobile,
                ),
                const SizedBox(height: 28),

                // Specs Table Card
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFFE2D6C8), width: 1),
                  ),
                  child: Column(
                    children: [
                      _buildSpecRow('Audio Codec & Format', 'Advanced Audio Coding (AAC-LC) in MPEG-4 (.m4a) Container', _isMobile),
                      _buildSpecRow('Sample Rate & Channels', '44.1 kHz, 16-Bit Stereo Audio Decoding', _isMobile),
                      _buildSpecRow('Total Bundled Asset Size', '27.0 MB (Integrated in assets/audio.m4a)', _isMobile),
                      _buildSpecRow('Exact Runtime Duration', '1 Hour, 13 Minutes, 40 Seconds (4,420 Seconds)', _isMobile),
                      _buildSpecRow('Android Architecture', 'Cross-ABI Split & Universal APKs (arm64-v8a, armeabi-v7a, x86_64)', _isMobile),
                      _buildSpecRow('Minimum Android Version', 'Android 5.0 (API Level 21 - Lollipop) through Android 15', _isMobile),
                      _buildSpecRow('Audio Services Engine', 'just_audio, just_audio_background & audio_session', _isMobile),
                      _buildSpecRow('Network Usage in Playback', 'Zero bytes (Android version operates 100% offline)', _isMobile),
                      _buildSpecRow('User Privacy Policy', 'No user accounts, zero analytics trackers, zero telemetry SDKs', _isMobile, isLast: true),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSpecRow(String label, String value, bool isMobile, {bool isLast = false}) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 18 : 24,
            vertical: 14,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: isMobile ? 5 : 4,
                child: Text(
                  label,
                  style: const TextStyle(
                    fontSize: 13.5,
                    fontWeight: FontWeight.w700,
                    color: GitaColors.textDark,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                flex: isMobile ? 7 : 6,
                child: Text(
                  value,
                  style: const TextStyle(
                    fontSize: 13.5,
                    color: GitaColors.textMedium,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        ),
        if (!isLast)
          Container(
            height: 1,
            color: const Color(0xFFF0EAE1),
          ),
      ],
    );
  }
}

// ===========================================================================
// 6. Step-by-Step Android Sideloading & Installation Guide
// ===========================================================================

class _InstallationGuideSection extends StatelessWidget {
  final double screenWidth;
  final String androidReleaseUrl;

  const _InstallationGuideSection({
    required this.screenWidth,
    required this.androidReleaseUrl,
  });

  bool get _isMobile => screenWidth < GitaLayout.mobileBreakpoint;
  bool get _isTablet => screenWidth < GitaLayout.tabletBreakpoint;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      child: Center(
        child: ConstrainedBox(
          constraints:
              const BoxConstraints(maxWidth: GitaLayout.maxContentWidth + 96),
          child: Padding(
            padding: GitaLayout.responsivePadding(screenWidth).copyWith(
              top: 56,
              bottom: 56,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _SectionTitle(
                  title: 'How to Install the Android APK',
                  subtitle:
                      'Sideload the standalone release directly onto any modern Android smartphone or tablet in four simple steps.',
                  isMobile: _isMobile,
                ),
                const SizedBox(height: 32),

                // 4 Steps Cards
                if (_isMobile)
                  Column(
                    children: _steps
                        .map((s) => Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: _StepCard(step: s),
                            ))
                        .toList(),
                  )
                else
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (int i = 0; i < _steps.length; i++) ...[
                        if (i > 0) const SizedBox(width: 16),
                        Expanded(child: _StepCard(step: _steps[i])),
                      ],
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static const List<_StepItem> _steps = [
    _StepItem(
      number: '1',
      title: 'Download APK',
      description:
          'Tap the Download APK button to obtain the signed release binary (app-release.apk) from the official GitHub release page.',
    ),
    _StepItem(
      number: '2',
      title: 'Open Download',
      description:
          'Once downloaded, tap the file in your browser downloads list or navigate to your device’s Downloads folder.',
    ),
    _StepItem(
      number: '3',
      title: 'Authorize Installer',
      description:
          'If prompted by Android security, toggle "Allow from this source" to grant package installation permission to your browser or file manager.',
    ),
    _StepItem(
      number: '4',
      title: 'Launch & Enjoy',
      description:
          'Tap Install. Open the app to enjoy uninterrupted, fully offline Bhagavad Gita listening with lock-screen media controls.',
    ),
  ];
}

class _StepItem {
  final String number;
  final String title;
  final String description;

  const _StepItem({
    required this.number,
    required this.title,
    required this.description,
  });
}

class _StepCard extends StatelessWidget {
  final _StepItem step;

  const _StepCard({required this.step});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: GitaColors.warmWhite,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5DDD3), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36,
            height: 36,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: GitaColors.crimson,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              step.number,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 14),
          Text(
            step.title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: GitaColors.textDark,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            step.description,
            style: const TextStyle(
              fontSize: 13,
              color: GitaColors.textMedium,
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// 7. Frequently Asked Questions (FAQ)
// ===========================================================================

class _FaqSection extends StatelessWidget {
  final double screenWidth;

  const _FaqSection({required this.screenWidth});

  bool get _isMobile => screenWidth < GitaLayout.mobileBreakpoint;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: GitaColors.warmWhite,
      child: Center(
        child: ConstrainedBox(
          constraints:
              const BoxConstraints(maxWidth: GitaLayout.maxContentWidth + 96),
          child: Padding(
            padding: GitaLayout.responsivePadding(screenWidth).copyWith(
              top: 56,
              bottom: 56,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _SectionTitle(
                  title: 'Frequently Asked Questions',
                  subtitle:
                      'Common questions regarding playback, audio provenance, offline usage, and device compatibility.',
                  isMobile: _isMobile,
                ),
                const SizedBox(height: 28),

                // FAQ Accordions/Cards
                for (final faq in _faqs)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 14),
                    child: _FaqCard(faq: faq),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static const List<_FaqItem> _faqs = [
    _FaqItem(
      question: 'Why does the Android APK include the entire audio file (~27 MB)?',
      answer:
          'Unlike streaming services that drop out when you enter temples, remote areas, or flights, bundling the complete 73-minute audio asset inside the app guarantees 100% offline playback with zero network connectivity requirements forever.',
    ),
    _FaqItem(
      question: 'Will playback continue if I lock my Android phone screen?',
      answer:
          'Yes. The Android application implements a dedicated foreground service powered by just_audio_background. It displays a system media notification drawer and lock-screen media controls showing playback state, elapsed time, and album artwork.',
    ),
    _FaqItem(
      question: 'Does the web player work on iOS (iPhone & iPad)?',
      answer:
          'Yes. The web version is fully responsive and operates in Safari, Chrome, Edge, and Firefox on iOS, iPadOS, macOS, Windows, and Linux. No app installation is required to stream in browser.',
    ),
    _FaqItem(
      question: 'Why does audio pause when I unplug my headphones?',
      answer:
          'The app conforms to Android’s "Becoming Noisy" audio focus specification. When wired headphones or Bluetooth devices disconnect, playback pauses immediately to respect your surroundings.',
    ),
    _FaqItem(
      question: 'Are there any commercials, ads, or user registrations?',
      answer:
          'None. This application is created strictly for devotional and cultural contemplation. It contains zero advertisements, zero in-app purchases, no user accounts, and zero telemetry analytics.',
    ),
  ];
}

class _FaqItem {
  final String question;
  final String answer;

  const _FaqItem({required this.question, required this.answer});
}

class _FaqCard extends StatefulWidget {
  final _FaqItem faq;

  const _FaqCard({required this.faq});

  @override
  State<_FaqCard> createState() => _FaqCardState();
}

class _FaqCardState extends State<_FaqCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: _isExpanded ? GitaColors.peach : const Color(0xFFE6DED4),
          width: 1,
        ),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          onExpansionChanged: (val) => setState(() => _isExpanded = val),
          tilePadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
          title: Text(
            widget.faq.question,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: GitaColors.textDark,
            ),
          ),
          iconColor: GitaColors.crimson,
          collapsedIconColor: GitaColors.textLight,
          childrenPadding:
              const EdgeInsets.only(left: 20, right: 20, bottom: 18),
          children: [
            Text(
              widget.faq.answer,
              style: const TextStyle(
                fontSize: 13.5,
                color: GitaColors.textMedium,
                height: 1.55,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ===========================================================================
// 8. Bottom CTA Banner
// ===========================================================================

class _BottomCtaBanner extends StatelessWidget {
  final double screenWidth;
  final VoidCallback onOpenPlayer;
  final String androidReleaseUrl;

  const _BottomCtaBanner({
    required this.screenWidth,
    required this.onOpenPlayer,
    required this.androidReleaseUrl,
  });

  bool get _isMobile => screenWidth < GitaLayout.mobileBreakpoint;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      child: Center(
        child: ConstrainedBox(
          constraints:
              const BoxConstraints(maxWidth: GitaLayout.maxContentWidth + 96),
          child: Padding(
            padding: GitaLayout.responsivePadding(screenWidth).copyWith(
              top: 36,
              bottom: 36,
            ),
            child: Container(
              padding: EdgeInsets.all(_isMobile ? 24 : 36),
              decoration: BoxDecoration(
                color: GitaColors.darkBg,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.12),
                    blurRadius: 28,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: _isMobile ? _buildMobile() : _buildDesktop(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDesktop() {
    return Row(
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: GitaColors.gold.withValues(alpha: 0.3),
              width: 1,
            ),
          ),
          child: const Icon(
            Icons.menu_book_rounded,
            size: 32,
            color: GitaColors.gold,
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Experience the Sacred Rendition',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: GitaColors.textOnDark,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Stream immediately in your browser or install the native Android package for zero-latency, offline listening anywhere.',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white.withValues(alpha: 0.72),
                  height: 1.45,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 24),
        Wrap(
          spacing: 12,
          runSpacing: 10,
          children: [
            ElevatedButton(
              onPressed: onOpenPlayer,
              style: ElevatedButton.styleFrom(
                backgroundColor: GitaColors.red,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22),
                ),
                elevation: 0,
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.play_arrow_rounded, size: 20),
                  SizedBox(width: 6),
                  Text('Launch Player', style: TextStyle(fontWeight: FontWeight.w700)),
                ],
              ),
            ),
            OutlinedButton(
              onPressed: () => launchUrlSafely(androidReleaseUrl),
              style: OutlinedButton.styleFrom(
                foregroundColor: GitaColors.gold,
                side: const BorderSide(color: GitaColors.gold, width: 1.2),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22),
                ),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.download_rounded, size: 18),
                  SizedBox(width: 6),
                  Text('Download APK', style: TextStyle(fontWeight: FontWeight.w700)),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMobile() {
    return Column(
      children: [
        const Icon(Icons.menu_book_rounded, size: 36, color: GitaColors.gold),
        const SizedBox(height: 12),
        const Text(
          'Experience the Sacred Rendition',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: GitaColors.textOnDark,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          'Stream immediately in browser or install native offline Android APK.',
          style: TextStyle(
            fontSize: 13.5,
            color: Colors.white.withValues(alpha: 0.72),
            height: 1.45,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 12,
          runSpacing: 10,
          children: [
            ElevatedButton(
              onPressed: onOpenPlayer,
              style: ElevatedButton.styleFrom(
                backgroundColor: GitaColors.red,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.play_arrow_rounded, size: 18),
                  SizedBox(width: 6),
                  Text('Launch Player', style: TextStyle(fontWeight: FontWeight.w700)),
                ],
              ),
            ),
            OutlinedButton(
              onPressed: () => launchUrlSafely(androidReleaseUrl),
              style: OutlinedButton.styleFrom(
                foregroundColor: GitaColors.gold,
                side: const BorderSide(color: GitaColors.gold, width: 1.2),
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.download_rounded, size: 18),
                  SizedBox(width: 6),
                  Text('Download APK', style: TextStyle(fontWeight: FontWeight.w700)),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// ===========================================================================
// Reusable Shared Widgets: SectionTitle, PrimaryButton, SecondaryButton
// ===========================================================================

class _SectionTitle extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool isMobile;

  const _SectionTitle({
    required this.title,
    required this.subtitle,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 4,
              height: isMobile ? 22 : 26,
              decoration: BoxDecoration(
                color: GitaColors.crimson,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: GitaTextStyles.sectionHeading.copyWith(
                  fontSize: isMobile ? 22 : 28,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          subtitle,
          style: GitaTextStyles.sectionSubheading.copyWith(
            fontSize: isMobile ? 14 : 16,
          ),
        ),
      ],
    );
  }
}

class _PrimaryButton extends StatefulWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;
  final bool isMobile;

  const _PrimaryButton({
    required this.label,
    required this.icon,
    required this.onTap,
    required this.isMobile,
  });

  @override
  State<_PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<_PrimaryButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: EdgeInsets.symmetric(
            horizontal: widget.isMobile ? 22 : 28,
            vertical: widget.isMobile ? 13 : 15,
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: _isHovered
                  ? [GitaColors.crimson, const Color(0xFFC62828)]
                  : [GitaColors.red, GitaColors.crimson],
            ),
            borderRadius: BorderRadius.circular(28),
            boxShadow: [
              BoxShadow(
                color: GitaColors.red.withValues(alpha: _isHovered ? 0.38 : 0.22),
                blurRadius: _isHovered ? 18 : 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(widget.icon, color: Colors.white, size: 22),
              const SizedBox(width: 8),
              Text(
                widget.label,
                style: GitaTextStyles.buttonLabel.copyWith(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SecondaryButton extends StatefulWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;
  final bool isMobile;

  const _SecondaryButton({
    required this.label,
    required this.icon,
    required this.onTap,
    required this.isMobile,
  });

  @override
  State<_SecondaryButton> createState() => _SecondaryButtonState();
}

class _SecondaryButtonState extends State<_SecondaryButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: EdgeInsets.symmetric(
            horizontal: widget.isMobile ? 20 : 26,
            vertical: widget.isMobile ? 12 : 14,
          ),
          decoration: BoxDecoration(
            color: _isHovered ? Colors.white : GitaColors.ivory,
            borderRadius: BorderRadius.circular(28),
            border: Border.all(
              color: _isHovered ? GitaColors.crimson : GitaColors.peach,
              width: 1.4,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.03),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                widget.icon,
                color: _isHovered ? GitaColors.crimson : GitaColors.textDark,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                widget.label,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: _isHovered ? GitaColors.crimson : GitaColors.textDark,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
