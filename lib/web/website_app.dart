import 'package:flutter/material.dart';

import '../services/audio_player_controller.dart';
import 'pages/about_page.dart';
import 'pages/contact_page.dart';
import 'pages/home_page.dart';
import 'pages/player_page.dart';
import 'theme.dart';
import 'widgets/website_footer.dart';
import 'widgets/website_header.dart';

/// Root widget for the Bhagavad Gita website.
///
/// Manages client-side navigation between Home, Player, About, and Contact pages.
/// Owns the shared AudioPlayerController so audio continues
/// playing across page transitions.
class WebsiteApp extends StatefulWidget {
  const WebsiteApp({super.key});

  @override
  State<WebsiteApp> createState() => _WebsiteAppState();
}

class _WebsiteAppState extends State<WebsiteApp> {
  String _currentRoute = '/';
  late final AudioPlayerController _playerController;
  bool _audioInitialized = false;

  @override
  void initState() {
    super.initState();
    _playerController = AudioPlayerController();
  }

  @override
  void dispose() {
    _playerController.dispose();
    super.dispose();
  }

  Future<void> _ensureAudioInitialized() async {
    if (_audioInitialized) return;
    _audioInitialized = true;
    try {
      await _playerController.initialize('assets/audio.m4a');
    } catch (e) {
      debugPrint('Error initializing audio: $e');
    }
  }

  void _navigateTo(String route) {
    if (route == _currentRoute) return;

    // Initialize audio when navigating to the player
    if (route == '/player') {
      _ensureAudioInitialized();
    }

    setState(() {
      _currentRoute = route;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isPlayerPage = _currentRoute == '/player';

    return Scaffold(
      backgroundColor: GitaColors.pureWhite,
      body: Column(
        children: [
          // Sticky header — shown across all pages
          WebsiteHeader(
            currentRoute: _currentRoute,
            onNavigateHome: () => _navigateTo('/'),
            onNavigatePlayer: () => _navigateTo('/player'),
            onNavigateAbout: () => _navigateTo('/about'),
            onNavigateContact: () => _navigateTo('/contact'),
          ),
          // Page content
          Expanded(
            child: _buildCurrentPage(isPlayerPage),
          ),
        ],
      ),
    );
  }

  Widget _buildCurrentPage(bool isPlayerPage) {
    // Player page fills available space without bottom footer
    if (isPlayerPage) {
      return PlayerPage(controller: _playerController);
    }

    return switch (_currentRoute) {
      '/about' => _PageWithFooter(
          onNavigateHome: () => _navigateTo('/'),
          onNavigatePlayer: () => _navigateTo('/player'),
          onNavigateAbout: () => _navigateTo('/about'),
          onNavigateContact: () => _navigateTo('/contact'),
          child: const AboutPage(),
        ),
      '/contact' => _PageWithFooter(
          onNavigateHome: () => _navigateTo('/'),
          onNavigatePlayer: () => _navigateTo('/player'),
          onNavigateAbout: () => _navigateTo('/about'),
          onNavigateContact: () => _navigateTo('/contact'),
          child: const ContactPage(),
        ),
      _ => _PageWithFooter(
          onNavigateHome: () => _navigateTo('/'),
          onNavigatePlayer: () => _navigateTo('/player'),
          onNavigateAbout: () => _navigateTo('/about'),
          onNavigateContact: () => _navigateTo('/contact'),
          child: HomePage(onOpenPlayer: () => _navigateTo('/player')),
        ),
    };
  }
}

/// Wraps a scrollable page body with the website footer appended.
/// Fixes flex/overflow issues by providing a natural scrolling viewport
/// without unbounded intrinsic height traps.
class _PageWithFooter extends StatelessWidget {
  final Widget child;
  final VoidCallback onNavigateHome;
  final VoidCallback onNavigatePlayer;
  final VoidCallback onNavigateAbout;
  final VoidCallback onNavigateContact;

  const _PageWithFooter({
    required this.child,
    required this.onNavigateHome,
    required this.onNavigatePlayer,
    required this.onNavigateAbout,
    required this.onNavigateContact,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                child,
                WebsiteFooter(
                  onNavigateHome: onNavigateHome,
                  onNavigatePlayer: onNavigatePlayer,
                  onNavigateAbout: onNavigateAbout,
                  onNavigateContact: onNavigateContact,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
