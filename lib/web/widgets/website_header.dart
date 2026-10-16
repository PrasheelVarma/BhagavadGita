import 'package:flutter/material.dart';

import '../theme.dart';
import '../utils/url_launcher_helper.dart';

/// Website header — professional product sticky navigation bar.
class WebsiteHeader extends StatelessWidget {
  final String currentRoute;
  final VoidCallback onNavigateHome;
  final VoidCallback onNavigatePlayer;
  final VoidCallback onNavigateAbout;
  final VoidCallback onNavigateContact;

  const WebsiteHeader({
    super.key,
    required this.currentRoute,
    required this.onNavigateHome,
    required this.onNavigatePlayer,
    required this.onNavigateAbout,
    required this.onNavigateContact,
  });

  static const String _githubRepoUrl =
      'https://github.com/PrasheelVarma/BhagavadGita';

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < GitaLayout.mobileBreakpoint;
    final isPlayer = currentRoute == '/player';

    return Container(
      height: GitaLayout.headerHeight,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.96),
        border: const Border(
          bottom: BorderSide(
            color: Color(0xFFEEE5DB),
            width: 1,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: GitaLayout.maxContentWidth + 96),
          child: Padding(
            padding: GitaLayout.responsivePadding(screenWidth),
            child: Row(
              children: [
                // Logo / Brand
                _buildLogo(),
                const Spacer(),
                // Navigation
                if (isMobile) ...[
                  if (!isPlayer) ...[
                    _buildQuickPlayButton(),
                    const SizedBox(width: 8),
                  ],
                  _buildMobileMenu(context),
                ] else
                  _buildDesktopNav(isPlayer),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onNavigateHome,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 42,
              height: 42,
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
                    color: GitaColors.crimson.withValues(alpha: 0.22),
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Bhagavad Gita',
                      style: TextStyle(
                        fontSize: 16.5,
                        fontWeight: FontWeight.w800,
                        color: GitaColors.crimson,
                        letterSpacing: 0.3,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: GitaColors.ivory,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          color: GitaColors.peach,
                          width: 0.8,
                        ),
                      ),
                      child: const Text(
                        'v1.0',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: GitaColors.vermillion,
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  'Telugu • Sri Ghantasala',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: GitaColors.textLight.withValues(alpha: 0.85),
                    letterSpacing: 0.2,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickPlayButton() {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onNavigatePlayer,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: GitaColors.red,
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.play_arrow_rounded, color: Colors.white, size: 16),
              SizedBox(width: 4),
              Text(
                'Play',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopNav(bool isPlayer) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _NavLink(
          label: 'Home',
          isActive: currentRoute == '/',
          onTap: onNavigateHome,
        ),
        const SizedBox(width: 24),
        _NavLink(
          label: 'Player',
          isActive: currentRoute == '/player',
          onTap: onNavigatePlayer,
        ),
        const SizedBox(width: 24),
        _NavLink(
          label: 'About',
          isActive: currentRoute == '/about',
          onTap: onNavigateAbout,
        ),
        const SizedBox(width: 24),
        _NavLink(
          label: 'Contact',
          isActive: currentRoute == '/contact',
          onTap: onNavigateContact,
        ),
        const SizedBox(width: 24),
        // Action Button: Open Player (if on other pages)
        if (!isPlayer) ...[
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: onNavigatePlayer,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [GitaColors.red, GitaColors.crimson],
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: GitaColors.red.withValues(alpha: 0.25),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.play_arrow_rounded, color: Colors.white, size: 18),
                    SizedBox(width: 6),
                    Text(
                      'Launch Player',
                      style: TextStyle(
                        fontSize: 13.5,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 14),
        ],
        // GitHub Repository icon button
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () => launchUrlSafely(_githubRepoUrl),
            child: Container(
              padding: const EdgeInsets.all(7),
              decoration: BoxDecoration(
                color: const Color(0xFFF7F4EE),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: const Color(0xFFE4DAD0),
                  width: 1,
                ),
              ),
              child: const Icon(
                Icons.code_rounded,
                size: 18,
                color: GitaColors.textDark,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMobileMenu(BuildContext context) {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.menu_rounded, color: GitaColors.textDark, size: 24),
      offset: const Offset(0, GitaLayout.headerHeight - 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Colors.white,
      elevation: 8,
      onSelected: (value) {
        switch (value) {
          case '/':
            onNavigateHome();
            break;
          case '/player':
            onNavigatePlayer();
            break;
          case '/about':
            onNavigateAbout();
            break;
          case '/contact':
            onNavigateContact();
            break;
        }
      },
      itemBuilder: (context) => [
        _buildMenuItem('Home', '/', currentRoute == '/'),
        _buildMenuItem('Player', '/player', currentRoute == '/player'),
        _buildMenuItem('About', '/about', currentRoute == '/about'),
        _buildMenuItem('Contact', '/contact', currentRoute == '/contact'),
      ],
    );
  }

  PopupMenuItem<String> _buildMenuItem(String label, String route, bool isActive) {
    return PopupMenuItem<String>(
      value: route,
      child: Text(
        label,
        style: TextStyle(
          fontSize: 15,
          fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
          color: isActive ? GitaColors.crimson : GitaColors.textDark,
        ),
      ),
    );
  }
}

/// Individual navigation link with hover underline effect.
class _NavLink extends StatefulWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _NavLink({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  State<_NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<_NavLink> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final showUnderline = widget.isActive || _isHovered;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.label,
              style: GitaTextStyles.navLink.copyWith(
                color: widget.isActive
                    ? GitaColors.crimson
                    : _isHovered
                        ? GitaColors.red
                        : GitaColors.textDark,
                fontWeight: widget.isActive ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOut,
              height: 2.5,
              width: showUnderline ? 20 : 0,
              decoration: BoxDecoration(
                color: GitaColors.red,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
