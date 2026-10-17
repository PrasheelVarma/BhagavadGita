import 'package:flutter/material.dart';

import '../theme.dart';
import '../utils/url_launcher_helper.dart';

/// Editorial, artwork-led Home page for the Bhagavad Gita audio player.
/// Structures the experience into three purposeful sections:
/// 1. Luminous Hero with framed artwork and clear listening actions.
/// 2. Detailed, balanced comparison of the Web Player vs Android App.
/// 3. Three core listening features (scrubbers, sleep timer, ad-free focus).
class HomePage extends StatelessWidget {
  final VoidCallback onOpenPlayer;

  const HomePage({super.key, required this.onOpenPlayer});

  static const String _androidReleaseUrl =
      'https://github.com/PrasheelVarma/BhagavadGita/releases/tag/v1.0-android';

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // 1. Editorial, artwork-led hero
        _HeroSection(
          screenWidth: screenWidth,
          onOpenPlayer: onOpenPlayer,
          androidReleaseUrl: _androidReleaseUrl,
        ),

        // 2. How to listen: Web Player vs Android App
        _ListeningOptionsSection(
          screenWidth: screenWidth,
          onOpenPlayer: onOpenPlayer,
          androidReleaseUrl: _androidReleaseUrl,
        ),

        // 3. Three meaningful listening features
        _ListeningFeaturesSection(screenWidth: screenWidth),

        const SizedBox(height: 56),
      ],
    );
  }
}

// ===========================================================================
// 1. Editorial, Artwork-Led Hero Section
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
            GitaColors.linen,
          ],
          stops: [0.0, 0.6, 1.0],
        ),
        border: Border(
          bottom: BorderSide(
            color: GitaColors.surfaceBorder,
            width: 1,
          ),
        ),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: GitaLayout.maxContentWidth),
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
          child: _buildArtworkFrame(),
        ),
      ],
    );
  }

  Widget _buildNarrowLayout() {
    return Column(
      children: [
        _buildArtworkFrame(),
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
        // Descriptive Eyebrow
        Text(
          'TELUGU DEVOTIONAL RECITATION • ~73 MINUTES',
          style: GitaTextStyles.eyebrow,
          textAlign: centered ? TextAlign.center : TextAlign.left,
        ),
        const SizedBox(height: 12),

        // Headline
        Text(
          'Bhagavad Gita',
          style: GitaTextStyles.heroHeadline.copyWith(
            fontSize: _isMobile ? 36 : 48,
          ),
          textAlign: centered ? TextAlign.center : TextAlign.left,
        ),
        const SizedBox(height: 8),

        // Subtitle Attribution
        Text(
          'Recitation & Commentary by Sri Ghantasala Venkateswara Rao',
          style: TextStyle(
            fontSize: _isMobile ? 15.5 : 18,
            fontWeight: FontWeight.w600,
            color: GitaColors.textLight,
            letterSpacing: 0.1,
          ),
          textAlign: centered ? TextAlign.center : TextAlign.left,
        ),
        const SizedBox(height: 18),

        // Description
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 580),
          child: Text(
            'A dedicated audio player for the revered Telugu Bhagavad Gita rendition. Designed for calm, contemplation-focused listening with no advertisements, user accounts, or algorithmic feeds.',
            style: GitaTextStyles.bodyText.copyWith(
              fontSize: _isMobile ? 15 : 16.5,
              height: 1.6,
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
            _HeroPrimaryButton(
              label: 'Open Web Player',
              icon: Icons.play_arrow_rounded,
              onTap: onOpenPlayer,
              isMobile: _isMobile,
            ),
            _HeroSecondaryButton(
              label: 'Download Android APK',
              icon: Icons.android_rounded,
              onTap: () => launchUrlSafely(androidReleaseUrl),
              isMobile: _isMobile,
            ),
          ],
        ),
        const SizedBox(height: 18),

        // Contextual Sub-text
        Text(
          'Instant in-browser streaming on all devices • 100% offline playback on Android',
          style: TextStyle(
            fontSize: _isMobile ? 12.5 : 13.5,
            color: GitaColors.textLight,
            fontWeight: FontWeight.w500,
          ),
          textAlign: centered ? TextAlign.center : TextAlign.left,
        ),
      ],
    );
  }

  Widget _buildArtworkFrame() {
    final artSize = _isMobile ? 220.0 : (_isWide ? 300.0 : 260.0);

    return Center(
      child: SizedBox(
        width: artSize,
        height: artSize,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Layered warm ambient lighting behind the artwork
            Container(
              width: artSize * 0.94,
              height: artSize * 0.94,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: GitaColors.amber.withValues(alpha: 0.20),
                    blurRadius: 42,
                    spreadRadius: 4,
                  ),
                  BoxShadow(
                    color: GitaColors.crimson.withValues(alpha: 0.12),
                    blurRadius: 56,
                    spreadRadius: 2,
                  ),
                ],
              ),
            ),
            // Clean circular artwork with subtle elevation shadow
            Container(
              width: artSize * 0.88,
              height: artSize * 0.88,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.15),
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

// ===========================================================================
// 2. How to Listen: Web Player vs Android App
// ===========================================================================

class _ListeningOptionsSection extends StatelessWidget {
  final double screenWidth;
  final VoidCallback onOpenPlayer;
  final String androidReleaseUrl;

  const _ListeningOptionsSection({
    required this.screenWidth,
    required this.onOpenPlayer,
    required this.androidReleaseUrl,
  });

  bool get _isMobile => screenWidth < GitaLayout.mobileBreakpoint;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: GitaColors.linen,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: GitaLayout.maxContentWidth),
          child: Padding(
            padding: GitaLayout.responsivePadding(screenWidth).copyWith(
              top: 56,
              bottom: 56,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _SectionTitleBlock(
                  eyebrow: 'WAYS TO LISTEN',
                  title: 'Web Player vs. Android App',
                  subtitle:
                      'Choose the Web Player for instant in-browser listening without installation, or download the native Android APK for completely offline listening with lock-screen and background playback.',
                  isMobile: _isMobile,
                ),
                const SizedBox(height: 32),

                // Side-by-side or stacked comparative cards
                if (_isMobile)
                  Column(
                    children: [
                      _buildWebCard(),
                      const SizedBox(height: 24),
                      _buildAndroidCard(),
                    ],
                  )
                else
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: _buildWebCard()),
                      const SizedBox(width: 28),
                      Expanded(child: _buildAndroidCard()),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWebCard() {
    return _ComparativeCard(
      badge: 'Zero Installation',
      badgeColor: GitaColors.crimson,
      badgeBgColor: GitaColors.ivory,
      icon: Icons.language_rounded,
      iconColor: GitaColors.crimson,
      title: 'Web Player Experience',
      subtitle: 'Stream instantly in any modern browser without downloading anything.',
      points: const [
        'Runs directly in Chrome, Safari, Firefox, Edge, and mobile browsers.',
        'Audio continues playing uninterrupted across all website page navigation.',
        'Interactive circular dial scrubber and synchronized linear timeline.',
        'Configurable sleep timer presets and adjustable playback rates.',
        'No account creation, sign-in, or software download required.',
      ],
      actionLabel: 'Launch Web Player',
      onAction: onOpenPlayer,
    );
  }

  Widget _buildAndroidCard() {
    return _ComparativeCard(
      badge: '100% Offline',
      badgeColor: const Color(0xFF2E7D32),
      badgeBgColor: const Color(0xFFE8F5E9),
      icon: Icons.android_rounded,
      iconColor: const Color(0xFF2E7D32),
      title: 'Android Native Experience',
      subtitle: 'Self-contained standalone playback with full system media integration.',
      points: const [
        'Audio is bundled inside the APK (~27 MB)—plays completely offline.',
        'Runs in the background when the app is minimized or other apps are in use.',
        'Android system notification drawer with playback and seek controls.',
        'Lock-screen media session controls displaying album artwork.',
        'Manages system audio focus: pauses automatically when headphones disconnect.',
      ],
      actionLabel: 'Download Android APK (v1.0)',
      onAction: () => launchUrlSafely(androidReleaseUrl),
    );
  }
}

class _ComparativeCard extends StatelessWidget {
  final String badge;
  final Color badgeColor;
  final Color badgeBgColor;
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final List<String> points;
  final String actionLabel;
  final VoidCallback onAction;

  const _ComparativeCard({
    required this.badge,
    required this.badgeColor,
    required this.badgeBgColor,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.points,
    required this.actionLabel,
    required this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: GitaColors.surfaceBorder, width: 1.2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 18,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row: Icon + Badge
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: GitaColors.ivory,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: GitaColors.peach, width: 0.8),
                ),
                child: Icon(icon, color: iconColor, size: 22),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: badgeBgColor,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: badgeColor.withValues(alpha: 0.3),
                    width: 1,
                  ),
                ),
                child: Text(
                  badge,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: badgeColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),

          // Title & Subtitle
          Text(
            title,
            style: const TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.w700,
              color: GitaColors.textDark,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 13.5,
              color: GitaColors.textLight,
              height: 1.45,
            ),
          ),
          const SizedBox(height: 18),

          // Divider
          Container(
            height: 1,
            color: GitaColors.borderLight,
          ),
          const SizedBox(height: 18),

          // Bullet Points
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
                      color: iconColor,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      point,
                      style: const TextStyle(
                        fontSize: 14,
                        color: GitaColors.textMedium,
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          const SizedBox(height: 12),

          // Action Link
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: onAction,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    actionLabel,
                    style: TextStyle(
                      fontSize: 14.5,
                      fontWeight: FontWeight.w700,
                      color: iconColor,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Icon(
                    Icons.arrow_forward_rounded,
                    size: 16,
                    color: iconColor,
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

// ===========================================================================
// 3. Three Meaningful Listening Features
// ===========================================================================

class _ListeningFeaturesSection extends StatelessWidget {
  final double screenWidth;

  const _ListeningFeaturesSection({required this.screenWidth});

  bool get _isMobile => screenWidth < GitaLayout.mobileBreakpoint;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: GitaColors.warmWhite,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: GitaLayout.maxContentWidth),
          child: Padding(
            padding: GitaLayout.responsivePadding(screenWidth).copyWith(
              top: 56,
              bottom: 56,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _SectionTitleBlock(
                  eyebrow: 'PURPOSE-BUILT PLAYER',
                  title: 'Meaningful Listening Features',
                  subtitle:
                      'Designed from first principles to provide thoughtful, serene playback without algorithmic distraction.',
                  isMobile: _isMobile,
                ),
                const SizedBox(height: 32),

                // 3 Curated Feature Cards
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
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (int i = 0; i < _features.length; i++) ...[
                        if (i > 0) const SizedBox(width: 20),
                        Expanded(child: _FeatureCard(feature: _features[i])),
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

  static const List<_FeatureItem> _features = [
    _FeatureItem(
      icon: Icons.album_outlined,
      title: 'Dual Seeking Controls',
      description:
          'Seek naturally with an interactive circular dial scrubber surrounding the artwork, paired with a linear timeline slider for precise position control.',
    ),
    _FeatureItem(
      icon: Icons.bedtime_outlined,
      title: 'Sleep Timer & Playback Speed',
      description:
          'Set a 15, 30, 45, or 60-minute sleep timer with real-time countdown feedback, or adjust playback tempo (0.75x to 2.0x) for study and quiet contemplation.',
    ),
    _FeatureItem(
      icon: Icons.spa_outlined,
      title: 'Distraction-Free Devotion',
      description:
          'Dedicated strictly to listening. No commercial advertisements, no sign-in or account registration required, keeping your focus on the sacred discourse.',
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
      padding: const EdgeInsets.all(26),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: GitaColors.surfaceBorder, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.025),
            blurRadius: 14,
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
              size: 22,
              color: GitaColors.crimson,
            ),
          ),
          const SizedBox(height: 18),
          Text(
            feature.title,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: GitaColors.textDark,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            feature.description,
            style: const TextStyle(
              fontSize: 14,
              color: GitaColors.textMedium,
              height: 1.55,
            ),
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// Reusable Shared Widgets: SectionTitleBlock, Hero Buttons
// ===========================================================================

class _SectionTitleBlock extends StatelessWidget {
  final String eyebrow;
  final String title;
  final String subtitle;
  final bool isMobile;

  const _SectionTitleBlock({
    required this.eyebrow,
    required this.title,
    required this.subtitle,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          eyebrow,
          style: GitaTextStyles.eyebrow,
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Container(
              width: 3.5,
              height: isMobile ? 22 : 26,
              decoration: BoxDecoration(
                color: GitaColors.crimson,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                title,
                style: GitaTextStyles.sectionHeading.copyWith(
                  fontSize: isMobile ? 22 : 26,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 680),
          child: Text(
            subtitle,
            style: TextStyle(
              fontSize: isMobile ? 14 : 15.5,
              color: GitaColors.textMedium,
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }
}

class _HeroPrimaryButton extends StatefulWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;
  final bool isMobile;

  const _HeroPrimaryButton({
    required this.label,
    required this.icon,
    required this.onTap,
    required this.isMobile,
  });

  @override
  State<_HeroPrimaryButton> createState() => _HeroPrimaryButtonState();
}

class _HeroPrimaryButtonState extends State<_HeroPrimaryButton> {
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
          duration: const Duration(milliseconds: 160),
          padding: EdgeInsets.symmetric(
            horizontal: widget.isMobile ? 22 : 26,
            vertical: widget.isMobile ? 13 : 15,
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: _isHovered
                  ? [GitaColors.crimson, const Color(0xFFC62828)]
                  : [GitaColors.red, GitaColors.crimson],
            ),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: GitaColors.red.withValues(alpha: _isHovered ? 0.35 : 0.20),
                blurRadius: _isHovered ? 14 : 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(widget.icon, color: Colors.white, size: 21),
              const SizedBox(width: 8),
              Text(
                widget.label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HeroSecondaryButton extends StatefulWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;
  final bool isMobile;

  const _HeroSecondaryButton({
    required this.label,
    required this.icon,
    required this.onTap,
    required this.isMobile,
  });

  @override
  State<_HeroSecondaryButton> createState() => _HeroSecondaryButtonState();
}

class _HeroSecondaryButtonState extends State<_HeroSecondaryButton> {
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
          duration: const Duration(milliseconds: 160),
          padding: EdgeInsets.symmetric(
            horizontal: widget.isMobile ? 20 : 24,
            vertical: widget.isMobile ? 12 : 14,
          ),
          decoration: BoxDecoration(
            color: _isHovered ? Colors.white : GitaColors.ivory,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: _isHovered ? GitaColors.crimson : GitaColors.surfaceBorder,
              width: 1.3,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.02),
                blurRadius: 6,
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
                  fontSize: 14.5,
                  fontWeight: FontWeight.w700,
                  color: _isHovered ? GitaColors.crimson : GitaColors.textDark,
                  letterSpacing: 0.2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
