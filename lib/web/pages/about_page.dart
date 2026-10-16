import 'package:flutter/material.dart';

import '../theme.dart';
import '../utils/url_launcher_helper.dart';

/// About page — project introduction, scriptural context with the 18-chapter
/// educational guide, rendition details, and attribution.
class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

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
        color: GitaColors.warmWhite,
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
                  'ABOUT THE PROJECT',
                  style: GitaTextStyles.eyebrow,
                ),
                const SizedBox(height: 10),
                Text(
                  'About This Project',
                  style: GitaTextStyles.sectionHeading.copyWith(
                    fontSize: isMobile ? 26 : 34,
                  ),
                ),
                const SizedBox(height: 8),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 680),
                  child: Text(
                    'Purpose, platform architecture, scriptural context, and cultural attribution for the Bhagavad Gita player.',
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
      color: GitaColors.linen,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: GitaLayout.maxContentWidth),
          child: Padding(
            padding: GitaLayout.responsivePadding(screenWidth).copyWith(
              top: 40,
              bottom: 48,
            ),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 780),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 1. The Recording Section
                  _buildSection(
                    title: 'The Telugu Rendition',
                    children: [
                      const _Paragraph(
                        'This application is dedicated to the widely cherished Telugu Bhagavad Gita '
                        'audio rendition by playback singer and composer Sri Ghantasala Venkateswara Rao. '
                        'Rendered with deep feeling and clarity, the recording features selected Sanskrit slokas '
                        'paired with accessible Telugu commentary and explanation.',
                      ),
                      const _Paragraph(
                        'For generations of Telugu-speaking listeners, this recital has served as a familiar '
                        'and beloved introduction to the wisdom of the scripture.',
                      ),
                    ],
                  ),
                  const SizedBox(height: 36),

                  // 2. Purpose Section
                  _buildSection(
                    title: 'Project Purpose',
                    children: [
                      const _Paragraph(
                        'The objective of this project is to provide a clean, dignified, and distraction-free '
                        'listening player. Devotional audio on general streaming platforms is often flanked '
                        'by advertising interruptions, algorithmic recommendations, and social feeds.',
                      ),
                      const _Paragraph(
                        'This project eliminates those distractions entirely. It requires no user account, '
                        'carries no advertisements, and runs without tracking telemetry.',
                      ),
                    ],
                  ),
                  const SizedBox(height: 36),

                  // 3. Platform Separation Section
                  _buildSection(
                    title: 'Web and Android Platforms',
                    children: [
                      const _Paragraph(
                        'The application provides two complementary ways to listen, each designed for its environment:',
                      ),
                      const _BulletPoint(
                        title: 'Web Application:',
                        description:
                            'Enables immediate playback directly inside any modern web browser without downloading or installing anything. Playback continues uninterrupted across page navigation within the site.',
                      ),
                      const _BulletPoint(
                        title: 'Native Android App:',
                        description:
                            'Bundles the complete audio file directly inside the application package (~27 MB). Once installed, it operates fully offline without an internet connection, integrating background audio services, lock-screen controls, and system notification controls.',
                      ),
                    ],
                  ),
                  const SizedBox(height: 36),

                  // 4. Educational 18-Chapter Guide
                  _buildSection(
                    title: 'The 18 Chapters of the Bhagavad Gita',
                    children: [
                      const _Paragraph(
                        'The Bhagavad Gita is an integral dialogue within the Bhishma Parva of the '
                        'Mahabharata, unfolding across 18 chapters on the sacred battlefield of Kurukshetra. '
                        'This educational guide summarizes the core spiritual themes of each chapter for study '
                        'and contemplative reference.',
                      ),
                      const SizedBox(height: 8),
                      _buildNote(
                        'Scope of the Recording: This chapter guide is provided for educational and scriptural context. '
                        'Sri Ghantasala’s revered ~73-minute audio recording is a condensed devotional rendition '
                        'presenting selected core slokas and commentary across these teachings, rather than an '
                        'unabridged recitation of all 700 verses.',
                      ),
                      const SizedBox(height: 18),
                      _buildChapterTable(isMobile),
                    ],
                  ),
                  const SizedBox(height: 36),

                  // 5. Audio Attribution
                  _buildSection(
                    title: 'Audio Attribution',
                    children: [
                      _buildInfoCard(
                        icon: Icons.mic_external_on_rounded,
                        title: 'Vocal Performance',
                        content:
                            'Recitation and commentary by Sri Ghantasala Venkateswara Rao.',
                      ),
                      const SizedBox(height: 12),
                      _buildNote(
                        'The project maintainer does not claim ownership of the audio recording. '
                        'Full credit is given to Sri Ghantasala Venkateswara Rao for his iconic recitation. '
                        'The recording remains subject to the rights of its respective copyright owners.',
                      ),
                    ],
                  ),
                  const SizedBox(height: 36),

                  // 6. Technology Section
                  _buildSection(
                    title: 'Technology & Architecture',
                    children: [
                      const _Paragraph(
                        'Built cross-platform using Flutter and Dart. The audio engine is powered by '
                        'just_audio, with just_audio_background and audio_session handling Android system '
                        'notifications, lock-screen controls, and audio focus management.',
                      ),
                    ],
                  ),
                  const SizedBox(height: 36),

                  // 7. Code Usage & Repository
                  _buildSection(
                    title: 'Repository & Code Usage',
                    children: [
                      const _Paragraph(
                        'This repository is publicly available for viewing and reference. Proposals, '
                        'bug reports, and contributions may be submitted via GitHub issues or pull requests. '
                        'No license is granted for general reuse, modification, or independent redistribution '
                        'of the project source code.',
                      ),
                      const SizedBox(height: 12),
                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: () => launchUrlSafely(_githubRepoUrl),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.code_rounded,
                                size: 17,
                                color: GitaColors.crimson,
                              ),
                              SizedBox(width: 8),
                              Text(
                                'github.com/PrasheelVarma/BhagavadGita',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: GitaColors.crimson,
                                ),
                              ),
                            ],
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
            fontSize: 21,
            fontWeight: FontWeight.w700,
            color: GitaColors.textDark,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          width: 32,
          height: 2.5,
          decoration: BoxDecoration(
            color: GitaColors.crimson,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(height: 16),
        ...children,
      ],
    );
  }

  Widget _buildChapterTable(bool isMobile) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: GitaColors.surfaceBorder, width: 1.2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.025),
            blurRadius: 12,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: Column(
          children: [
            // Table Header on desktop
            if (!isMobile)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                color: GitaColors.warmWhite,
                child: const Row(
                  children: [
                    SizedBox(
                      width: 44,
                      child: Text(
                        'CH.',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: GitaColors.textLight,
                          letterSpacing: 0.8,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Text(
                        'CHAPTER & TELUGU NAME',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: GitaColors.textLight,
                          letterSpacing: 0.8,
                        ),
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      flex: 6,
                      child: Text(
                        'SPIRITUAL THEME',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: GitaColors.textLight,
                          letterSpacing: 0.8,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

            // 18 Chapter Rows
            for (int i = 0; i < _chapters.length; i++) ...[
              if (i > 0 || !isMobile)
                Container(
                  height: 1,
                  color: GitaColors.borderLight,
                ),
              _ChapterRow(
                item: _chapters[i],
                isMobile: isMobile,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String content,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: GitaColors.surfaceBorder,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: GitaColors.ivory,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: GitaColors.peach, width: 0.8),
            ),
            child: Icon(icon, size: 20, color: GitaColors.crimson),
          ),
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
                  style: const TextStyle(
                    fontSize: 13.5,
                    color: GitaColors.textMedium,
                    height: 1.45,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNote(String text) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: GitaColors.warmWhite,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: GitaColors.surfaceBorder,
          width: 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.info_outline_rounded,
            size: 18,
            color: GitaColors.crimson,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 13.5,
                color: GitaColors.textMedium,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  static const List<_ChapterItem> _chapters = [
    _ChapterItem(
      number: 1,
      name: 'Arjuna Vishada Yoga',
      teluguName: 'అర్జున విషాద యోగము',
      theme: 'The crisis of conscience and despondency of Arjuna on the Kurukshetra battlefield.',
    ),
    _ChapterItem(
      number: 2,
      name: 'Sankhya Yoga',
      teluguName: 'సాంఖ్య యోగము',
      theme: 'The eternal nature of the soul (Atman), moral duty, and equanimity in action.',
    ),
    _ChapterItem(
      number: 3,
      name: 'Karma Yoga',
      teluguName: 'కర్మ యోగము',
      theme: 'The path of selfless dedicated action performed without anxiety for results.',
    ),
    _ChapterItem(
      number: 4,
      name: 'Jnana Karma Sannyasa Yoga',
      teluguName: 'జ్ఞాన కర్మ సన్యాస యోగము',
      theme: 'The descending wisdom of divine avatars and the purifying flame of knowledge.',
    ),
    _ChapterItem(
      number: 5,
      name: 'Karma Sannyasa Yoga',
      teluguName: 'కర్మ సన్యాస యోగము',
      theme: 'Harmonizing active external duty with serene inner detachment.',
    ),
    _ChapterItem(
      number: 6,
      name: 'Dhyana Yoga',
      teluguName: 'ధ్యాన యోగము',
      theme: 'The discipline of steady meditation, physical posture, and tranquil mental mastery.',
    ),
    _ChapterItem(
      number: 7,
      name: 'Jnana Vijnana Yoga',
      teluguName: 'జ్ఞాన విజ్ఞాన యోగము',
      theme: 'Comprehension of the divine reality underlying both spiritual and material energies.',
    ),
    _ChapterItem(
      number: 8,
      name: 'Akshara Brahma Yoga',
      teluguName: 'అక్షర పరబ్రహ్మ యోగము',
      theme: 'The spiritual transition at life’s departure and constant remembrance of the Supreme.',
    ),
    _ChapterItem(
      number: 9,
      name: 'Raja Vidya Raja Guhya Yoga',
      teluguName: 'రాజవిద్యా రాజగుహ్య యోగము',
      theme: 'The sovereign science of unconditional devotion and personal divine grace.',
    ),
    _ChapterItem(
      number: 10,
      name: 'Vibhuti Yoga',
      teluguName: 'విభూతి యోగము',
      theme: 'The manifold divine splendors and manifestations across the created cosmos.',
    ),
    _ChapterItem(
      number: 11,
      name: 'Vishwarupa Sandarshana Yoga',
      teluguName: 'విశ్వరూప సందర్శన యోగము',
      theme: 'The majestic revelation of the universal cosmic form to Arjuna.',
    ),
    _ChapterItem(
      number: 12,
      name: 'Bhakti Yoga',
      teluguName: 'భక్తి యోగము',
      theme: 'The noble path of pure loving devotion and the attributes of an ideal seeker.',
    ),
    _ChapterItem(
      number: 13,
      name: 'Kshetra Kshetrajna Vibhaga Yoga',
      teluguName: 'క్షేత్ర క్షేత్రజ్ఞ విభాగ యోగము',
      theme: 'Discriminating between the mortal body (the field) and the immortal soul (the knower).',
    ),
    _ChapterItem(
      number: 14,
      name: 'Gunatraya Vibhaga Yoga',
      teluguName: 'గుణత్రయ విభాగ యోగము',
      theme: 'The mechanics of the three cosmic modes: Sattva (purity), Rajas (passion), and Tamas (inertia).',
    ),
    _ChapterItem(
      number: 15,
      name: 'Purushottama Yoga',
      teluguName: 'పురుషోత్తమ యోగము',
      theme: 'The eternal cosmic Tree of Life and the transcendence of the Supreme Person.',
    ),
    _ChapterItem(
      number: 16,
      name: 'Daivasura Sampad Vibhaga Yoga',
      teluguName: 'దైవాసుర సంపద్విభాగ యోగము',
      theme: 'Contrasting luminous virtues of the divine with the destructive qualities of ego.',
    ),
    _ChapterItem(
      number: 17,
      name: 'Shraddhatraya Vibhaga Yoga',
      teluguName: 'శ్రద్ధాత్రయ విభాగ యోగము',
      theme: 'The threefold division of faith, worship, dietary preferences, and charitable deeds.',
    ),
    _ChapterItem(
      number: 18,
      name: 'Moksha Sannyasa Yoga',
      teluguName: 'మోక్ష సన్యాస యోగము',
      theme: 'The culmination of spiritual freedom, total surrender (Saranagati), and radiant victory.',
    ),
  ];
}

class _ChapterItem {
  final int number;
  final String name;
  final String teluguName;
  final String theme;

  const _ChapterItem({
    required this.number,
    required this.name,
    required this.teluguName,
    required this.theme,
  });
}

class _ChapterRow extends StatelessWidget {
  final _ChapterItem item;
  final bool isMobile;

  const _ChapterRow({
    required this.item,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    if (isMobile) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                _buildBadge(),
                const SizedBox(width: 12),
                Expanded(
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
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: GitaColors.crimson,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.only(left: 42),
              child: Text(
                item.theme,
                style: const TextStyle(
                  fontSize: 13,
                  color: GitaColors.textMedium,
                  height: 1.45,
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 44,
            child: _buildBadge(),
          ),
          Expanded(
            flex: 4,
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
                const SizedBox(height: 1),
                Text(
                  item.teluguName,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: GitaColors.crimson,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            flex: 6,
            child: Text(
              item.theme,
              style: const TextStyle(
                fontSize: 13.5,
                color: GitaColors.textMedium,
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBadge() {
    return Container(
      width: 30,
      height: 30,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: GitaColors.ivory,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: GitaColors.peach, width: 0.8),
      ),
      child: Text(
        '${item.number}',
        style: const TextStyle(
          fontSize: 12.5,
          fontWeight: FontWeight.w700,
          color: GitaColors.crimson,
        ),
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
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 15,
          color: GitaColors.textMedium,
          height: 1.6,
        ),
      ),
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
      padding: const EdgeInsets.only(bottom: 10, left: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 7, right: 10),
            width: 5,
            height: 5,
            decoration: const BoxDecoration(
              color: GitaColors.crimson,
              shape: BoxShape.circle,
            ),
          ),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: const TextStyle(
                  fontSize: 14.5,
                  color: GitaColors.textMedium,
                  height: 1.55,
                ),
                children: [
                  TextSpan(
                    text: '$title ',
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      color: GitaColors.textDark,
                    ),
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
