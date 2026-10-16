import 'package:flutter/material.dart';

import '../theme.dart';

/// Clean, dignified sticky navigation header for the Bhagavad Gita website.
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

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < GitaLayout.mobileBreakpoint;

    return Container(
      height: GitaLayout.headerHeight,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: Color(0xFFEBE3D8),
            width: 1,
          ),
        ),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: GitaLayout.maxContentWidth),
          child: Padding(
            padding: GitaLayout.responsivePadding(screenWidth),
            child: Row(
              children: [
                // Brand
                _buildLogo(),
                const Spacer(),
                // Navigation
                if (isMobile)
                  _buildMobileMenu(context)
                else
                  _buildDesktopNav(),
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
              width: 38,
              height: 38,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: GitaColors.crimson,
              ),
              padding: const EdgeInsets.all(3),
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
                const Text(
                  'Bhagavad Gita',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: GitaColors.crimson,
                    letterSpacing: 0.2,
                  ),
                ),
                Text(
                  'Telugu • Sri Ghantasala',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: GitaColors.textLight.withValues(alpha: 0.9),
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

  Widget _buildDesktopNav() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _NavLink(
          label: 'Home',
          isActive: currentRoute == '/',
          onTap: onNavigateHome,
        ),
        const SizedBox(width: 28),
        _NavLink(
          label: 'Player',
          isActive: currentRoute == '/player',
          onTap: onNavigatePlayer,
        ),
        const SizedBox(width: 28),
        _NavLink(
          label: 'About',
          isActive: currentRoute == '/about',
          onTap: onNavigateAbout,
        ),
        const SizedBox(width: 28),
        _NavLink(
          label: 'Contact',
          isActive: currentRoute == '/contact',
          onTap: onNavigateContact,
        ),
      ],
    );
  }

  Widget _buildMobileMenu(BuildContext context) {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.menu_rounded, color: GitaColors.textDark, size: 24),
      offset: const Offset(0, GitaLayout.headerHeight - 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color: Colors.white,
      elevation: 4,
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
          fontSize: 14.5,
          fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
          color: isActive ? GitaColors.crimson : GitaColors.textDark,
        ),
      ),
    );
  }
}

/// Navigation link with clean active/hover indicators.
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
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
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
                          ? GitaColors.crimson
                          : GitaColors.textDark,
                  fontWeight: widget.isActive ? FontWeight.w700 : FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              AnimatedContainer(
                duration: const Duration(milliseconds: 160),
                curve: Curves.easeOut,
                height: 2,
                width: showUnderline ? 18 : 0,
                decoration: BoxDecoration(
                  color: GitaColors.crimson,
                  borderRadius: BorderRadius.circular(1),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
