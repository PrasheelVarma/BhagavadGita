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
  static const String _githubIssuesUrl =
      'https://github.com/PrasheelVarma/BhagavadGita/issues';

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < GitaLayout.mobileBreakpoint;

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
                if (isMobile) _buildMobileLayout() else _buildDesktopLayout(),
                const SizedBox(height: 32),
                Container(
                  height: 1,
                  color: Colors.white.withValues(alpha: 0.12),
                ),
                const SizedBox(height: 20),
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
        // Brand & Cultural Attribution
        Expanded(flex: 5, child: _buildBrandColumn()),
        const SizedBox(width: 48),
        // Navigation links
        Expanded(flex: 3, child: _buildNavColumn()),
        const SizedBox(width: 32),
        // Project & Release links
        Expanded(flex: 4, child: _buildProjectColumn()),
      ],
    );
  }

  Widget _buildMobileLayout() {
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
            Expanded(child: _buildProjectColumn()),
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
        const SizedBox(height: 12),
        const Text(
          'A quiet, distraction-free player for the revered Telugu recitation sung by Sri Ghantasala Venkateswara Rao.',
          style: TextStyle(
            fontSize: 13.5,
            color: Color(0xFFE8DCD0),
            height: 1.5,
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          'Full credit is given to Sri Ghantasala Venkateswara Rao. The audio recording remains the property of its respective copyright owners.',
          style: TextStyle(
            fontSize: 12,
            color: Color(0xFFC7B8AA),
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

  Widget _buildProjectColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _FooterHeading('Project & Releases'),
        const SizedBox(height: 14),
        _FooterLink(
          label: 'Android APK Release',
          onTap: () => launchUrlSafely(_androidReleaseUrl),
        ),
        const SizedBox(height: 10),
        _FooterLink(
          label: 'GitHub Repository',
          onTap: () => launchUrlSafely(_githubRepoUrl),
        ),
        const SizedBox(height: 10),
        _FooterLink(
          label: 'Issue Tracker & Feedback',
          onTap: () => launchUrlSafely(_githubIssuesUrl),
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
          style: const TextStyle(
            fontSize: 12.5,
            color: Color(0xFFB0A090),
          ),
        ),
        _FooterLink(
          label: 'Maintained by PrasheelVarma on GitHub',
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
        color: Color(0xFFE5C158),
        letterSpacing: 0.8,
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
