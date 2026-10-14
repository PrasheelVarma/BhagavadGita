import 'package:flutter/material.dart';

import '../theme.dart';
import '../utils/url_launcher_helper.dart';

/// Website footer — clean, professional, and informative.
class WebsiteFooter extends StatelessWidget {
  final VoidCallback onNavigateHome;
  final VoidCallback onNavigatePlayer;
  final VoidCallback onNavigateAbout;
  final VoidCallback onNavigateContact;

  const WebsiteFooter({
    super.key,
    required this.onNavigateHome,
    required this.onNavigatePlayer,
    required this.onNavigateAbout,
    required this.onNavigateContact,
  });

  static const String _githubProfileUrl = 'https://github.com/PrasheelVarma';
  static const String _githubRepoUrl =
      'https://github.com/PrasheelVarma/BhagavadGita';
  static const String _androidReleaseUrl =
      'https://github.com/PrasheelVarma/BhagavadGita/releases/tag/v1.0-android';

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < GitaLayout.mobileBreakpoint;

    return Container(
      color: GitaColors.darkBg,
      child: Center(
        child: ConstrainedBox(
          constraints:
              const BoxConstraints(maxWidth: GitaLayout.maxContentWidth + 96),
          child: Padding(
            padding: GitaLayout.responsivePadding(screenWidth).copyWith(
              top: 48,
              bottom: 32,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (isMobile) _buildMobileLayout() else _buildDesktopLayout(),
                const SizedBox(height: 40),
                // Divider
                Container(
                  height: 1,
                  color: Colors.white.withValues(alpha: 0.1),
                ),
                const SizedBox(height: 24),
                // Bottom row
                _buildBottomRow(isMobile),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Brand & Audio info column
        Expanded(flex: 3, child: _buildBrandColumn()),
        const SizedBox(width: 48),
        // Navigation column
        Expanded(flex: 2, child: _buildNavColumn()),
        const SizedBox(width: 48),
        // Platform column
        Expanded(flex: 2, child: _buildPlatformColumn()),
        const SizedBox(width: 48),
        // Project column
        Expanded(flex: 3, child: _buildProjectColumn()),
      ],
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildBrandColumn(),
        const SizedBox(height: 32),
        Wrap(
          spacing: 32,
          runSpacing: 24,
          children: [
            SizedBox(width: 140, child: _buildNavColumn()),
            SizedBox(width: 160, child: _buildPlatformColumn()),
          ],
        ),
        const SizedBox(height: 32),
        _buildProjectColumn(),
      ],
    );
  }

  Widget _buildBrandColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    GitaColors.vermillion,
                    GitaColors.crimson,
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.25),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(3.5),
              child: Image.asset(
                'assets/img2.png',
                fit: BoxFit.contain,
                filterQuality: FilterQuality.medium,
              ),
            ),
            const SizedBox(width: 12),
            const Text(
              'Bhagavad Gita',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: GitaColors.textOnDark,
                letterSpacing: 0.3,
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        Text(
          'Revered Telugu rendition sung by Sri Ghantasala Venkateswara Rao.',
          style: TextStyle(
            fontSize: 14,
            color: Colors.white.withValues(alpha: 0.65),
            height: 1.5,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Designed as a distraction-free devotional listening experience across Web and Android.',
          style: TextStyle(
            fontSize: 13,
            color: Colors.white.withValues(alpha: 0.45),
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildNavColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _FooterHeading('Navigation'),
        const SizedBox(height: 14),
        _FooterLink(label: 'Home', onTap: onNavigateHome),
        const SizedBox(height: 10),
        _FooterLink(label: 'Player', onTap: onNavigatePlayer),
        const SizedBox(height: 10),
        _FooterLink(label: 'About', onTap: onNavigateAbout),
        const SizedBox(height: 10),
        _FooterLink(label: 'Contact', onTap: onNavigateContact),
      ],
    );
  }

  Widget _buildPlatformColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _FooterHeading('Availability'),
        const SizedBox(height: 14),
        _FooterLink(
          label: 'Web (Browser)',
          onTap: onNavigatePlayer,
        ),
        const SizedBox(height: 10),
        _FooterLink(
          label: 'Android v1.0 (APK)',
          onTap: () => launchUrlSafely(_androidReleaseUrl),
        ),
        const SizedBox(height: 10),
        Text(
          'Desktop & iOS (Planned)',
          style: TextStyle(
            fontSize: 13,
            color: Colors.white.withValues(alpha: 0.4),
          ),
        ),
      ],
    );
  }

  Widget _buildProjectColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _FooterHeading('Project & Developer'),
        const SizedBox(height: 14),
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () => launchUrlSafely(_githubProfileUrl),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.person_rounded,
                  size: 16,
                  color: GitaColors.gold.withValues(alpha: 0.85),
                ),
                const SizedBox(width: 8),
                Text(
                  'PrasheelVarma',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: GitaColors.gold.withValues(alpha: 0.9),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
        _FooterLink(
          label: 'GitHub Repository',
          onTap: () => launchUrlSafely(_githubRepoUrl),
        ),
        const SizedBox(height: 10),
        _FooterLink(
          label: 'Releases & Downloads',
          onTap: () => launchUrlSafely(_androidReleaseUrl),
        ),
      ],
    );
  }

  Widget _buildBottomRow(bool isMobile) {
    return Wrap(
      alignment: isMobile ? WrapAlignment.center : WrapAlignment.spaceBetween,
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 16,
      runSpacing: 8,
      children: [
        Text(
          '© ${DateTime.now().year} Bhagavad Gita Project',
          style: TextStyle(
            fontSize: 13,
            color: Colors.white.withValues(alpha: 0.4),
          ),
        ),
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () => launchUrlSafely(_githubProfileUrl),
            child: Text(
              'Developed by PrasheelVarma',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Colors.white.withValues(alpha: 0.6),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _FooterHeading extends StatelessWidget {
  final String text;
  const _FooterHeading(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w700,
        color: Colors.white.withValues(alpha: 0.45),
        letterSpacing: 1.2,
      ),
    );
  }
}

class _FooterLink extends StatefulWidget {
  final String label;
  final VoidCallback onTap;

  const _FooterLink({required this.label, required this.onTap});

  @override
  State<_FooterLink> createState() => _FooterLinkState();
}

class _FooterLinkState extends State<_FooterLink> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Text(
          widget.label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: _isHovered
                ? GitaColors.gold
                : Colors.white.withValues(alpha: 0.7),
          ),
        ),
      ),
    );
  }
}
