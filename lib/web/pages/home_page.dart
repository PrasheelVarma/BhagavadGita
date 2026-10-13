import 'package:flutter/material.dart';

import '../theme.dart';
import '../utils/url_launcher_helper.dart';

/// Home page — project introduction, platform availability, and direct player access.
class HomePage extends StatelessWidget {
  final VoidCallback onOpenPlayer;

  const HomePage({super.key, required this.onOpenPlayer});


  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _HeroSection(
          screenWidth: screenWidth,
          onOpenPlayer: onOpenPlayer,
        ),
        _PlatformAvailabilitySection(screenWidth: screenWidth),
        _FeaturesComparisonSection(
          screenWidth: screenWidth,
          onOpenPlayer: onOpenPlayer,
        ),
        _AndroidDownloadBanner(screenWidth: screenWidth),
        const SizedBox(height: 32),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Hero Section
// ---------------------------------------------------------------------------

class _HeroSection extends StatelessWidget {
  final double screenWidth;
  final VoidCallback onOpenPlayer;

  const _HeroSection({
    required this.screenWidth,
    required this.onOpenPlayer,
  });

  bool get _isWide => screenWidth > GitaLayout.tabletBreakpoint;
  bool get _isMobile => screenWidth < GitaLayout.mobileBreakpoint;

  static const String _androidReleaseUrl =
      'https://github.com/PrasheelVarma/BhagavadGita/releases/tag/v1.0-android';

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
          stops: [0.0, 0.6, 1.0],
        ),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints:
              const BoxConstraints(maxWidth: GitaLayout.maxContentWidth + 96),
          child: Padding(
            padding: GitaLayout.responsivePadding(screenWidth).copyWith(
              top: _isMobile ? 44 : 72,
              bottom: _isMobile ? 44 : 72,
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
        // Text content
        Expanded(
          flex: 6,
          child: _buildTextContent(),
        ),
        const SizedBox(width: 48),
        // Artwork
        Expanded(
          flex: 4,
          child: _buildArtwork(),
        ),
      ],
    );
  }

  Widget _buildNarrowLayout() {
    return Column(
      children: [
        _buildArtwork(),
        SizedBox(height: _isMobile ? 32 : 44),
        _buildTextContent(centered: true),
      ],
    );
  }

  Widget _buildTextContent({bool centered = false}) {
    return Column(
      crossAxisAlignment:
          centered ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        // Badge tag
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: GitaColors.peach, width: 1.2),
            borderRadius: BorderRadius.circular(20),
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
              Container(
                width: 7,
                height: 7,
                decoration: const BoxDecoration(
                  color: GitaColors.saffron,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                'Telugu Recitation • Sri Ghantasala',
                style: TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w600,
                  color: GitaColors.textDark,
                  letterSpacing: 0.3,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        // Main headline
        Text(
          'Bhagavad Gita',
          style: GitaTextStyles.heroHeadline.copyWith(
            fontSize: _isMobile ? 36 : 50,
          ),
          textAlign: centered ? TextAlign.center : TextAlign.left,
        ),
        const SizedBox(height: 14),
        // Subtitle
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 580),
          child: Text(
            'The revered Telugu Bhagavad Gita recording sung by Sri Ghantasala Venkateswara Rao. Dedicated, clean, and distraction-free audio listening available on Web and native Android.',
            style: GitaTextStyles.sectionSubheading.copyWith(
              fontSize: _isMobile ? 15.5 : 18,
            ),
            textAlign: centered ? TextAlign.center : TextAlign.left,
          ),
        ),
        const SizedBox(height: 32),
        // CTAs: Web Player + APK Download
        Wrap(
          alignment: centered ? WrapAlignment.center : WrapAlignment.start,
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 16,
          runSpacing: 14,
          children: [
            _PrimaryButton(
              label: 'Open Player',
              icon: Icons.play_arrow_rounded,
              onTap: onOpenPlayer,
              isMobile: _isMobile,
            ),
            _SecondaryButton(
              label: 'Download APK (v1.0)',
              icon: Icons.android_rounded,
              onTap: () => launchUrlSafely(_androidReleaseUrl),
              isMobile: _isMobile,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildArtwork() {
    final artSize = _isMobile ? 220.0 : (_isWide ? 310.0 : 260.0);

    return Center(
      child: SizedBox(
        width: artSize,
        height: artSize,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Ambient glow
            Container(
              width: artSize * 0.94,
              height: artSize * 0.94,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: GitaColors.amber.withValues(alpha: 0.22),
                    blurRadius: 44,
                    spreadRadius: 6,
                  ),
                  BoxShadow(
                    color: GitaColors.red.withValues(alpha: 0.12),
                    blurRadius: 60,
                    spreadRadius: 2,
                  ),
                ],
              ),
            ),
            // Circular frame
            Container(
              width: artSize * 0.88,
              height: artSize * 0.88,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: GitaColors.gold, width: 3),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.14),
                    blurRadius: 24,
                    offset: const Offset(0, 8),
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
    );
  }
}

// ---------------------------------------------------------------------------
// Platform Availability Section (Inspired by Spacedesk)
// ---------------------------------------------------------------------------

class _PlatformAvailabilitySection extends StatelessWidget {
  final double screenWidth;

  const _PlatformAvailabilitySection({required this.screenWidth});

  bool get _isMobile => screenWidth < GitaLayout.mobileBreakpoint;
  bool get _isTablet => screenWidth < GitaLayout.tabletBreakpoint;

  static const String _androidReleaseUrl =
      'https://github.com/PrasheelVarma/BhagavadGita/releases/tag/v1.0-android';

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: GitaColors.pureWhite,
      child: Center(
        child: ConstrainedBox(
          constraints:
              const BoxConstraints(maxWidth: GitaLayout.maxContentWidth + 96),
          child: Padding(
            padding: GitaLayout.responsivePadding(screenWidth).copyWith(
              top: 56,
              bottom: 48,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Section Title & Intro
                Row(
                  children: [
                    Container(
                      width: 4,
                      height: 24,
                      decoration: BoxDecoration(
                        color: GitaColors.red,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'Platform Availability',
                      style: GitaTextStyles.sectionHeading.copyWith(
                        fontSize: _isMobile ? 24 : 28,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'Current releases and platform compatibility status across web, mobile, and desktop.',
                  style: GitaTextStyles.sectionSubheading.copyWith(
                    fontSize: _isMobile ? 14.5 : 16,
                  ),
                ),
                const SizedBox(height: 28),

                // Platform Cards
                if (_isMobile)
                  Column(
                    children: _platforms
                        .map((p) => Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: _PlatformCard(platform: p),
                            ))
                        .toList(),
                  )
                else if (_isTablet)
                  Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    children: _platforms
                        .map((p) => SizedBox(
                              width: (screenWidth - 80) / 2,
                              child: _PlatformCard(platform: p),
                            ))
                        .toList(),
                  )
                else
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (int i = 0; i < _platforms.length; i++) ...[
                        if (i > 0) const SizedBox(width: 16),
                        Expanded(child: _PlatformCard(platform: _platforms[i])),
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

  static const List<_PlatformInfo> _platforms = [
    _PlatformInfo(
      icon: Icons.language_rounded,
      name: 'Web Application',
      version: 'Available Now',
      status: _AvailabilityStatus.available,
      badgeText: 'Active',
      description: 'Stream directly in any modern browser. Zero installation.',
      actionLabel: 'Open in Browser',
      actionRoute: '/player',
    ),
    _PlatformInfo(
      icon: Icons.android_rounded,
      name: 'Android App',
      version: 'v1.0 (APK)',
      status: _AvailabilityStatus.available,
      badgeText: 'Available',
      description: 'Fully offline after installation. Lock-screen controls.',
      actionLabel: 'Download APK',
      actionUrl: _androidReleaseUrl,
    ),
    _PlatformInfo(
      icon: Icons.desktop_windows_rounded,
      name: 'Windows Desktop',
      version: 'Cross-Platform',
      status: _AvailabilityStatus.planned,
      badgeText: 'Planned',
      description: 'Future native desktop package. Currently in roadmap.',
    ),
    _PlatformInfo(
      icon: Icons.terminal_rounded,
      name: 'Linux & macOS',
      version: 'Cross-Platform',
      status: _AvailabilityStatus.planned,
      badgeText: 'Planned',
      description: 'Native Linux & macOS bundles planned for later release.',
    ),
  ];
}

enum _AvailabilityStatus { available, planned }

class _PlatformInfo {
  final IconData icon;
  final String name;
  final String version;
  final _AvailabilityStatus status;
  final String badgeText;
  final String description;
  final String? actionLabel;
  final String? actionRoute;
  final String? actionUrl;

  const _PlatformInfo({
    required this.icon,
    required this.name,
    required this.version,
    required this.status,
    required this.badgeText,
    required this.description,
    this.actionLabel,
    this.actionRoute,
    this.actionUrl,
  });
}

class _PlatformCard extends StatelessWidget {
  final _PlatformInfo platform;

  const _PlatformCard({required this.platform});

  bool get _isAvailable => platform.status == _AvailabilityStatus.available;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _isAvailable ? Colors.white : const Color(0xFFFAF8F5),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: _isAvailable ? const Color(0xFFE2D6C8) : const Color(0xFFECE5DD),
          width: 1.2,
        ),
        boxShadow: _isAvailable
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
          // Top Row: Icon + Status Badge
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: _isAvailable
                      ? GitaColors.ivory
                      : Colors.grey.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  platform.icon,
                  color: _isAvailable ? GitaColors.crimson : GitaColors.statusPlanned,
                  size: 22,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: _isAvailable
                      ? GitaColors.statusActiveBg
                      : GitaColors.statusPlannedBg,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: _isAvailable
                        ? GitaColors.statusActive.withValues(alpha: 0.3)
                        : Colors.grey.withValues(alpha: 0.3),
                    width: 1,
                  ),
                ),
                child: Text(
                  platform.badgeText,
                  style: TextStyle(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w700,
                    color: _isAvailable
                        ? GitaColors.statusActive
                        : GitaColors.statusPlanned,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          // Platform Name
          Text(
            platform.name,
            style: TextStyle(
              fontSize: 16.5,
              fontWeight: FontWeight.w700,
              color: _isAvailable ? GitaColors.textDark : Colors.grey.shade700,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            platform.version,
            style: TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
              color: _isAvailable ? GitaColors.red : GitaColors.textLight,
            ),
          ),
          const SizedBox(height: 10),
          // Description
          Text(
            platform.description,
            style: TextStyle(
              fontSize: 13.5,
              color: _isAvailable
                  ? GitaColors.textMedium
                  : Colors.grey.shade600,
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Features & Comparison Section
// ---------------------------------------------------------------------------

class _FeaturesComparisonSection extends StatelessWidget {
  final double screenWidth;
  final VoidCallback onOpenPlayer;

  const _FeaturesComparisonSection({
    required this.screenWidth,
    required this.onOpenPlayer,
  });

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
                Text(
                  'Web Player vs Android Experience',
                  style: GitaTextStyles.sectionHeading.copyWith(
                    fontSize: _isMobile ? 24 : 28,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Both experiences share the same pure, distraction-free listening focus, tailored to their platform.',
                  style: GitaTextStyles.sectionSubheading.copyWith(
                    fontSize: _isMobile ? 14.5 : 16,
                  ),
                ),
                const SizedBox(height: 32),

                // Side-by-Side Cards
                if (_isMobile)
                  Column(
                    children: [
                      _buildComparisonCard(
                        title: 'Web Player Experience',
                        badge: 'Zero Installation',
                        icon: Icons.public_rounded,
                        accentColor: GitaColors.crimson,
                        points: const [
                          'Runs instantly in any modern desktop or mobile browser.',
                          'Responsive layout adapts to large monitors, tablets, and phones.',
                          'Custom circular seek dial and synchronized scrub bar.',
                          'Continuous audio playback across website pages.',
                          'No account, no sign-in, and zero analytics tracking.',
                        ],
                        actionText: 'Launch Web Player',
                        onAction: onOpenPlayer,
                      ),
                      const SizedBox(height: 24),
                      _buildComparisonCard(
                        title: 'Android Native Experience',
                        badge: '100% Offline',
                        icon: Icons.android_rounded,
                        accentColor: const Color(0xFF2E7D32),
                        points: const [
                          'Audio is fully bundled — works completely offline without internet.',
                          'Runs smoothly in the background while other apps are active.',
                          'System notification drawer with Play, Pause, and Seek controls.',
                          'Lock-screen media session controls with artwork display.',
                          'Handles audio focus automatically for phone calls and alarms.',
                        ],
                        actionText: 'View GitHub Release',
                        onAction: () => launchUrlSafely(
                          'https://github.com/PrasheelVarma/BhagavadGita/releases/tag/v1.0-android',
                        ),
                      ),
                    ],
                  )
                else
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: _buildComparisonCard(
                          title: 'Web Player Experience',
                          badge: 'Zero Installation',
                          icon: Icons.public_rounded,
                          accentColor: GitaColors.crimson,
                          points: const [
                            'Runs instantly in any modern desktop or mobile browser.',
                            'Responsive layout adapts to large monitors, tablets, and phones.',
                            'Custom circular seek dial and synchronized scrub bar.',
                            'Continuous audio playback across website pages.',
                            'No account, no sign-in, and zero analytics tracking.',
                          ],
                          actionText: 'Launch Web Player',
                          onAction: onOpenPlayer,
                        ),
                      ),
                      const SizedBox(width: 28),
                      Expanded(
                        child: _buildComparisonCard(
                          title: 'Android Native Experience',
                          badge: '100% Offline',
                          icon: Icons.android_rounded,
                          accentColor: const Color(0xFF2E7D32),
                          points: const [
                            'Audio is fully bundled — works completely offline without internet.',
                            'Runs smoothly in the background while other apps are active.',
                            'System notification drawer with Play, Pause, and Seek controls.',
                            'Lock-screen media session controls with artwork display.',
                            'Handles audio focus automatically for phone calls and alarms.',
                          ],
                          actionText: 'View GitHub Release',
                          onAction: () => launchUrlSafely(
                            'https://github.com/PrasheelVarma/BhagavadGita/releases/tag/v1.0-android',
                          ),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildComparisonCard({
    required String title,
    required String badge,
    required IconData icon,
    required Color accentColor,
    required List<String> points,
    required String actionText,
    required VoidCallback onAction,
  }) {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE5DDD3), width: 1.2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 18,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(icon, color: accentColor, size: 24),
                  const SizedBox(width: 10),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: GitaColors.textDark,
                    ),
                  ),
                ],
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: accentColor.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  badge,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: accentColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          for (final point in points)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 6, right: 10),
                    child: Icon(
                      Icons.check_circle_rounded,
                      size: 16,
                      color: accentColor,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      point,
                      style: const TextStyle(
                        fontSize: 14.5,
                        color: GitaColors.textMedium,
                        height: 1.45,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          const SizedBox(height: 12),
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: onAction,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    actionText,
                    style: TextStyle(
                      fontSize: 14.5,
                      fontWeight: FontWeight.w700,
                      color: accentColor,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Icon(
                    Icons.arrow_forward_rounded,
                    size: 16,
                    color: accentColor,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Android App Download Banner
// ---------------------------------------------------------------------------

class _AndroidDownloadBanner extends StatelessWidget {
  final double screenWidth;

  const _AndroidDownloadBanner({required this.screenWidth});

  bool get _isMobile => screenWidth < GitaLayout.mobileBreakpoint;

  static const String _androidReleaseUrl =
      'https://github.com/PrasheelVarma/BhagavadGita/releases/tag/v1.0-android';

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: GitaColors.pureWhite,
      child: Center(
        child: ConstrainedBox(
          constraints:
              const BoxConstraints(maxWidth: GitaLayout.maxContentWidth + 96),
          child: Padding(
            padding: GitaLayout.responsivePadding(screenWidth).copyWith(
              top: 36,
              bottom: 48,
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
              child: _isMobile
                  ? _buildMobileLayout()
                  : _buildDesktopLayout(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopLayout() {
    return Row(
      children: [
        // Android Icon
        Container(
          width: 68,
          height: 68,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: GitaColors.gold.withValues(alpha: 0.3),
              width: 1,
            ),
          ),
          child: const Icon(
            Icons.android_rounded,
            size: 36,
            color: GitaColors.gold,
          ),
        ),
        const SizedBox(width: 28),
        // Explanatory Text
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Get the Native Android App (v1.0)',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: GitaColors.textOnDark,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Works completely offline once installed. Enjoy uninterrupted playback with lock-screen media notification controls and zero battery overhead.',
                style: TextStyle(
                  fontSize: 14.5,
                  color: Colors.white.withValues(alpha: 0.7),
                  height: 1.45,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 28),
        // Action Button
        _DownloadButton(onTap: () => launchUrlSafely(_androidReleaseUrl)),
      ],
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: GitaColors.gold.withValues(alpha: 0.3),
              width: 1,
            ),
          ),
          child: const Icon(
            Icons.android_rounded,
            size: 30,
            color: GitaColors.gold,
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'Get the Native Android App (v1.0)',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: GitaColors.textOnDark,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          'Works completely offline after installation. Enjoy background playback and lock-screen controls.',
          style: TextStyle(
            fontSize: 14,
            color: Colors.white.withValues(alpha: 0.7),
            height: 1.45,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 22),
        _DownloadButton(onTap: () => launchUrlSafely(_androidReleaseUrl)),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Reusable Buttons with Hover Animation
// ---------------------------------------------------------------------------

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
            horizontal: widget.isMobile ? 24 : 30,
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
            horizontal: widget.isMobile ? 22 : 28,
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

class _DownloadButton extends StatefulWidget {
  final VoidCallback onTap;

  const _DownloadButton({required this.onTap});

  @override
  State<_DownloadButton> createState() => _DownloadButtonState();
}

class _DownloadButtonState extends State<_DownloadButton> {
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
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
          decoration: BoxDecoration(
            color: _isHovered ? GitaColors.gold : const Color(0xFFFFE082),
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: GitaColors.gold.withValues(alpha: _isHovered ? 0.4 : 0.2),
                blurRadius: 16,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.download_rounded,
                size: 20,
                color: GitaColors.darkBg,
              ),
              SizedBox(width: 8),
              Text(
                'Download APK v1.0',
                style: TextStyle(
                  fontSize: 14.5,
                  fontWeight: FontWeight.w800,
                  color: GitaColors.darkBg,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
