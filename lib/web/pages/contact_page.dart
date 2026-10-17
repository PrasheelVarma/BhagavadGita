import 'package:flutter/material.dart';

import '../theme.dart';
import '../utils/url_launcher_helper.dart';

/// Contact and Project Info page.
/// Provides honest feedback paths, issue reporting, and clear repository terms.
class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  static const String _githubProfileUrl = 'https://github.com/PrasheelVarma';
  static const String _githubRepoUrl =
      'https://github.com/PrasheelVarma/BhagavadGita';
  static const String _githubIssuesUrl =
      'https://github.com/PrasheelVarma/BhagavadGita/issues';

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < GitaLayout.mobileBreakpoint;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildPageHeader(isMobile, screenWidth),
        _buildContent(isMobile, screenWidth),
      ],
    );
  }

  Widget _buildPageHeader(bool isMobile, double screenWidth) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: GitaColors.ivory,
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
              top: isMobile ? 36 : 52,
              bottom: isMobile ? 32 : 44,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'GET IN TOUCH',
                  style: GitaTextStyles.eyebrow,
                ),
                const SizedBox(height: 10),
                Text(
                  'Contact & Feedback',
                  style: GitaTextStyles.sectionHeading.copyWith(
                    fontSize: isMobile ? 26 : 34,
                  ),
                ),
                const SizedBox(height: 8),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 640),
                  child: Text(
                    'Questions, defect reports, or suggestions regarding the Bhagavad Gita player.',
                    style: TextStyle(
                      fontSize: isMobile ? 14.5 : 16,
                      color: GitaColors.textMedium,
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(bool isMobile, double screenWidth) {
    return Container(
      width: double.infinity,
      color: GitaColors.cream,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: GitaLayout.maxContentWidth),
          child: Padding(
            padding: GitaLayout.responsivePadding(screenWidth).copyWith(
              top: 40,
              bottom: isMobile ? 48 : 64,
            ),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 780),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Contact Cards (Developer, Issue Tracker, Repository)
                  if (isMobile)
                    const Column(
                      children: [
                        _ContactCard(
                          icon: Icons.bug_report_outlined,
                          title: 'Issue Tracker',
                          subtitle:
                              'Report playback defects, browser-specific issues, or audio anomalies.',
                          actionLabel: 'Open Issues',
                          url: _githubIssuesUrl,
                        ),
                        SizedBox(height: 16),
                        _ContactCard(
                          icon: Icons.code_rounded,
                          title: 'Source Code',
                          subtitle:
                              'View the repository structure, documentation, and commit history.',
                          actionLabel: 'View Repository',
                          url: _githubRepoUrl,
                        ),
                        SizedBox(height: 16),
                        _ContactCard(
                          icon: Icons.person_outline_rounded,
                          title: 'Project Maintainer',
                          subtitle:
                              'Developed and maintained by PrasheelVarma on GitHub.',
                          actionLabel: 'GitHub Profile',
                          url: _githubProfileUrl,
                        ),
                      ],
                    )
                  else
                    const IntrinsicHeight(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: _ContactCard(
                              icon: Icons.bug_report_outlined,
                              title: 'Issue Tracker',
                              subtitle:
                                  'Report playback defects, browser-specific issues, or audio anomalies.',
                              actionLabel: 'Open Issues',
                              url: _githubIssuesUrl,
                            ),
                          ),
                          SizedBox(width: 18),
                          Expanded(
                            child: _ContactCard(
                              icon: Icons.code_rounded,
                              title: 'Source Code',
                              subtitle:
                                  'View the repository structure, documentation, and commit history.',
                              actionLabel: 'View Repository',
                              url: _githubRepoUrl,
                            ),
                          ),
                          SizedBox(width: 18),
                          Expanded(
                            child: _ContactCard(
                              icon: Icons.person_outline_rounded,
                              title: 'Project Maintainer',
                              subtitle:
                                  'Developed and maintained by PrasheelVarma on GitHub.',
                              actionLabel: 'GitHub Profile',
                              url: _githubProfileUrl,
                            ),
                          ),
                        ],
                      ),
                    ),

                  const SizedBox(height: 36),

                  // Feedback & Contribution Terms Card
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(22),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: GitaColors.surfaceBorder,
                        width: 1.2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.025),
                          blurRadius: 12,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.info_outline_rounded,
                              size: 19,
                              color: GitaColors.crimson,
                            ),
                            SizedBox(width: 10),
                            Text(
                              'Feedback & Contribution Terms',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: GitaColors.textDark,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12),
                        Text(
                          'If you encounter playback issues on specific devices or browsers, please open a GitHub issue with device and browser details.',
                          style: TextStyle(
                            fontSize: 14,
                            color: GitaColors.textMedium,
                            height: 1.55,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Code contributions may be proposed through GitHub pull requests. Note that this repository is available for public reference; independent commercial redistribution or re-publication is not permitted.',
                          style: TextStyle(
                            fontSize: 14,
                            color: GitaColors.textMedium,
                            height: 1.55,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ContactCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String actionLabel;
  final String url;

  const _ContactCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.actionLabel,
    required this.url,
  });

  @override
  State<_ContactCard> createState() => _ContactCardState();
}

class _ContactCardState extends State<_ContactCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: GitaColors.surfaceBorder,
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: _isHovered ? 0.05 : 0.025),
            blurRadius: _isHovered ? 14 : 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: GitaColors.ivory,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: GitaColors.peach, width: 0.8),
                ),
                child: Icon(widget.icon, color: GitaColors.crimson, size: 20),
              ),
              const SizedBox(height: 14),
              Text(
                widget.title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: GitaColors.textDark,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                widget.subtitle,
                style: const TextStyle(
                  fontSize: 13,
                  color: GitaColors.textMedium,
                  height: 1.45,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          MouseRegion(
            cursor: SystemMouseCursors.click,
            onEnter: (_) => setState(() => _isHovered = true),
            onExit: (_) => setState(() => _isHovered = false),
            child: GestureDetector(
              onTap: () => launchUrlSafely(widget.url),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    widget.actionLabel,
                    style: TextStyle(
                      fontSize: 13.5,
                      fontWeight: FontWeight.w700,
                      color: GitaColors.crimson,
                      decoration: _isHovered ? TextDecoration.underline : null,
                      decorationColor: GitaColors.crimson,
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Icon(
                    Icons.open_in_new_rounded,
                    size: 13,
                    color: GitaColors.crimson,
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
