import 'package:flutter/material.dart';

import '../theme.dart';
import '../utils/url_launcher_helper.dart';

/// Contact and Project Info page.
class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  static const String _githubProfileUrl = 'https://github.com/PrasheelVarma';
  static const String _githubRepoUrl =
      'https://github.com/PrasheelVarma/BhagavadGita-Website';
  static const String _githubIssuesUrl =
      'https://github.com/PrasheelVarma/BhagavadGita-Website/issues';

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
        const SizedBox(height: 32),
      ],
    );
  }

  Widget _buildPageHeader(bool isMobile, double screenWidth) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [GitaColors.ivory, GitaColors.cream],
        ),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints:
              const BoxConstraints(maxWidth: GitaLayout.maxContentWidth + 96),
          child: Padding(
            padding: GitaLayout.responsivePadding(screenWidth).copyWith(
              top: isMobile ? 44 : 64,
              bottom: isMobile ? 36 : 56,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Contact & Feedback',
                  style: GitaTextStyles.sectionHeading.copyWith(
                    fontSize: isMobile ? 28 : 36,
                  ),
                ),
                const SizedBox(height: 12),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 620),
                  child: Text(
                    'Questions, issue reports, or suggestions regarding the Bhagavad Gita website and Android application.',
                    style: GitaTextStyles.sectionSubheading.copyWith(
                      fontSize: isMobile ? 15 : 17,
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
      color: GitaColors.pureWhite,
      child: Center(
        child: ConstrainedBox(
          constraints:
              const BoxConstraints(maxWidth: GitaLayout.maxContentWidth + 96),
          child: Padding(
            padding: GitaLayout.responsivePadding(screenWidth).copyWith(
              top: 48,
              bottom: 48,
            ),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 820),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Contact Grid / Cards
                  if (isMobile)
                    Column(
                      children: [
                        _buildContactCard(
                          icon: Icons.person_rounded,
                          title: 'Developer',
                          subtitle:
                              'Maintained and developed by PrasheelVarma on GitHub.',
                          actionLabel: 'GitHub Profile',
                          url: _githubProfileUrl,
                        ),
                        const SizedBox(height: 20),
                        _buildContactCard(
                          icon: Icons.bug_report_rounded,
                          title: 'Issue Tracker',
                          subtitle:
                              'Report bugs, audio playback issues, or UI defects on GitHub.',
                          actionLabel: 'Open Issues',
                          url: _githubIssuesUrl,
                        ),
                        const SizedBox(height: 20),
                        _buildContactCard(
                          icon: Icons.code_rounded,
                          title: 'Source Code',
                          subtitle:
                              'Explore the open-source repository and contributing guidelines.',
                          actionLabel: 'View Repository',
                          url: _githubRepoUrl,
                        ),
                      ],
                    )
                  else
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: _buildContactCard(
                            icon: Icons.person_rounded,
                            title: 'Developer',
                            subtitle:
                                'Maintained and developed by PrasheelVarma on GitHub.',
                            actionLabel: 'GitHub Profile',
                            url: _githubProfileUrl,
                          ),
                        ),
                        const SizedBox(width: 24),
                        Expanded(
                          child: _buildContactCard(
                            icon: Icons.bug_report_rounded,
                            title: 'Issue Tracker',
                            subtitle:
                                'Report bugs, audio playback issues, or UI defects on GitHub.',
                            actionLabel: 'Open Issues',
                            url: _githubIssuesUrl,
                          ),
                        ),
                        const SizedBox(width: 24),
                        Expanded(
                          child: _buildContactCard(
                            icon: Icons.code_rounded,
                            title: 'Source Code',
                            subtitle:
                                'Explore the open-source repository and contributing guidelines.',
                            actionLabel: 'View Repository',
                            url: _githubRepoUrl,
                          ),
                        ),
                      ],
                    ),

                  const SizedBox(height: 48),

                  // Feedback Guidelines Card
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(isMobile ? 24 : 32),
                    decoration: BoxDecoration(
                      color: GitaColors.ivory.withValues(alpha: 0.6),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: GitaColors.peach.withValues(alpha: 0.7),
                        width: 1,
                      ),
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.info_outline_rounded,
                              size: 22,
                              color: GitaColors.crimson,
                            ),
                            SizedBox(width: 12),
                            Text(
                              'Feedback & Contributions',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: GitaColors.textDark,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 14),
                        Text(
                          'If you encounter playback anomalies on specific browsers or Android versions, or have suggestions for the devotional player controls, opening a GitHub issue with your device and browser specifications is the most direct way to get it resolved.',
                          style: GitaTextStyles.bodyText,
                        ),
                        SizedBox(height: 12),
                        Text(
                          'All code and documentation contributions are welcomed through pull requests on the main GitHub repository.',
                          style: GitaTextStyles.bodyText,
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

  Widget _buildContactCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required String actionLabel,
    required String url,
  }) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFEADBCE),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 16,
            offset: const Offset(0, 4),
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
              border: Border.all(
                color: GitaColors.peach.withValues(alpha: 0.8),
                width: 1,
              ),
            ),
            child: Icon(icon, color: GitaColors.crimson, size: 22),
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: GitaColors.textDark,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 14,
              color: GitaColors.textMedium.withValues(alpha: 0.9),
              height: 1.5,
            ),
          ),
          const SizedBox(height: 20),
          _ActionButton(
            label: actionLabel,
            onTap: () => launchUrlSafely(url),
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatefulWidget {
  final String label;
  final VoidCallback onTap;

  const _ActionButton({required this.label, required this.onTap});

  @override
  State<_ActionButton> createState() => _ActionButtonState();
}

class _ActionButtonState extends State<_ActionButton> {
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
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: _isHovered
                ? GitaColors.red.withValues(alpha: 0.1)
                : GitaColors.ivory,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: _isHovered ? GitaColors.red : GitaColors.peach,
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.label,
                style: TextStyle(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w600,
                  color: _isHovered ? GitaColors.red : GitaColors.crimson,
                ),
              ),
              const SizedBox(width: 6),
              Icon(
                Icons.open_in_new_rounded,
                size: 14,
                color: _isHovered ? GitaColors.red : GitaColors.crimson,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
