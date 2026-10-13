import 'package:flutter/material.dart';

import '../theme.dart';

/// Website header — clean sticky navigation bar.
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
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.96),
        border: const Border(
          bottom: BorderSide(
            color: Color(0xFFEEE5DB),
            width: 1,
          ),
        ),
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
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: GitaColors.gold, width: 2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.08),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: ClipOval(
                child: Image.asset(
                  'assets/artwork.png',
                  width: 36,
                  height: 36,
                  fit: BoxFit.cover,
                ),
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
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                    color: GitaColors.crimson,
                    letterSpacing: 0.3,
                  ),
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
