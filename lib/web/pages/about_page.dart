import 'package:flutter/material.dart';

import '../theme.dart';
import '../utils/url_launcher_helper.dart';

/// About page — project introduction, rendition details, and acknowledgements.
class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  static const String _githubProfileUrl = 'https://github.com/PrasheelVarma';
  static const String _githubRepoUrl =
      'https://github.com/PrasheelVarma/BhagavadGita';

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < GitaLayout.mobileBreakpoint;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Page header
        _buildPageHeader(isMobile, screenWidth),
        // Content sections
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
                  'About This Project',
                  style: GitaTextStyles.sectionHeading.copyWith(
                    fontSize: isMobile ? 28 : 36,
                  ),
                ),
                const SizedBox(height: 12),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 640),
                  child: Text(
                    'Context, purpose, and technical foundation of the Bhagavad Gita player.',
                    style: GitaTextStyles.sectionSubheading.copyWith(
                      fontSize: isMobile ? 15 : 18,
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
              constraints: const BoxConstraints(maxWidth: 760),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // The Recording Section
                  _buildSection(
                    title: 'The Telugu Rendition',
                    children: [
                      const _Paragraph(
                        'This application features the widely revered Telugu Bhagavad Gita '
                        'audio rendered by legendary singer and composer Sri Ghantasala Venkateswara Rao. '
                        'Recorded with profound devotion and musical clarity, this timeless rendition '
                        'presents key verses alongside lucid Telugu commentary and explanations.',
                      ),
                      const _Paragraph(
                        'For generations of Telugu-speaking listeners, Sri Ghantasala’s recital '
                        'has been an accessible and deeply spiritual doorway into the wisdom of the scripture.',
                      ),
                    ],
                  ),
                  const SizedBox(height: 44),

                  // Purpose Section
                  _buildSection(
                    title: 'Project Purpose',
                    children: [
                      const _Paragraph(
                        'The goal of this project is to provide a clean, dignified, and distraction-free '
                        'player dedicated entirely to this recording. Many online platforms surround devotional '
                        'listening with advertisements, autoplay interruptions, social feeds, and recommendation algorithms.',
                      ),
                      const _Paragraph(
                        'This application deliberately eliminates all such distractions. It requires no user account, '
                        'contains zero advertisements or telemetry trackers, and focuses solely on uninterrupted audio playback.',
                      ),
                    ],
                  ),
                  const SizedBox(height: 44),

                  // Platform Separation Section
                  _buildSection(
                    title: 'Web & Android Experiences',
                    children: [
                      const _Paragraph(
                        'The project offers two tailored listening environments:',
                      ),
                      const _BulletPoint(
                        title: 'Web Application:',
                        description:
                            'Enables instant playback in any modern web browser without downloading or installing anything. Perfect for listening on desktops, laptops, or shared devices.',
                      ),
                      const _BulletPoint(
                        title: 'Native Android App:',
                        description:
                            'Bundles the audio directly inside the application, allowing fully offline playback anywhere without network access. Integrates native background playback, lock-screen media controls, and system audio focus.',
                      ),
                    ],
                  ),
                  const SizedBox(height: 44),

                  // Audio Credits
                  _buildSection(
                    title: 'Audio Credits',
                    children: [
                      _buildInfoCard(
                        icon: Icons.mic_external_on_rounded,
                        title: 'Vocal Rendition',
                        content:
                            'Sung by Sri Ghantasala Venkateswara Rao (Telugu recitation and commentary).',
                      ),
                      const SizedBox(height: 14),
                      _buildPlaceholderNote(
                        'The maintainer does not claim ownership of the audio recording. Full credit is given to Sri Ghantasala Venkateswara Rao for his vocal performance. The recording remains subject to the rights of its respective copyright owners.',
                      ),
                    ],
                  ),
                  const SizedBox(height: 44),

                  // Technology Section
                  _buildSection(
                    title: 'Technology & Architecture',
                    children: [
                      const _Paragraph(
                        'Built cross-platform using Flutter and Dart. Audio services are powered by '
                        'the just_audio ecosystem. The Android version incorporates audio_session '
                        'and just_audio_background for native notification management and background service lifecycle.',
                      ),
                    ],
                  ),
                  const SizedBox(height: 44),

                  // Code Usage & Repository
                  _buildSection(
                    title: 'Code Usage & Repository',
                    children: [
                      const _Paragraph(
                        'This repository is publicly available for viewing and reference. Contributions may be proposed through GitHub issues or pull requests.',
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                              onTap: () => launchUrlSafely(_githubRepoUrl),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(
                                    Icons.code_rounded,
                                    size: 18,
                                    color: GitaColors.crimson,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    'GitHub: PrasheelVarma/BhagavadGita',
                                    style: GitaTextStyles.bodyText.copyWith(
                                      color: GitaColors.crimson,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: () => launchUrlSafely(_githubProfileUrl),
                          child: Text(
                            'Developed by PrasheelVarma',
                            style: GitaTextStyles.bodyText.copyWith(
                              color: GitaColors.textLight,
                              fontSize: 14,
                            ),
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
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: GitaColors.textDark,
            height: 1.3,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          width: 36,
          height: 3,
          decoration: BoxDecoration(
            color: GitaColors.red,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(height: 18),
        ...children,
      ],
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String content,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: GitaColors.ivory.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: GitaColors.peach.withValues(alpha: 0.8),
          width: 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 22, color: GitaColors.crimson),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: GitaColors.textDark,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  content,
                  style: GitaTextStyles.bodyText.copyWith(
                    fontSize: 14,
                    color: GitaColors.textMedium,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlaceholderNote(String text) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF9F7F4),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color(0xFFE8DFD5),
          width: 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.info_outline_rounded,
            size: 18,
            color: GitaColors.textLight.withValues(alpha: 0.8),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: GitaTextStyles.bodyText.copyWith(
                fontSize: 13.5,
                color: GitaColors.textLight,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Paragraph extends StatelessWidget {
  final String text;

  const _Paragraph(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(text, style: GitaTextStyles.bodyText),
    );
  }
}

class _BulletPoint extends StatelessWidget {
  final String title;
  final String description;

  const _BulletPoint({required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, left: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 8, right: 10),
            width: 6,
            height: 6,
            decoration: const BoxDecoration(
              color: GitaColors.red,
              shape: BoxShape.circle,
            ),
          ),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: GitaTextStyles.bodyText,
                children: [
                  TextSpan(
                    text: '$title ',
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                  TextSpan(text: description),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
