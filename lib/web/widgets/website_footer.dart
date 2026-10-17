import 'package:flutter/material.dart';

import '../theme.dart';
import '../utils/url_launcher_helper.dart';

/// Clean, dignified website footer.
/// Deep burgundy background with high-contrast warm typography,
/// distinct headings, and clear interactive link states.
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
  static const String _releasesUrl =
      'https://github.com/PrasheelVarma/BhagavadGita/releases';

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth >= 800;

    return Container(
      color: GitaColors.darkBg,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: GitaLayout.maxContentWidth),
          child: Padding(
            padding: GitaLayout.responsivePadding(screenWidth).copyWith(
              top: 44,
              bottom: 32,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (isDesktop)
                  _buildDesktopLayout()
                else
                  _buildMobileLayout(screenWidth),
                const SizedBox(height: 32),
                Container(
                  height: 1,
                  color: Colors.white.withValues(alpha: 0.1),
                ),
                const SizedBox(height: 20),
                _buildBottomRow(),
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
        // Brand & Cultural Attribution
        Expanded(flex: 5, child: _buildBrandColumn()),
        const SizedBox(width: 44),
        // Navigation links
        Expanded(flex: 2, child: _buildNavColumn()),
        const SizedBox(width: 28),
        // Availability
        Expanded(flex: 3, child: _buildAvailabilityColumn()),
        const SizedBox(width: 28),
        // Project & Developer
        Expanded(flex: 3, child: _buildProjectColumn()),
      ],
    );
  }

  Widget _buildMobileLayout(double screenWidth) {
    if (screenWidth < 520) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildBrandColumn(),
          const SizedBox(height: 28),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _buildNavColumn()),
              const SizedBox(width: 20),
              Expanded(child: _buildAvailabilityColumn()),
            ],
          ),
          const SizedBox(height: 24),
          _buildProjectColumn(),
        ],
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildBrandColumn(),
        const SizedBox(height: 28),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(flex: 2, child: _buildNavColumn()),
            const SizedBox(width: 24),
            Expanded(flex: 3, child: _buildAvailabilityColumn()),
            const SizedBox(width: 24),
            Expanded(flex: 3, child: _buildProjectColumn()),
          ],
        ),
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
              width: 32,
              height: 32,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: GitaColors.crimson,
              ),
              padding: const EdgeInsets.all(2.5),
              child: Image.asset(
                'assets/img2.png',
                fit: BoxFit.contain,
                filterQuality: FilterQuality.medium,
              ),
            ),
            const SizedBox(width: 10),
            const Text(
              'Bhagavad Gita',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: GitaColors.textOnDark,
                letterSpacing: 0.2,
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        const Text(
          'Revered Telugu rendition sung by Sri Ghantasala Venkateswara Rao.',
          style: TextStyle(
            fontSize: 13.5,
            color: Color(0xFFEDE4D8),
            height: 1.5,
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          'Designed as a distraction-free devotional listening experience across Web and Android.',
          style: TextStyle(
            fontSize: 12.5,
            color: Color(0xFFB0A092),
            height: 1.45,
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

  Widget _buildAvailabilityColumn() {
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
        const Text(
          'Desktop & iOS (Planned)',
          style: TextStyle(
            fontSize: 13.5,
            fontWeight: FontWeight.w400,
            color: Color(0xFF8A7C70),
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
        _DeveloperLink(
          label: 'PrasheelVarma',
          onTap: () => launchUrlSafely(_githubProfileUrl),
        ),
        const SizedBox(height: 10),
        _FooterLink(
          label: 'GitHub Repository',
          onTap: () => launchUrlSafely(_githubRepoUrl),
        ),
        const SizedBox(height: 10),
        _FooterLink(
          label: 'Releases & Downloads',
          onTap: () => launchUrlSafely(_releasesUrl),
        ),
      ],
    );
  }

  Widget _buildBottomRow() {
    return Wrap(
      alignment: WrapAlignment.start,
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 28,
      runSpacing: 8,
      children: [
        Text(
          '© ${DateTime.now().year} Bhagavad Gita Project',
          style: const TextStyle(
            fontSize: 12.5,
            color: Color(0xFF8D7F72),
          ),
        ),
        _DevelopedByLink(
          onTap: () => launchUrlSafely(_githubProfileUrl),
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
      style: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w700,
        color: Color(0xFFB0A092),
        letterSpacing: 0.6,
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
            fontSize: 13.5,
            fontWeight: FontWeight.w500,
            color: _isHovered
                ? const Color(0xFFFFD54F)
                : const Color(0xFFEDE4D8),
            decoration: _isHovered ? TextDecoration.underline : null,
            decorationColor: const Color(0xFFFFD54F),
          ),
        ),
      ),
    );
  }
}

class _DeveloperLink extends StatefulWidget {
  final String label;
  final VoidCallback onTap;

  const _DeveloperLink({required this.label, required this.onTap});

  @override
  State<_DeveloperLink> createState() => _DeveloperLinkState();
}

class _DeveloperLinkState extends State<_DeveloperLink> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    const goldColor = Color(0xFFFFD54F);
    const hoverGold = Color(0xFFFFE082);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.person,
              size: 15,
              color: _isHovered ? hoverGold : goldColor,
            ),
            const SizedBox(width: 6),
            Text(
              widget.label,
              style: TextStyle(
                fontSize: 13.5,
                fontWeight: FontWeight.w700,
                color: _isHovered ? hoverGold : goldColor,
                decoration: _isHovered ? TextDecoration.underline : null,
                decorationColor: hoverGold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DevelopedByLink extends StatefulWidget {
  final VoidCallback onTap;

  const _DevelopedByLink({required this.onTap});

  @override
  State<_DevelopedByLink> createState() => _DevelopedByLinkState();
}

class _DevelopedByLinkState extends State<_DevelopedByLink> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Text.rich(
          TextSpan(
            text: 'Developed by ',
            style: const TextStyle(
              fontSize: 12.5,
              color: Color(0xFF8D7F72),
            ),
            children: [
              TextSpan(
                text: 'PrasheelVarma',
                style: TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w600,
                  color: _isHovered
                      ? const Color(0xFFFFD54F)
                      : const Color(0xFFD6C8B8),
                  decoration: _isHovered ? TextDecoration.underline : null,
                  decorationColor: const Color(0xFFFFD54F),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
